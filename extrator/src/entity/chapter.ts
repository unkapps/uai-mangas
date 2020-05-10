/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  OneToMany,
} from 'typeorm';

import Manga from './manga';
import Scan from './scan';
import Page from './page';

@Entity()
export default class Chapter {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column({
    length: 100,
  })
  name: string;

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

  @ManyToOne(() => Scan, (scan) => scan.chapters)
  scan: Scan;

  @Column('datetime')
  date: Date;

  @Column('tinytext', { nullable: true })
  title?: string;

  @OneToMany(() => Page, (page) => page.chapter)
  pages: Page[];
}
