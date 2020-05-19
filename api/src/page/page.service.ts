import { Injectable } from '@nestjs/common';

import { PageRepository } from './page.repository';
import PageDto from './dto/page.dto';

@Injectable()
export class PageService {
  constructor(
    private pageRepository: PageRepository,
  ) {}

  getPagesOfChapter(chapterId: number): Promise<PageDto[]> {
    return this.pageRepository.getPagesOfChapter(chapterId);
  }
}
