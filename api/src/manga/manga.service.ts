import { Injectable } from '@nestjs/common';

import Manga from 'src/entity/manga';
import { MangaRepository } from './manga.repository';
import LastMangaDto from './dto/last-manga.dto';
import AllMangaDto from './dto/all-manga.dto';

@Injectable()
export class MangaService {
  constructor(
    private mangaRepository: MangaRepository,
  ) {}

  getLastMangasWithUpdates(size?: number): Promise<LastMangaDto[]> {
    return this.mangaRepository.getLastMangasWithUpdates(size);
  }

  getAllMangas(size?: number): Promise<AllMangaDto[]> {
    return this.mangaRepository.getAllMangas(size);
  }

  findById(id: number): Promise<Manga> {
    return this.mangaRepository.findById(id);
  }


}
