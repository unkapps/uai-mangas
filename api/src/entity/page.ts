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

  @Column('tinyint')
  number: number;

  @Column({
    length: 255,
  })
  imageUrl: string;

  @Column({
    length: 255,
    nullable: true,
  })
  imageUrlStorage?: string;

  @ManyToOne(() => Chapter, (chapter) => chapter.pages)
  chapter: Chapter;
}
