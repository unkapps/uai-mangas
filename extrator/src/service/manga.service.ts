import { autoInjectable, singleton } from 'tsyringe';
import { getConnection, EntityManager } from 'typeorm';
import slugify from 'slugify';


import WaitBetween, { MINIMUM_HOURS_BETWEEN_CRAWLER_MANGA } from './wait-between';
import MangaDto from '../dto/manga.dto';
import Manga from '../entity/manga';
import CategoryService from './category.service';
import AuthorService from './author.service';
import { STATUS_CRAWLER_MANGA_FILE_PATH } from '../config/general-craweler.config';
import generateUid from '../util/generator-id';
import ChapterService from './chapter.service';

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
      .getOne();

    if (mangaDatabase) {
      return mangaDatabase;
    }

    return connection.transaction(async (manager) => {
      const manga = await manager.save(await this.dtoToEntity(dto, manager));
      manga.justGotSaved = true;
      return manga;
    });
  }

  public async dtoToEntity(dto: MangaDto, manager: EntityManager): Promise<Manga> {
    const entity = new Manga();

    entity.name = dto.name;
    entity.description = dto.description;
    entity.leitorNetUrl = dto.link.replace(/\\\//g, '/');
    entity.leitorNetId = dto.id_serie;
    entity.slug = slugify(entity.name);
    entity.finished = dto.is_complete;
    entity.coverUrl = dto.cover;

    entity.categories = await this.categoryService.createOrGetList(dto.categories, manager);

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
}
