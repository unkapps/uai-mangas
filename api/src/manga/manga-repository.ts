import { EntityRepository, Repository } from 'typeorm';

import Manga from 'src/entity/manga';
import Chapter from 'src/entity/chapter';
import LastManga from './dto/last-manga';

@EntityRepository(Manga)
export class MangaRepository extends Repository<Manga> {
  getLastMangasWithUpdates(limit = 10): Promise<LastManga[]> {
    return this.manager.getRepository(Chapter)
      .createQueryBuilder('chapter')
      .select('manga.id', 'id')
      .addSelect('manga.name', 'name')
      .addSelect('chapter.number', 'chapter_number')
      .addSelect('chapter.date', 'date')
      .addSelect('manga.coverUrl', 'coverUrl')
      .innerJoin('chapter.manga', 'manga')
      .orderBy('chapter.date', 'DESC')
      .limit(limit)
      .getRawMany();
  }
}
