import { EntityRepository, Repository } from 'typeorm';

import Manga from 'src/entity/manga';
import Chapter from 'src/entity/chapter';
import SortingDto from 'src/shared/sorting.dto';
import PageableDto from 'src/shared/pageable.dto';
import FollowingManga from 'src/entity/following-manga';

import LastMangaDto from './dto/last-manga.dto';
import FavoriteMangaDto from './dto/favorite-manga.dto';
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
      const nameForQuery = name.replace(/[^\p{L}\p{N}_\s]+/u, '');

      if (nameForQuery.trim().length > 0) {
        query.where(`MATCH(manga.name)
          AGAINST(:name IN BOOLEAN MODE)`, { name: `*${nameForQuery}*` });
      }
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

  async findById(id: number, userId?: number): Promise<Manga> {
    const queryBuilder = this.manager.getRepository(Manga)
      .createQueryBuilder('manga')
      .innerJoinAndSelect('manga.authors', 'author')

      .innerJoinAndSelect('manga.artists', 'artist')
      .innerJoinAndSelect('manga.categories', 'category')
      .leftJoin('manga.chapters', 'chapter')
      .where('manga.id = :id', { id });

    if (userId != null) {
      queryBuilder.leftJoin('manga.favoriteMangas', 'favoriteMangas',
        'favoriteMangas.manga_id = manga.id and favoriteMangas.user_id = :userId', { userId });
      queryBuilder.addSelect('case when favoriteMangas.user_id is null then 0 else 1 end', 'manga_favorite_num');
    }

    const manga = await queryBuilder.getOne();

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

  async addMangaFavorite(userId: number, mangaId: number): Promise<void> {
    await this.manager.insert(FollowingManga, [{
      userId,
      mangaId,
    }]);
  }

  async removeMangaFavorite(userId: number, mangaId: number): Promise<any> {
    await this.manager.getRepository(FollowingManga).delete({ userId, mangaId });
  }

  async getFavoriteMangas(userId: number): Promise<FavoriteMangaDto> {
    const rawData = await this.manager.query(
      `
        select
          m.id,
          m.name,
          m.cover_url coverUrl,
          next_chapter.id 'nextChapterId',
          next_chapter.number 'nextChapterNumber',
          next_chapter.date 'nextChapterDate',
          (
            select
              case
                when count(1) = 0 then true else false
              end
                from chapter_read cr
                join chapter c
              on c.id = cr.chapter_id
                where
              cr.user_id = u.id
                    and c.manga_id = m.id
          ) 'neverReaded'
        from following_manga fm
        join manga m on m.id = fm.manga_id
        join user u on u.id = fm.user_id
        left join (
          select 
            cr.user_id user_id,
            c.manga_id manga_id,
            max(c.number_value) max_chapter_readed
          from chapter_read cr
          join chapter c on c.id = cr.chapter_id
          group by cr.user_id, c.manga_id
        ) cr
          on cr.manga_id = m.id
          and cr.user_id = u.id
        left join  (
          select
            smallest_chapter.id,
            smallest_chapter.manga_id,
            smallest_chapter.number,
            smallest_chapter.number_value,
            smallest_chapter.date
          from chapter smallest_chapter
            order by smallest_chapter.number desc
        )   next_chapter 
          on cr.manga_id = next_chapter.manga_id
          and next_chapter.number_value > cr.max_chapter_readed
        where u.id = ?
        group by m.id, m.name, m.cover_url;
    `, [userId],
    );

    return rawData as FavoriteMangaDto;
  }
}
