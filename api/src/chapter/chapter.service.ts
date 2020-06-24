import { Injectable } from '@nestjs/common';

import { ChapterRepository } from './chapter.repository';
import ChapterDto from './dto/chapter.dto';
import ChapterListDto from './dto/chapter-list.dto';

@Injectable()
export class ChapterService {
  constructor(
    private chapterRepository: ChapterRepository,
  ) { }

  getPagesOfChapter(chapterId: number, userId?: number): Promise<ChapterDto> {
    return this.chapterRepository.getChapter(chapterId, userId);
  }

  list(mangaId: number, offset?: number, size?: number, userId?: number): Promise<ChapterListDto[]> {
    return this.chapterRepository.list(mangaId, offset, size, userId);
  }

  async setChapterReaded(userId: number, chapterId: number, chapterReaded: boolean): Promise<boolean> {
    if (chapterReaded) {
      await this.chapterRepository.addChapterReaded(userId, chapterId);
    } else {
      await this.chapterRepository.removeChapterReaded(userId, chapterId);
    }

    return chapterReaded;
  }
}
