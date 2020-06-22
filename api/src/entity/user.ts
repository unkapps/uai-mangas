/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  OneToMany,
} from 'typeorm';
import FollowingManga from './following-manga';

@Entity()
export default class User {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column({
    length: 128,
    unique: true,
  })
  uid: string;

  @OneToMany(() => FollowingManga, (followingManga) => followingManga.user)
  favoriteMangas: FollowingManga[];
}
