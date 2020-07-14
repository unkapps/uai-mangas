import { EntityRepository, Repository } from 'typeorm';

import User from 'src/entity/user';
import FollowingManga from 'src/entity/following-manga';

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

  public async getFavoriteMangasId(userId: number): Promise<number[]> {
    const results = await this.manager.getRepository(FollowingManga)
      .createQueryBuilder('followingManga')
      .select(['followingManga.mangaId'])
      .where('followingManga.userId = :userId', { userId })
      .getMany();

    if (!results) {
      return [];
    }

    return results.map((result) => result.mangaId);
  }
}
