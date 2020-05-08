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
  })
  name: string;

  @ManyToMany(() => Manga, (manga) => manga.authors)
  mangas: Manga[];
}
