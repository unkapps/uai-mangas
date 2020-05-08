/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
} from 'typeorm';
import Chapter from './chapter';


@Entity()
export default class Page {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column({
    length: 255,
  })
  url: string;

  @ManyToOne(() => Chapter, (chapter) => chapter.pages)
  chapter: Chapter;
}
