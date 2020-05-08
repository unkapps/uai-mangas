/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
  JoinTable,
  OneToMany,
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

  @ManyToMany(() => Author, (author) => author.mangas)
  @JoinTable()
  authors: Author[];

  @OneToMany(() => Chapter, (chapter) => chapter.manga)
  chapters: Chapter[];

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
}
