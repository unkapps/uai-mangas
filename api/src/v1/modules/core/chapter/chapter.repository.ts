import { EntityRepository, Repository } from 'typeorm';

import Chapter from 'src/entity/chapter';
import PageDto from 'src/page/dto/page.dto';
import ChapterRead from 'src/entity/chapter_read';
import ChapterDto from './dto/chapter.dto';
import ChapterListDto from './dto/chapter-list.dto';

@EntityRepository(Chapter)
export class ChapterRepository extends Repository<Chapter> {
  async list(mangaId: number, offset = 0, size = 10, userId?: number, sort = 'DESC'): Promise<ChapterListDto[]> {
    const queryBuilder = this
      .createQueryBuilder('chapter')
      .select('chapter.id', 'id')
      .addSelect('chapter.number', 'number')
      .addSelect('chapter.date', 'date')
      .where('chapter.manga_id = :mangaId', {
        mangaId,
      })
      .orderBy('chapter.numberValue', sort.toUpperCase() === 'DESC' ? 'DESC' : 'ASC')
      .limit(size)
      .offset(offset);

    if (userId != null) {
      queryBuilder.leftJoin('chapter.chaptersRead', 'chapterRead',
        'chapterRead.chapter_id = chapter.id and chapterRead.user_id = :userId', { userId });
      queryBuilder.addSelect('case when chapterRead.user_id is null then 0 else 1 end', 'readed');
    }

    const teste = await queryBuilder.getRawMany();

    return teste;
  }

  async getChapter(chapterId: number, userId?: number): Promise<ChapterDto> {
    const queryBuilder = this
      .createQueryBuilder('chapter')
      .select('chapter.id', 'id')
      .addSelect('manga.name', 'manga_name')
      .addSelect('manga.id', 'manga_id')
      .addSelect('chapter.number', 'number')
      .addSelect('chapter.number', 'number')
      .addSelect('chapter.number_value', 'numberValue')
      .addSelect('page.image_url', 'page_imageUrl')
      .innerJoin('chapter.pages', 'page')
      .innerJoin('chapter.manga', 'manga')
      .where('page.chapter_id = :chapterId', {
        chapterId,
      })
      .orderBy('page.number', 'ASC');


    if (userId != null) {
      queryBuilder.leftJoin('chapter.chaptersRead', 'chapterRead',
        'chapterRead.chapter_id = chapter.id and chapterRead.user_id = :userId', { userId });
      queryBuilder.addSelect('case when chapterRead.user_id is null then 0 else 1 end', 'readed');
    }

    const results = await queryBuilder.getRawMany();

    if (results.length === 0) {
      return null;
    }

    const pages: PageDto[] = results.map((page) => ({
      imageUrl: page.page_imageUrl,
    }));

    const chapter: ChapterDto = {
      id: results[0].id,
      number: results[0].number,
      mangaName: results[0].manga_name,
      mangaId: results[0].manga_id,
      readed: results[0].readed,
      pages,
    };


    const previousChapter = await this
      .createQueryBuilder('chapter')
      .select('chapter.id', 'id')
      .where('chapter.manga_id = :manga_id', { manga_id: chapter.mangaId })
      .andWhere('chapter.number_value <= :number_value', { number_value: results[0].numberValue })
      .andWhere('chapter.number < :number', { number: results[0].number })
      .orderBy('chapter.numberValue', 'DESC')
      .addOrderBy('chapter.number', 'DESC')
      .limit(1)
      .getRawOne();

    if (previousChapter) {
      chapter.previousChapterId = previousChapter.id;
    }

    const nextChapter = await this
      .createQueryBuilder('chapter')
      .select('chapter.id', 'id')
      .where('chapter.manga_id = :manga_id', { manga_id: chapter.mangaId })
      .andWhere('chapter.number_value >= :number_value', { number_value: results[0].numberValue })
      .andWhere('chapter.number > :number', { number: results[0].number })
      .orderBy('chapter.numberValue', 'ASC')
      .addOrderBy('chapter.number', 'ASC')
      .limit(1)
      .getRawOne();

    if (nextChapter) {
      chapter.nextChapterId = nextChapter.id;
    }

    return chapter;
  }

  async addChapterReaded(userId: number, chapterId: number): Promise<void> {
    await this.manager.insert(ChapterRead, [{
      userId,
      chapterId,
    }]);
  }

  async removeChapterReaded(userId: number, chapterId: number): Promise<void> {
    await this.manager.getRepository(ChapterRead).delete({ userId, chapterId });
  }
}
