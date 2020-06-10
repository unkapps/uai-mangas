
import { Controller, Get, Param, Query } from '@nestjs/common';

import Manga from 'src/entity/manga';
import { MangaService } from './manga.service';
import LastManga from './dto/last-manga';

@Controller('manga')
export class MangaController {
  constructor(private readonly mangaService: MangaService) { }

  @Get('last')
  findAll(@Query('size') size?: number): Promise<LastManga[]> {
    return this.mangaService.getLastMangasWithUpdates(size);
  }

  @Get(':id')
  findById(@Param('id') id: number): Promise<Manga> {
    return this.mangaService.findById(id);
  }
}
