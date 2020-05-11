/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
} from 'typeorm';

import Manga from './manga';

@Entity()
export default class Author {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column({
    length: 100,
    unique: true,
  })
  name: string;

  @ManyToMany(() => Manga, (manga) => manga.authors)
  createdMangas: Manga[];

  @ManyToMany(() => Manga, (manga) => manga.artists)
  drawnMangas: Manga[];
}
