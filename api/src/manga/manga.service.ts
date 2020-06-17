import { Injectable } from '@nestjs/common';

import Manga from 'src/entity/manga';
import SortingDto from 'src/shared/sorting.dto';
import PageableDto from 'src/shared/pageable.dto';

import { MangaRepository } from './manga.repository';
import LastMangaDto from './dto/last-manga.dto';
import AllMangaDto from './dto/all-manga.dto';

@Injectable()
export class MangaService {
  constructor(
    private mangaRepository: MangaRepository,
  ) { }

  getLastMangasWithUpdates(size?: number): Promise<LastMangaDto[]> {
    return this.mangaRepository.getLastMangasWithUpdates(size);
  }

  getAllMangas(size?: number, offset?: number, sortingDto?: SortingDto, name?: string): Promise<PageableDto<AllMangaDto>> {
    return this.mangaRepository.getAllMangas(true, size, offset, sortingDto, name);
  }

  async loadMore(size?: number, offset?: number, sortingDto?: SortingDto, name?: string): Promise<AllMangaDto[]> {
    const pageableDto: PageableDto<AllMangaDto> = await this.mangaRepository.getAllMangas(false, size, offset, sortingDto, name);

    return pageableDto.data;
  }

  findById(id: number): Promise<Manga> {
    return this.mangaRepository.findById(id);
  }
}
