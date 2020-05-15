
import { Controller, Get } from '@nestjs/common';

import { MangaService } from './manga-service';
import LastManga from './dto/last-manga';

@Controller('manga')
export class MangaController {
  constructor(private readonly mangaService: MangaService) {}

  @Get('last')
  findAll(): Promise<LastManga[]> {
    return this.mangaService.getLastMangasWithUpdates();
  }

  // @Get(':id')
  // findOne(@Param('id') id: string): Promise<User> {
  //   return this.mangaService.findOne(id);
  // }
}
