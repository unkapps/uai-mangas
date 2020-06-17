import { EntityRepository, Repository } from 'typeorm';

import Manga from 'src/entity/manga';
import Chapter from 'src/entity/chapter';
import SortingDto from 'src/shared/sorting.dto';
import PageableDto from 'src/shared/pageable.dto';

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

  async getAllMangas(
    doCount = true,
    size = 10, offset?: number,
    sortingDto?: SortingDto,
    name?: string,
  ): Promise<PageableDto<AllMangaDto>> {
    const query = this
      .createQueryBuilder('manga')
      .select('manga.id', 'id')
      .addSelect('manga.name', 'name')
      .addSelect('manga.coverUrl', 'coverUrl')
      .limit(size);

    if (name != null) {
      query.where(`MATCH(manga.name)
      AGAINST(:name IN BOOLEAN MODE)`, { name: `*${name}*` });
    }

    if (sortingDto) {
      query.orderBy(sortingDto.name, sortingDto.direction);
    }

    if (offset != null) {
      query.offset(offset);
    }

    const data = await query.getRawMany();

    const pageableDto: PageableDto<AllMangaDto> = {
      data,
    };

    if (doCount) {
      pageableDto.qtyPages = await query.getCount();
    }

    return pageableDto;
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
