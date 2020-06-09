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

  async findById(id: number): Promise<Manga> {
    const manga = await this.manager.getRepository(Manga)
      .createQueryBuilder('manga')
      .innerJoinAndSelect('manga.authors', 'author')
      .innerJoinAndSelect('manga.artists', 'artist')
      .innerJoinAndSelect('manga.categories', 'category')
      .leftJoin('manga.chapters', 'chapter')
      .where('manga.id = :id', { id })
      .getOne();

    if (manga) {
      const resultQty = await this.manager.getRepository(Chapter)
        .createQueryBuilder('chapter')
        .select('count(chapter.id)', 'qty')
        .where('chapter.manga_id = :id', { id })
        .groupBy('chapter.manga_id')
        .getRawOne();

      manga.qtyChapters = resultQty ? Number.parseInt(resultQty.qty, 10) : 0;
    }

    return manga;
  }
}
