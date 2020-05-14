import { Injectable } from '@nestjs/common';

import Manga from 'src/entity/manga';
import { MangaRepository } from './manga-repository';
import LastManga from './dto/last-manga';

@Injectable()
export class MangaService {
  constructor(
    private mangaRepository: MangaRepository,
  ) {}

  getLastMangasWithUpdates(): Promise<LastManga[]> {
    return this.mangaRepository.getLastMangasWithUpdates();
  }
}
