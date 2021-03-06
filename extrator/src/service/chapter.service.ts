import { autoInjectable, singleton } from 'tsyringe';
import { getConnection, EntityManager } from 'typeorm';

import Chapter from '../entity/chapter';
import Manga from '../entity/manga';
import ChapterDto, { ScanDto } from '../dto/chapter.dto';
import ScanlatorService from './scanlator.service';
import PageService from './page.service';

export const STATUS_FILE_PATH = './data/categories';

@singleton()
@autoInjectable()
export default class ChapterService {
  constructor(
    private scanlatorService: ScanlatorService,
    private pageService: PageService,
  ) { }

  public async createOrGet(dto: ChapterDto, manga: Manga): Promise<Chapter> {
    if (dto == null) {
      return null;
    }

    const connection = await getConnection();

    const databaseEntity = await connection
      .getRepository(Chapter)
      .createQueryBuilder('chapter')
      .innerJoin('chapter.manga', 'manga')
      .where('manga.leitor_net_id = :leitorNetMangaId and chapter.number_value = :chapterNumberValue',
        { leitorNetMangaId: dto.id_serie, chapterNumberValue: dto.numberValue })
      .getOne();

    if (databaseEntity) {
      return databaseEntity;
    }

    const chapter = await connection.transaction(async (manager) => {
      return manager.save(await this.dtoToEntity(dto, manager, manga));
    });

    chapter.justGotSaved = true;

    return chapter;
  }

  public async dtoToEntity(dto: ChapterDto, manager: EntityManager, manga: Manga): Promise<Chapter> {
    const entity = new Chapter();

    const scan: ScanDto = dto.releases[Object.keys(dto.releases)[0]];

    entity.number = this.standardizeNumber(dto);
    entity.numberValue = dto.numberValue;
    entity.title = dto.chapter_name;
    entity.manga = manga;
    entity.leitorNetId = dto.id_chapter;
    entity.leitorNetUrl = scan.link;
    entity.leitorNetReleaseId = scan.id_release;
    entity.date = new Date(dto.date_created);
    entity.scanlator = await this.scanlatorService.createOrGet(scan.scanlators[0], manager);
    entity.pages = await this.pageService.createFromChapter(entity, scan);

    return entity;
  }

  getNumberValue(numberStr: string): number {
    const regex = /(\d+).*/;

    const match = regex.exec(numberStr);

    if (match) {
      return Number(`${match[1]}.${this._numberToAsciiCode(numberStr)}`);
    }

    return 0;
  }

  _numberToAsciiCode(numberStr: string): string {
    return [...numberStr]
      .map((char) => `${char.charCodeAt(0)}`)
      .reduce((current, previous) => `${current}${previous}`);
  }

  standardizeNumber(dto: ChapterDto): string {
    const regexWord = /^(\d+)([a-zA-Z]+)$/;

    // eslint-disable-next-line no-useless-escape
    let numberS = dto.number.replace(/[\,,\-]/, '.');

    const matches = regexWord.exec(numberS);

    if (matches) {
      const charCode = matches[2].charCodeAt(0);

      const decimalPlace = charCode >= 97 ? charCode - 97 : charCode - 65;

      numberS = numberS.replace(matches[2], `.${decimalPlace}`);
    }

    return numberS;
  }


  public async getCountByManga(manga: Manga): Promise<number> {
    const connection = await getConnection();

    return (await connection
      .getRepository(Chapter)
      .createQueryBuilder('chapter')
      .select('count(1)', 'count')
      .where('chapter.manga_id = :mangaId', {
        mangaId: manga.id,
      })
      .getRawOne()).count;
  }
}
