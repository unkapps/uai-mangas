
import {
  Controller,
  Get,
  Param,
  Query,
} from '@nestjs/common';

import Manga from 'src/entity/manga';
import SortingDto from 'src/shared/sorting.dto';
import PageableDto from 'src/shared/pageable.dto';

import { MangaService } from './manga.service';
import LastMangaDto from './dto/last-manga.dto';
import AllMangaDto from './dto/all-manga.dto';

@Controller('manga')
export class MangaController {
  constructor(private readonly mangaService: MangaService) { }

  @Get('last')
  findLast(@Query('size') size?: number): Promise<LastMangaDto[]> {
    return this.mangaService.getLastMangasWithUpdates(size);
  }

  @Get('')
  findAll(
    @Query('size') size?: number,
      @Query('offset') offset?: number,
      @Query('sorting') sortingStr?: string,
      @Query('name') name?: string,
  ): Promise<PageableDto<AllMangaDto>> {
    const sortingDto = SortingDto.fromString(sortingStr);
    return this.mangaService.getAllMangas(size, offset, sortingDto, name);
  }

  @Get('loadMore')
  loadMore(
    @Query('size') size?: number,
      @Query('offset') offset?: number,
      @Query('sorting') sortingStr?: string,
      @Query('name') name?: string,
  ): Promise<AllMangaDto[]> {
    const sortingDto = SortingDto.fromString(sortingStr);
    return this.mangaService.loadMore(size, offset, sortingDto, name);
  }

  @Get(':id')
  findById(@Param('id') id: number): Promise<Manga> {
    return this.mangaService.findById(id);
  }
}
