
import { Controller, Get, Param } from '@nestjs/common';

import { ChapterService } from './chapter.service';
import ChapterDto from './dto/chapter.dto';

@Controller('chapter')
export class ChapterController {
  constructor(private readonly chapterService: ChapterService) {}

  @Get(':id')
  ofChapter(@Param('id') id: number): Promise<ChapterDto> {
    return this.chapterService.getPagesOfChapter(id);
  }
}
