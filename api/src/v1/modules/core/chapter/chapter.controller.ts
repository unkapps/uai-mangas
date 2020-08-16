
import {
  Controller,
  Get,
  Param,
  Query,
  Put,
  UseGuards,
  Req,
} from '@nestjs/common';

import { FirebaseAuthGuard } from 'src/v1/modules/auth/firebase-auth.guard';
import { FirebaseAuthOptionalGuard } from 'src/v1/modules/auth/firebase-auth-optional.guard';

import { ChapterService } from './chapter.service';
import ChapterDto from './dto/chapter.dto';
import ChapterListDto from './dto/chapter-list.dto';

@Controller('api/v1/chapter')
export class ChapterController {
  constructor(private readonly chapterService: ChapterService) { }

  @Get(':id')
  @UseGuards(FirebaseAuthOptionalGuard)
  ofChapter(@Req() request: any, @Param('id') id: number): Promise<ChapterDto> {
    return this.chapterService.getPagesOfChapter(id, request.userId);
  }

  @Get()
  @UseGuards(FirebaseAuthOptionalGuard)
  list(
    @Req() request: any,
    @Query('mangaId') mangaId: number,
    @Query('offset') offset: number,
    @Query('size') size: number,
    @Query('sort') sort: string,
  ): Promise<ChapterListDto[]> {
    return this.chapterService.list(mangaId, offset, size, request.userId, sort);
  }

  @Put('readed/:id')
  @UseGuards(FirebaseAuthGuard)
  setMangaFavorite(@Req() request: any, @Param('id') chapterId: number, @Query('chapterReaded') chapterReaded: string): Promise<boolean> {
    return this.chapterService.setChapterReaded(request.userId, chapterId, chapterReaded === 'true');
  }
}
