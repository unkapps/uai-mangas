
import { Controller, Get, Param } from '@nestjs/common';

import Manga from 'src/entity/manga';
import { MangaService } from './manga.service';
import LastManga from './dto/last-manga';

@Controller('manga')
export class MangaController {
  constructor(private readonly mangaService: MangaService) { }

  @Get('last')
  findAll(): Promise<LastManga[]> {
    return this.mangaService.getLastMangasWithUpdates();
  }

  @Get(':id')
  findById(@Param('id') id: number): Promise<Manga> {
    return this.mangaService.findById(id);
  }
}
