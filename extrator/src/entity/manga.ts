/* eslint-disable import/no-cycle */

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

@Entity()
export default class Manga {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column({
    length: 100,
    unique: true,
  })
  name: string;

  @Column({
    length: 110,
    unique: true,
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
  })
  leitorNetId: number;

  @Column({
    length: 110,
    unique: true,
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
  })
  coverFilePath?: string;

  justGotSaved?: boolean;
}
