import { EntityRepository, Repository } from 'typeorm';

import User from 'src/entity/user';

@EntityRepository(User)
export class UserRepository extends Repository<User> {
  async getUserByUid(uid: string): Promise<number> {
    const result = await this
      .createQueryBuilder('user')
      .select('user.id', 'id')
      .where('user.uid = :uid', { uid })
      .getRawOne();

    if (result) {
      return result.id;
    }

    return null;
  }
}
