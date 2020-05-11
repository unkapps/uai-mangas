/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  OneToMany,
} from 'typeorm';

import Manga from './manga';
import Scanlator from './scanlator';
import Page from './page';

@Entity()
export default class Chapter {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column(
    'decimal',
    {
      precision: 6,
      scale: 1,
      unsigned: true,
    },
  )
  number: number;

  @ManyToOne(() => Manga, (manga) => manga.chapters)
  manga: Manga;

  @ManyToOne(() => Scanlator, (scanlator) => scanlator.chapters, { nullable: true })
  scanlator?: Scanlator;

  @Column('datetime')
  date: Date;

  @Column('tinytext', { nullable: true })
  title?: string;

  @OneToMany(() => Page, (page) => page.chapter, { cascade: true })
  pages: Page[];

  @Column({
    unsigned: true,
    unique: true,
  })
  leitorNetId: number;

  @Column({
    unsigned: true,
    unique: true,
  })
  leitorNetReleaseId: number;

  @Column({
    length: 110,
    unique: true,
  })
  leitorNetUrl: string;
}
