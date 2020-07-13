import { autoInjectable, singleton } from 'tsyringe';
import { getConnection, EntityManager } from 'typeorm';
import { parse } from 'node-html-parser';
import slugify from 'slugify';
import { AxiosResponse } from 'axios';

import WaitBetween, { MINIMUM_HOURS_BETWEEN_CRAWLER_MANGA } from './wait-between';
import {
  fileExists,
  readFile,
  writeFile,
  unlink,
} from '../util';

import MangaDto from '../dto/manga.dto';
import Manga from '../entity/manga';
import CategoryService from './category.service';
import AuthorService from './author.service';
import { STATUS_CRAWLER_MANGA_FILE_PATH, CURRENT_MANGA_FILE_PATH } from '../config/general-craweler.config';
import generateUid from '../util/generator-id';
import ChapterService from './chapter.service';
import CategoryDto from '../dto/category.dto';

@singleton()
@autoInjectable()
export default class MangaService extends WaitBetween {
  constructor(
    private categoryService: CategoryService,
    private authorService: AuthorService,
    private chapterService: ChapterService,
  ) {
    super();
  }

  public async createOrGet(dto: MangaDto): Promise<Manga> {
    if (dto == null) {
      return null;
    }

    const connection = await getConnection();

    const mangaDatabase = await connection
      .getRepository(Manga)
      .createQueryBuilder('manga')
      .where('manga.name = :name', { name: dto.name })
      .orWhere('manga.leitor_net_id = :leitorNetId', { leitorNetId: dto.id_serie })
      .getOne();

    if (mangaDatabase) {
      // eslint-disable-next-line eqeqeq
      if (mangaDatabase.finished != dto.is_complete) {
        console.log(`Manga ${mangaDatabase.name} finished changed`);
        mangaDatabase.finished = dto.is_complete;

        return connection.transaction(async (manager) => {
          const manga = await manager.save(mangaDatabase);
          manga.justGotSaved = true;
          return manga;
        });
      }

      return mangaDatabase;
    }

    return connection.transaction(async (manager) => {
      const mangaDto = await this.dtoToEntity(dto, manager);
      if (mangaDto) {
        const manga = await manager.save(mangaDto);
        manga.justGotSaved = true;
        return manga;
      }

      return null;
    });
  }

  public async dtoToEntity(dto: MangaDto, manager: EntityManager): Promise<Manga> {
    const entity = new Manga();

    entity.name = dto.name;
    entity.description = dto.description;
    entity.leitorNetUrl = dto.link != null ? dto.link.replace(/\\\//g, '/') : null;
    entity.leitorNetId = dto.id_serie;
    entity.slug = slugify(entity.name);
    entity.finished = dto.is_complete;
    entity.coverUrl = dto.cover;

    entity.categories = await this.categoryService.createOrGetList(dto.categories, manager);

    if (entity.categories && entity.categories.filter((category) => category.adult).length > 0) {
      return null;
    }

    if (dto.author) {
      entity.authors = await this.authorService.createOrGetList(dto.author.split(' & '), manager);
    }
    if (dto.artist) {
      entity.artists = await this.authorService.createOrGetList(dto.artist.split(' & '), manager);
    }

    return entity;
  }

  public getCoverFileName(entity: Manga): string {
    return `${entity.slug}-${generateUid()}`;
  }

  public async isTimeToCralwer(): Promise<boolean> {
    return super.isTimeToCralwer(STATUS_CRAWLER_MANGA_FILE_PATH, MINIMUM_HOURS_BETWEEN_CRAWLER_MANGA);
  }

  public saveEndOfCrawler(): Promise<void> {
    return super.saveEndOfCrawler(STATUS_CRAWLER_MANGA_FILE_PATH);
  }

  public async areChaptersAvailable(entity: Manga, dto: MangaDto): Promise<boolean> {
    const quantityOfChapters: number = await this.chapterService.getCountByManga(entity);

    return quantityOfChapters < dto.chapters;
  }

  public fromResponse(leitorNetId: number, response: AxiosResponse<string>): MangaDto {
    const mangaDto: Partial<MangaDto> = {};

    const regexAuthorsRemove = /(completo|(\+\d+ mang.*))/gi;
    const regexCategoryLinkId = /.*\/(\d+)/;
    const regexQtyChaptersRemove = /\s+\d+/;

    const root = parse(response.data);

    if (root.querySelector('.blocked-icon')) {
      return null;
    }

    const rootSerieData = root.querySelector('#series-data');

    mangaDto.id_serie = leitorNetId;
    mangaDto.cover = rootSerieData.querySelector('img.cover').getAttribute('src');

    if (mangaDto.cover != null) {
      mangaDto.cover = mangaDto.cover.replace('?quality=100', '');
    }

    mangaDto.name = rootSerieData.querySelector('.series-title h1').text;
    mangaDto.chapters = Number(root.querySelector('#chapter-list h2 span').text.replace(regexQtyChaptersRemove, ''));
    mangaDto.description = rootSerieData.querySelector('.series-desc').text.trim();
    mangaDto.is_complete = rootSerieData.querySelector('.complete-series') != null;


    mangaDto.categories = rootSerieData.querySelectorAll('.touchcarousel .touchcarousel-item a').map((category) => {
      const link = category.getAttribute('href');
      const categoryLinkIdMatch = regexCategoryLinkId.exec(link);

      if (categoryLinkIdMatch && categoryLinkIdMatch.length >= 2 && categoryLinkIdMatch[1] != null) {
        return {
          name: category.text.trim(),
          link,
          id_category: Number(categoryLinkIdMatch[1]),
        } as CategoryDto;
      }

      return null;
    }).filter((category) => category != null);

    const authors: string[] = rootSerieData.querySelector('.series-author').text
      .replace(regexAuthorsRemove, '').split('&').map((author) => author.trim());

    mangaDto.author = authors.filter((author) => !author.includes('(Arte)')).join(' & ');
    mangaDto.artist = authors.filter((author) => author.includes('(Arte)')).join(' & ');

    if ((mangaDto.author != null && mangaDto.author.length > 100) || (mangaDto.artist != null && mangaDto.artist.length > 100)) {
      return null;
    }

    return mangaDto as MangaDto;
  }

  public async deleteIfExistisCurrentManga(): Promise<void> {
    if (await fileExists(CURRENT_MANGA_FILE_PATH)) {
      await unlink(CURRENT_MANGA_FILE_PATH);
    }
  }

  public async getIdFromCurrentMangaOnCrawler(): Promise<number> {
    if (await fileExists(CURRENT_MANGA_FILE_PATH)) {
      const fileContent = await readFile(CURRENT_MANGA_FILE_PATH, 'utf-8');
      return Number(fileContent);
    }

    return null;
  }

  public async setIdFromCurrentMangaOnCrawler(leitorNetId: number): Promise<void> {
    return writeFile(CURRENT_MANGA_FILE_PATH, `${leitorNetId}`, 'utf-8');
  }
}
