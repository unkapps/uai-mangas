import { Connection } from 'typeorm';
import { autoInjectable, singleton } from 'tsyringe';
import axios, { AxiosResponse } from 'axios';
import { setTimeout } from 'timers';
import util from 'util';

import LeitorNetUrls, { LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ } from './leitor-net-urls';
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

    try {
      await this.createNecessaryFolders();
      await this.readCategories();
      await this.readMangas();
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

  private async readMangas(): Promise<void> {
    if (await this.mangaService.isTimeToCralwer()) {
      const categoryIdPageOnCrawlerBegin = await this.categoryService.getIdFromCurrentCategoryOnCrawler();

      const categoryIdOnCrawlerBegin = categoryIdPageOnCrawlerBegin ? categoryIdPageOnCrawlerBegin.categoryId : -1;
      const pageOnCrawlerBegin = categoryIdPageOnCrawlerBegin ? categoryIdPageOnCrawlerBegin.page : 1;

      const categories = await this.categoryService.getAllStartingOnId(categoryIdOnCrawlerBegin);

      for (const category of categories) {
        let page = pageOnCrawlerBegin;
        await this.categoryService.setIdFromCurrentCategoryOnCrawler({
          categoryId: category.id,
          page,
        });

        let response = await this.doRequestForMangas(page, category);
        while (response.data.series.length > 0) {
          const mangasDto = response.data.series;

          for (const mangaDto of mangasDto) {
            const manga = await this.mangaService.createOrGet(mangaDto as MangaDto);

            if (manga.justGotSaved || (await this.mangaService.areChaptersAvailable(manga, mangaDto))) {
              await this.readChapters(manga);

              console.log(`${new Date().toISOString()} - '${manga.name}' saved :)`);

              await setTimeoutPromise(MS_WAIT_BETWEEN_PAGES);
            }
          }

          page += 1;
          response = await this.doRequestForMangas(page, category);
        }
      }

      return this.mangaService.saveEndOfCrawler();
    }
    console.info('Mangas skipped');
    return null;
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
      const chaptersDto = response.data.chapters;

      for (const chapterDto of chaptersDto) {
        await this.chapterService.createOrGet(chapterDto as ChapterDto, manga);
        console.log(`--- chapter ${chapterDto.number} of '${manga.name}' saved`);
        // await setTimeoutPromise(MS_WAIT_BETWEEN_PAGES);
      }

      page += 1;
      response = await this.doRequestForChapters(page, manga);
    }
  }
}
