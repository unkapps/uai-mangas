/* eslint-disable import/no-cycle */

import {
  Entity,
  ManyToOne,
  PrimaryColumn,
  Column,
  RelationId,
} from 'typeorm';
import User from './user';
import Chapter from './chapter';

@Entity()
export default class ChapterRead {
  @PrimaryColumn({
    insert: false,
    unsigned: true,
    name: 'chapter_id',
    type: 'int',
  })
  @ManyToOne(() => Chapter)
  chapter: Chapter;

  @PrimaryColumn({
    insert: false,
    unsigned: true,
    name: 'user_id',
    type: 'int',
  })
  @ManyToOne(() => User, (user) => user.chaptersRead)
  user: User;

  @Column()
  @RelationId((chapterRead: ChapterRead) => chapterRead.chapter)
  chapterId: number;

  @Column()
  @RelationId((chapterRead: ChapterRead) => chapterRead.user)
  userId: number;
}
