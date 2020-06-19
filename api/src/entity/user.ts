/* eslint-disable import/no-cycle */

import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity()
export default class User {
  @PrimaryGeneratedColumn({ unsigned: true })
  id: number;

  @Column({
    length: 128,
    unique: true,
  })
  uid: string;
}
