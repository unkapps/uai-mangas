import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { MangaRepository } from './manga.repository';
import { MangaService } from './manga.service';
import { MangaController } from './manga.controller';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([MangaRepository]),
    AuthModule,
  ],
  providers: [
    MangaService,
  ],
  controllers: [
    MangaController,
  ],
})
export class MangaModule { }
