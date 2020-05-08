import { autoInjectable } from 'tsyringe';
import { getConnection } from 'typeorm';
import slugify from 'slugify';

import Category from '../entity/category';
import CategoryDto from '../dto/category.dto';

@autoInjectable()
export default class CategoryService {
  public async createOrGet(categoryDto: CategoryDto): Promise<Category> {
    const connection = await getConnection();

    const databaseCategory = await connection
      .getRepository(Category)
      .createQueryBuilder('category')
      .where('category.name = :name', { name: categoryDto.name })
      .getOne();

    if (databaseCategory) {
      return databaseCategory;
    }

    return connection.manager.save(this.dtoToEntity(categoryDto));
  }

  public dtoToEntity(dto: CategoryDto): Category {
    const c = new Category();

    c.name = dto.name;
    c.leitorNetUrl = dto.link.replace(/\\\//g, '/');
    c.leitorNetId = dto.id_category;
    c.slug = slugify(c.name);

    return c;
  }
}
