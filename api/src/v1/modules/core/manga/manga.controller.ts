
import {
  Controller,
  Get,
  Param,
  Query,
  UseGuards,
  Req,
  Put,
} from '@nestjs/common';
import { UseInterceptors, ClassSerializerInterceptor } from '@nestjs/common';

import Manga from 'src/entity/manga';
import SortingDto from 'src/shared/sorting.dto';
import PageableDto from 'src/shared/pageable.dto';
import { FirebaseAuthGuard } from 'src/v1/modules/auth/firebase-auth.guard';

import { FirebaseAuthOptionalGuard } from 'src/v1/modules/auth/firebase-auth-optional.guard';
import { MangaService } from './manga.service';
import LastMangaDto from './dto/last-manga.dto';
import AllMangaDto from './dto/all-manga.dto';
import FavoriteMangaDto from './dto/favorite-manga.dto';

@Controller('/api/v1/manga')
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
    @Query('categoryId') categoryId?: number,
  ): Promise<PageableDto<AllMangaDto>> {
    const sortingDto = SortingDto.fromString(sortingStr);
    return this.mangaService.getAllMangas(size, offset, sortingDto, name, categoryId);
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

  @Get('favorite')
  @UseGuards(FirebaseAuthGuard)
  getFavoriteMangas(@Req() request: any): Promise<FavoriteMangaDto> {
    return this.mangaService.getFavoriteMangas(request.userId);
  }

  @Get(':id')
  @UseGuards(FirebaseAuthOptionalGuard)
  @UseInterceptors(ClassSerializerInterceptor) // TODO:
  findById(@Req() request: any, @Param('id') id: number): Promise<Manga> {
    return this.mangaService.findById(id, request.userId);
  }

  @Put('favorite/:id')
  @UseGuards(FirebaseAuthGuard)
  setMangaFavorite(
    @Req() request: any,
    @Param('id') mangaId: number,
    @Query('mangaFavorite') mangaFavorite: string,
    @Query('fcmToken') fcmToken: string,
  ): Promise<boolean> {
    return this.mangaService.setMangaFavorite(request.userId, mangaId, mangaFavorite === 'true', fcmToken);
  }
}
