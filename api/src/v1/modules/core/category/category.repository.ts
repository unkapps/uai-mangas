import { EntityRepository, Repository } from 'typeorm';

import Category from 'src/entity/category';

@EntityRepository(Category)
export class CategoryRepository extends Repository<Category> {
  getAll(): Promise<Category[]> {
    return this.manager.getRepository(Category)
      .createQueryBuilder('category')
      .select([
        'category.id',
        'category.name',
      ])
      .orderBy('category.name')
      .where('category.adult = 0')
      .getMany();
  }
}
