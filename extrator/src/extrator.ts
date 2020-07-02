import { Connection } from 'typeorm';
import { autoInjectable, singleton } from 'tsyringe';
import axios, { AxiosResponse } from 'axios';
import { setTimeout } from 'timers';
import util from 'util';

import LeitorNetUrls, { LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ, LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT } from './leitor-net-urls';
import CategoryService from './service/category.service';
import CategoryDto from './dto/category.dto';
import DatabaseConfig from './config/database.config';
import MangaDto from './dto/manga.dto';
import MangaService from './service/manga.service';
import { MS_WAIT_BETWEEN_PAGES, DATA_PATH } from './config/general-craweler.config';
import { mkdir } from './util';
import ChapterService from './service/chapter.service';
import ChapterDto from './dto/chapter.dto';
import Manga from './entity/manga';
import Category from './entity/category';

const setTimeoutPromise = util.promisify(setTimeout);

@singleton()
@autoInjectable()
export default class Extrator {
  private connection: Connection;

  constructor(
    private leitorNetUrls: LeitorNetUrls,
    private categoryService: CategoryService,
    private mangaService: MangaService,
    private databaseConfig: DatabaseConfig,
    private chapterService: ChapterService,
  ) {
  }

  public async run(): Promise<void> {
    this.connection = await this.databaseConfig.createConnection();

    const readCategories = false;

    try {
      await this.createNecessaryFolders();
      if (readCategories) {
        await this.readCategories();
        await this.readMangasByCategories();
      } else {
        await this.readMangas();
      }
    } finally {
      this.connection.close();
    }
  }

  private async createNecessaryFolders(): Promise<void> {
    await mkdir(DATA_PATH, { recursive: true });
  }

  private async readCategories(): Promise<void> {
    if (await this.categoryService.isTimeToCralwer()) {
      const response = await axios.get(this.leitorNetUrls.getCategoriesUrl(), {
        headers: LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ,
      });
      const categories = response.data.categories_list;

      for (const category of categories) {
        await this.categoryService.createOrGet(category as CategoryDto);
      }

      await this.categoryService.saveEndOfCrawler();
      return setTimeoutPromise(MS_WAIT_BETWEEN_PAGES);
    }
    console.info('Categories skipped');
    return null;
  }

  private doRequestForMangas(page: number, category: Category): Promise<AxiosResponse<any>> {
    return axios.get(this.leitorNetUrls.getSeriesUrl(page, category.id), {
      headers: LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ,
    });
  }

  private async saveMangaDto(mangaDto: MangaDto) {
    const manga = await this.mangaService.createOrGet(mangaDto as MangaDto);

    if (manga.justGotSaved || (await this.mangaService.areChaptersAvailable(manga, mangaDto))) {
      await this.readChapters(manga);

      console.clear();
      console.log(`${new Date().toISOString()} - '${manga.name}' saved :)`);

      // await setTimeoutPromise(MS_WAIT_BETWEEN_PAGES);
    }

    return manga;
  }

  private async readMangasByCategories(): Promise<void> {
    if (await this.mangaService.isTimeToCralwer()) {
      const categoryIdPageOnCrawlerBegin = await this.categoryService.getIdFromCurrentCategoryOnCrawler();

      const categoryIdOnCrawlerBegin = categoryIdPageOnCrawlerBegin ? categoryIdPageOnCrawlerBegin.categoryId : -1;

      const categories = await this.categoryService.getAllStartingOnId(categoryIdOnCrawlerBegin);

      for (const category of categories) {
        let page = category.id === categoryIdOnCrawlerBegin ? categoryIdPageOnCrawlerBegin.page : 1;

        await this.categoryService.setIdFromCurrentCategoryOnCrawler({
          categoryId: category.id,
          page,
        });

        let response = await this.doRequestForMangas(page, category);
        while (response.data.series.length > 0) {
          const mangasDto = response.data.series;

          for (const mangaDto of mangasDto) {
            await this.saveMangaDto(mangaDto);
          }

          console.log(`*** Page ${page} of '${category.name}' finished :)`);
          page += 1;
          response = await this.doRequestForMangas(page, category);

          await this.categoryService.setIdFromCurrentCategoryOnCrawler({
            categoryId: category.id,
            page,
          });
        }
        console.log(`/*/*/* Category '${category.name}' finished :)`);
      }

      this.categoryService.deleteIfExistisCurrentCategory();
      return this.mangaService.saveEndOfCrawler();
    }
    console.info('Mangas skipped');
    return null;
  }

  private async readMangas(): Promise<void> {
    if (await this.mangaService.isTimeToCralwer()) {
      const mangaIdPageOnCrawlerBegin = await this.mangaService.getIdFromCurrentMangaOnCrawler();
      let leitorNetMangaId = mangaIdPageOnCrawlerBegin != null ? mangaIdPageOnCrawlerBegin : 1;

      let is404 = false;

      do {
        this.mangaService.setIdFromCurrentMangaOnCrawler(leitorNetMangaId);

        try {
          const response = await this.doRequestForMangaPage(leitorNetMangaId);

          is404 = response.status === 404 && leitorNetMangaId > 10270;

          if (!is404) {
            const mangaDto = this.mangaService.fromResponse(leitorNetMangaId, response);

            if (mangaDto != null) {
              await this.saveMangaDto(mangaDto);
            }
          }
        } catch (err) {
          if (err == null || !err.isAxiosError || err.response.status !== 404) {
            throw err;
          }
        }

        leitorNetMangaId += 1;
      } while (!is404);

      // this.mangaService.deleteIfExistisCurrentManga();
    }
    console.info('Mangas skipped');
    return null;
  }

  private doRequestForMangaPage(leitorNetMangaId: number): Promise<AxiosResponse<any>> {
    return axios.get(this.leitorNetUrls.getMangaUrl(leitorNetMangaId), {
      headers: LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT,
    });
  }

  private doRequestForChapters(page: number, manga: Manga): Promise<AxiosResponse<any>> {
    return axios.get(this.leitorNetUrls.getChaptersListUrl(page, manga.leitorNetId), {
      headers: LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ,
    });
  }

  private async readChapters(manga: Manga) {
    let page = 1;
    let response = await this.doRequestForChapters(page, manga);

    while (response.data.chapters && response.data.chapters.length > 0) {
      const chaptersDto = response.data.chapters as ChapterDto[];

      for (const chapterDto of chaptersDto) {
        chapterDto.numberValue = this.chapterService.getNumberValue(chapterDto.number);
        const chapter = await this.chapterService.createOrGet(chapterDto, manga);
        if (chapter.justGotSaved) {
          console.log(`--- chapter ${chapterDto.number} of '${manga.name}' saved`);
        }
        // await setTimeoutPromise(MS_WAIT_BETWEEN_PAGES);
      }

      page += 1;
      response = await this.doRequestForChapters(page, manga);
    }
  }
}
