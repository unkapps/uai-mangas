import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { ChapterService } from './chapter.service';
import { ChapterController } from './chapter.controller';
import { ChapterRepository } from './chapter.repository';

@Module({
  imports: [
    TypeOrmModule.forFeature([ChapterRepository]),
  ],
  providers: [
    ChapterService,
  ],
  controllers: [
    ChapterController,
  ],
})
export class ChapterModule { }
