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
    categoryId?: number,
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

    if (categoryId != null) {
      query.innerJoin('manga.categories', 'category');
      query.andWhere('category.id = :categoryId', { categoryId });
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
      .leftJoinAndSelect('manga.authors', 'author')
      .leftJoinAndSelect('manga.artists', 'artist')
      .leftJoinAndSelect('manga.categories', 'category')
      .leftJoin('manga.chapters', 'chapter')
      .where('manga.id = :id', { id })
      .groupBy('manga.id')
      .addGroupBy('manga.name')
      .addGroupBy('manga.finished')
      .addGroupBy('manga.description')
      .addGroupBy('manga.cover_url')
      .addGroupBy('author.id')
      .addGroupBy('author.name')
      .addGroupBy('artist.id')
      .addGroupBy('category.id')
      .addGroupBy('category.name');

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
        select result.manga_id id,
        result.manga_name name,
        result.manga_cover_url coverUrl,
        next_chapter.id 'nextChapterId',
        next_chapter.number 'nextChapterNumber',
        next_chapter.date 'nextChapterDate',
        (
          select case
              when count(1) = 0 then true
              else false
            end
          from chapter_read cr
            join chapter c on c.id = cr.chapter_id
          where cr.user_id = fm.user_id
            and c.manga_id = result.manga_id
        ) 'neverReaded'
        from following_manga fm
        join (
          select m.id manga_id,
            m.name manga_name,
            m.cover_url manga_cover_url,
            u.id user_id,
            min(next_chapter.number_value) next_chapter_number_value
          from following_manga fm
            join manga m on m.id = fm.manga_id
            join user u on u.id = fm.user_id
            left join (
              select cr.user_id user_id,
                c.manga_id manga_id,
                max(c.number_value) max_chapter_readed
              from chapter_read cr
                join chapter c on c.id = cr.chapter_id
              group by cr.user_id,
                c.manga_id
            ) cr on cr.manga_id = m.id
            and cr.user_id = u.id
            left join (
              select bigger_chapter.id,
                bigger_chapter.manga_id,
                bigger_chapter.number,
                bigger_chapter.number_value,
                bigger_chapter.date
              from chapter bigger_chapter
              order by bigger_chapter.number desc
            ) next_chapter on cr.manga_id = next_chapter.manga_id
            and next_chapter.number_value > cr.max_chapter_readed
          where u.id = ?
          group by m.id,
            m.name,
            m.cover_url,
            u.id
        ) result on result.user_id = fm.user_id
        and result.manga_id = fm.manga_id
        left join chapter next_chapter on next_chapter.manga_id = result.manga_id
        and next_chapter.number_value = result.next_chapter_number_value
        where fm.user_id = ?;
      `, [userId, userId],
    );

    return rawData as FavoriteMangaDto;
  }
}
