import User from 'src/entity/user';
import { Injectable } from '@nestjs/common';
import { UserRepository } from './user.repository';

@Injectable()
export class UserService {
  constructor(private userRepository: UserRepository) { }

  getUserIdByUid(uid: string): Promise<number> {
    return this.userRepository.getUserByUid(uid);
  }

  async saveOrGetUser(uid: string): Promise<number> {
    const userId = await this.getUserIdByUid(uid);

    if (userId != null) {
      return userId;
    }

    let newUser: User = new User();
    newUser.uid = uid;

    newUser = await this.userRepository.save(newUser);

    return newUser.id;
  }
}
