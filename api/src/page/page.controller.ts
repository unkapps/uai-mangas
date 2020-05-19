
import { Controller, Get, Query } from '@nestjs/common';

import { PageService } from './page.service';
import PageDto from './dto/page.dto';

@Controller('page')
export class PageController {
  constructor(private readonly pageService: PageService) {}

  @Get()
  ofChapter(@Query('chapterId') chapterId: number): Promise<PageDto[]> {
    return this.pageService.getPagesOfChapter(chapterId);
  }
}
