import { EntityRepository, Repository } from 'typeorm';

import Chapter from 'src/entity/chapter';
import PageDto from 'src/page/dto/page.dto';
import ChapterDto from './dto/chapter.dto';
import ChapterListDto from './dto/chapter-list.dto';

@EntityRepository(Chapter)
export class ChapterRepository extends Repository<Chapter> {
  list(mangaId: number, offset = 0, size = 10): Promise<ChapterListDto[]> {
    return this
      .createQueryBuilder('chapter')
      .select('chapter.id', 'id')
      .addSelect('chapter.number', 'number')
      .addSelect('chapter.date', 'date')
      .where('chapter.manga_id = :mangaId', {
        mangaId,
      })
      .orderBy('chapter.number_int', 'DESC')
      .addOrderBy('chapter.number', 'DESC')
      .limit(size)
      .offset(offset)
      .getRawMany();
  }

  async getChapter(chapterId: number): Promise<ChapterDto> {
    const results = await this
      .createQueryBuilder('chapter')
      .select('chapter.id', 'id')
      .addSelect('manga.name', 'manga_name')
      .addSelect('manga.id', 'manga_id')
      .addSelect('chapter.number', 'number')
      .addSelect('chapter.number', 'number')
      .addSelect('chapter.number_int', 'numberInt')
      .addSelect('page.image_url', 'page_imageUrl')
      .innerJoin('chapter.pages', 'page')
      .innerJoin('chapter.manga', 'manga')
      .where('page.chapter_id = :chapterId', {
        chapterId,
      })
      .orderBy('page.number', 'ASC')
      .getRawMany();

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
      pages,
    };


    const previousChapter = await this
      .createQueryBuilder('chapter')
      .select('chapter.id', 'id')
      .where('chapter.manga_id = :manga_id', { manga_id: chapter.mangaId })
      .andWhere('chapter.number_int <= :number_int', { number_int: results[0].numberInt })
      .andWhere('chapter.number < :number', { number: results[0].number })
      .orderBy('chapter.numberInt', 'DESC')
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
      .andWhere('chapter.number_int >= :number_int', { number_int: results[0].numberInt })
      .andWhere('chapter.number > :number', { number: results[0].number })
      .orderBy('chapter.numberInt', 'ASC')
      .addOrderBy('chapter.number', 'ASC')
      .limit(1)
      .getRawOne();

    if (nextChapter) {
      chapter.nextChapterId = nextChapter.id;
    }

    return chapter;
  }
}
