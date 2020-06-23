
import {
  Controller,
  Get,
  Param,
  Query,
  Put,
  UseGuards,
  Req,
} from '@nestjs/common';

import { FirebaseAuthGuard } from 'src/auth/firebase-auth.guard';
import { FirebaseAuthOptionalGuard } from 'src/auth/firebase-auth-optional.guard';

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
  @UseGuards(FirebaseAuthOptionalGuard)
  list(
    @Req() request: any,
    @Query('mangaId') mangaId: number,
    @Query('offset') offset: number,
    @Query('size') size: number,
  ): Promise<ChapterListDto[]> {
    return this.chapterService.list(mangaId, offset, size, request.userId);
  }

  @Put('readed/:id')
  @UseGuards(FirebaseAuthGuard)
  setMangaFavorite(@Req() request: any, @Param('id') chapterId: number, @Query('chapterReaded') chapterReaded: string): Promise<boolean> {
    return this.chapterService.setChapterReaded(request.userId, chapterId, chapterReaded === 'true');
  }
}
