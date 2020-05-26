import { Injectable } from '@nestjs/common';

import { ChapterRepository } from './chapter.repository';
import ChapterDto from './dto/chapter.dto';

@Injectable()
export class ChapterService {
  constructor(
    private chapterRepository: ChapterRepository,
  ) { }

  getPagesOfChapter(chapterId: number): Promise<ChapterDto> {
    return this.chapterRepository.getChapter(chapterId);
  }
}
