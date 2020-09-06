/* eslint-disable import/no-cycle */

import { Exclude } from 'class-transformer';
import {
  Entity,
  Column,
  ManyToMany,
  JoinTable,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

import Category from './category';
import Author from './author';
import Chapter from './chapter';
import FollowingManga from './following-manga';

@Entity()
export default class Manga {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column({
    length: 200,
    unique: true,
  })
  name: string;

  @Column({
    length: 110,
    unique: true,
    select: false,
  })
  slug: string;

  @Column('tinyint', { nullable: true })
  finished?: boolean;

  @Column('text', { nullable: true })
  description?: string;

  @ManyToMany(() => Category, (category) => category.mangas)
  categories: Category[];

  @ManyToMany(() => Author, (author) => author.createdMangas)
  @JoinTable({
    name: 'manga_author',
  })
  authors?: Author[];

  @ManyToMany(() => Author, (author) => author.drawnMangas)
  @JoinTable({
    name: 'manga_artist',
  })
  artists?: Author[];

  @OneToMany(() => Chapter, (chapter) => chapter.manga)
  chapters?: Chapter[];

  @Column({
    unsigned: true,
    unique: true,
    select: false,
  })
  leitorNetId: number;

  @Column({
    length: 255,
    unique: true,
    select: false,
  })
  leitorNetUrl: string;

  @Column({
    length: 255,
    nullable: true,
  })
  coverUrl?: string;

  @Column({
    length: 255,
    nullable: true,
    select: false,
  })
  coverUrlStorage?: string;

  justGotSaved?: boolean;

  qtyChapters: number;

  @Exclude()
  private _favoriteNum : number;

  @Column({
    select: false,
    nullable: true,
    insert: false,
    update: false,
  })
  set favoriteNum(number: number) {
    // eslint-disable-next-line eqeqeq
    this.favorite = number == 1;
    this._favoriteNum = number;
  }

  get favoriteNum(): number {
    return this._favoriteNum;
  }

  favorite: boolean;

  @OneToMany(() => FollowingManga, (followingManga) => followingManga.manga)
  favoriteMangas: FollowingManga[];
}
