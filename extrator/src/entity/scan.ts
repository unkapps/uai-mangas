/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  OneToMany,
} from 'typeorm';
import Chapter from './chapter';


@Entity()
export default class Scan {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column({
    length: 100,
    unique: true,
  })
  name: string;

  @OneToMany(() => Chapter, (chapter) => chapter.scan)
  chapters: Chapter[];

  @Column({
    length: 255,
    nullable: true,
  })
  url: string;
}
