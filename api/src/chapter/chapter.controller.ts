
import {
  Controller,
  Get,
  Param,
  Query,
} from '@nestjs/common';

import { ChapterService } from './chapter.service';
import ChapterDto from './dto/chapter.dto';
import ChapterListDto from './dto/chapter-list.dto';

@Controller('chapter')
export class ChapterController {
  constructor(private readonly chapterService: ChapterService) { }

  @Get(':id')
  ofChapter(@Param('id') id: number): Promise<ChapterDto> {
    return this.chapterService.getPagesOfChapter(id);
  }

  @Get()
  list(@Query('mangaId') mangaId: number, @Query('offset') offset: number, @Query('size') size: number): Promise<ChapterListDto[]> {
    return this.chapterService.list(mangaId, offset, size);
  }
}
