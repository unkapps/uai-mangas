/* eslint-disable import/no-cycle */

import {
  Entity,
  ManyToOne,
  PrimaryColumn,
  Column,
  RelationId,
} from 'typeorm';
import Manga from './manga';
import User from './user';

@Entity()
export default class FollowingManga {
  @PrimaryColumn({
    insert: false,
    unsigned: true,
    name: 'manga_id',
    type: 'number',
  })
  @ManyToOne(() => Manga)
  manga: Manga;

  @PrimaryColumn({
    insert: false,
    unsigned: true,
    name: 'user_id',
    type: 'number',
  })
  @ManyToOne(() => User, (user) => user.favoriteMangas)
  user: User;

  @Column()
  @RelationId((followingManga: FollowingManga) => followingManga.manga)
  mangaId: number;

  @Column()
  @RelationId((followingManga: FollowingManga) => followingManga.user)
  userId: number;
}
