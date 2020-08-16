import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { SharedModule } from 'src/shared/shared.module';
import { AuthModule } from '../auth/auth.module';
import { MangaRepository } from './manga/manga.repository';
import { MangaService } from './manga/manga.service';
import { MangaController } from './manga/manga.controller';
import { MangaOldController } from './manga/manga.controller.old';
import { CategoryController } from './category/category.controller';
import { CategoryService } from './category/category.service';
import { CategoryRepository } from './category/category.repository';
import { ChapterRepository } from './chapter/chapter.repository';
import { ChapterController } from './chapter/chapter.controller';
import { ChapterOldController } from './chapter/chapter.controller.old';
import { ChapterService } from './chapter/chapter.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      MangaRepository,
      CategoryRepository,
      ChapterRepository,
    ]),
    AuthModule,
    SharedModule,
  ],
  providers: [
    MangaService,
    CategoryService,
    ChapterService,
  ],
  controllers: [
    MangaController,
    ChapterController,
    CategoryController,

    MangaOldController,
    ChapterOldController,
  ],
})
export class CoreModule { }
