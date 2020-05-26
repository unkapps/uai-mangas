import { EntityRepository, Repository } from 'typeorm';

import Page from 'src/entity/page';
import PageDto from './dto/page.dto';

@EntityRepository(Page)
export class PageRepository extends Repository<Page> {
  getPagesOfChapter(chapterId: number): Promise<PageDto[]> {
    return this
      .createQueryBuilder('page')
      .select('page.id', 'id')
      .addSelect('page.imageUrl', 'imageUrl')
      .where('page.chapter_id = :chapterId', {
        chapterId,
      })
      .orderBy('page.number', 'ASC')
      .getRawMany();
  }
}
