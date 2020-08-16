/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  JoinTable,
  ManyToMany,
} from 'typeorm';

import Manga from './manga';

@Entity()
export default class Category {
  @PrimaryGeneratedColumn({ unsigned: true })
  id?: number;

  @Column({
    length: 50,
    unique: true,
  })
  name: string;

  @Column({
    length: 60,
    unique: true,
    select: false,
  })
  slug: string;

  @Column({
    unsigned: true,
    unique: true,
    select: false,
  })
  leitorNetId: number;

  @Column({
    length: 60,
    unique: true,
    select: false,
  })
  leitorNetUrl: string;

  @ManyToMany(() => Manga, (manga) => manga.categories)
  @JoinTable({ name: 'manga_categories' })
  mangas: Manga[];

  @Column('tinyint')
  adult: boolean;
}
