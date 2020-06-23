import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { AuthModule } from 'src/auth/auth.module';
import { ChapterService } from './chapter.service';
import { ChapterController } from './chapter.controller';
import { ChapterRepository } from './chapter.repository';

@Module({
  imports: [
    TypeOrmModule.forFeature([ChapterRepository]),
    AuthModule,
  ],
  providers: [
    ChapterService,
  ],
  controllers: [
    ChapterController,
  ],
})
export class ChapterModule { }
