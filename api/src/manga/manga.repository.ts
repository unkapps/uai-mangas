import { EntityRepository, Repository } from 'typeorm';

import Manga from 'src/entity/manga';
import Chapter from 'src/entity/chapter';
import LastMangaDto from './dto/last-manga.dto';
import AllMangaDto from './dto/all-manga.dto';

@EntityRepository(Manga)
export class MangaRepository extends Repository<Manga> {
  getLastMangasWithUpdates(size = 10): Promise<LastMangaDto[]> {
    return this.manager.getRepository(Chapter)
      .createQueryBuilder('chapter')
      .select('manga.id', 'id')
      .addSelect('manga.name', 'name')
      .addSelect('chapter.number', 'chapterNumber')
      .addSelect('chapter.id', 'chapterId')
      .addSelect('chapter.date', 'date')
      .addSelect('manga.coverUrl', 'coverUrl')
      .innerJoin('chapter.manga', 'manga')
      .orderBy('chapter.date', 'DESC')
      .limit(size)
      .getRawMany();
  }

  getAllMangas(size = 10): Promise<AllMangaDto[]> {
    return this
      .createQueryBuilder('manga')
      .select('manga.id', 'id')
      .addSelect('manga.name', 'name')
      .addSelect('manga.coverUrl', 'coverUrl')
      .limit(size)
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
