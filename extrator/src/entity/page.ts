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

  @Column({ unsigned: true, type: 'smallint' })
  number: number;

  @Column({
    length: 255,
  })
  imageUrl: string;

  @Column({
    length: 255,
    nullable: true,
  })
  imageFilePath?: string;

  @ManyToOne(() => Chapter, (chapter) => chapter.pages)
  chapter: Chapter;
}
