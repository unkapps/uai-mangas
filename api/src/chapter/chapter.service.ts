import { Injectable } from '@nestjs/common';

import { ChapterRepository } from './chapter.repository';
import ChapterDto from './dto/chapter.dto';
import ChapterListDto from './dto/chapter-list.dto';

@Injectable()
export class ChapterService {
  constructor(
    private chapterRepository: ChapterRepository,
  ) { }

  getPagesOfChapter(chapterId: number): Promise<ChapterDto> {
    return this.chapterRepository.getChapter(chapterId);
  }

  list(mangaId: number, offset?: number, size?: number): Promise<ChapterListDto[]> {
    return this.chapterRepository.list(mangaId, offset, size);
  }
}
