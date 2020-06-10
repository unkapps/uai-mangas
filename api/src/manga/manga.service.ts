import { Injectable } from '@nestjs/common';

import Manga from 'src/entity/manga';
import { MangaRepository } from './manga.repository';
import LastManga from './dto/last-manga';

@Injectable()
export class MangaService {
  constructor(
    private mangaRepository: MangaRepository,
  ) {}

  getLastMangasWithUpdates(size?: number): Promise<LastManga[]> {
    return this.mangaRepository.getLastMangasWithUpdates(size);
  }

  findById(id: number): Promise<Manga> {
    return this.mangaRepository.findById(id);
  }


}
