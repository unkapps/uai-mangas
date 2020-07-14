import { Injectable } from '@nestjs/common';

import Manga from 'src/entity/manga';
import SortingDto from 'src/shared/sorting.dto';
import PageableDto from 'src/shared/pageable.dto';
import FirebaseConfig from 'src/firebase/firebase_config';

import { MangaRepository } from './manga.repository';
import LastMangaDto from './dto/last-manga.dto';
import AllMangaDto from './dto/all-manga.dto';
import FavoriteMangaDto from './dto/favorite-manga.dto';

@Injectable()
export class MangaService {
  constructor(
    private mangaRepository: MangaRepository,
    private firebaseConfig: FirebaseConfig,
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

  findById(id: number, userId?: number): Promise<Manga> {
    return this.mangaRepository.findById(id, userId);
  }

  async setMangaFavorite(userId: number, mangaId: number, mangaFavorite: boolean, fcmToken: string): Promise<boolean> {
    if (mangaFavorite) {
      await this.firebaseConfig.adminApp.messaging().subscribeToTopic(fcmToken, `${mangaId}`);
      await this.mangaRepository.addMangaFavorite(userId, mangaId);
    } else {
      await this.firebaseConfig.adminApp.messaging().unsubscribeFromTopic(fcmToken, `${mangaId}`);
      await this.mangaRepository.removeMangaFavorite(userId, mangaId);
    }

    return mangaFavorite;
  }

  async getFavoriteMangas(userId: number): Promise<FavoriteMangaDto> {
    return this.mangaRepository.getFavoriteMangas(userId);
  }
}
