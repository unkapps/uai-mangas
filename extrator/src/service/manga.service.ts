import { autoInjectable, singleton } from 'tsyringe';
import { getConnection, EntityManager } from 'typeorm';
import slugify from 'slugify';


import WaitBetween, { MINIMUM_HOURS_BETWEEN_CRAWLER_MANGA } from './wait-between';
import MangaDto from '../dto/manga.dto';
import Manga from '../entity/manga';
import CategoryService from './category.service';
import AuthorService from './author.service';
import { saveImageFromHttp } from '../util';
import { STATUS_CRAWLER_MANGA_FILE_PATH, COVER_PATH, DATA_PATH } from '../config/general-craweler.config';
import generateUid from '../util/generator-id';
import ExitService from './exit.service';
import ChapterService from './chapter.service';

@singleton()
@autoInjectable()
export default class MangaService extends WaitBetween {
  constructor(
    private categoryService: CategoryService,
    private authorService: AuthorService,
    private exitService: ExitService,
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
      .where('manga.leitorNetId = :leitorNetId', { leitorNetId: dto.id_serie })
      .getOne();

    if (mangaDatabase) {
      return mangaDatabase;
    }

    return connection.transaction(async (manager) => {
      const manga = await manager.save(await this.dtoToEntity(dto, manager));
      this.exitService.currentMangaCoverFilePath = undefined;
      manga.justGotSaved = true;
      return manga;
    });
  }

  public async dtoToEntity(dto: MangaDto, manager: EntityManager): Promise<Manga> {
    const entity = new Manga();

    entity.name = dto.name;
    entity.leitorNetUrl = dto.link.replace(/\\\//g, '/');
    entity.leitorNetId = dto.id_serie;
    entity.slug = slugify(entity.name);
    entity.finished = dto.is_complete;
    entity.coverFilePath = await saveImageFromHttp(dto.cover, this.getCoverFileName(entity), `${COVER_PATH}/`);
    this.exitService.currentMangaCoverFilePath = entity.coverFilePath;
    entity.coverUrl = entity.coverFilePath.replace(DATA_PATH, '');

    entity.categories = await this.categoryService.createOrGetList(dto.categories, manager);
    entity.authors = await this.authorService.createOrGetList(dto.author.split(' & '), manager);
    entity.artists = await this.authorService.createOrGetList(dto.artist.split(' & '), manager);

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
