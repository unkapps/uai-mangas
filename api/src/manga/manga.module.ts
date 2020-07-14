import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';

import { SharedModule } from 'src/shared/shared.module';
import { MangaRepository } from './manga.repository';
import { MangaService } from './manga.service';
import { MangaController } from './manga.controller';

@Module({
  imports: [
    TypeOrmModule.forFeature([MangaRepository]),
    AuthModule,
    SharedModule,
  ],
  providers: [
    MangaService,
  ],
  controllers: [
    MangaController,
  ],
})
export class MangaModule { }
