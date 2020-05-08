import { autoInjectable } from 'tsyringe';
import { getConnection } from 'typeorm';
import slugify from 'slugify';

import Category from '../entity/category';
import CategoryDto from '../dto/category.dto';

import WaitBetween from './wait-between';
import { MINIMUM_HOURS_BETWEEN_CRAWLER_CATEGORY } from './wait-between';

export const STATUS_FILE_PATH = './data/categories';

@autoInjectable()
export default class CategoryService extends WaitBetween {
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

  public async isTimeToCralwer(): Promise<boolean> {
    return super.isTimeToCralwer(STATUS_FILE_PATH, MINIMUM_HOURS_BETWEEN_CRAWLER_CATEGORY);
  }

  public saveEndOfCrawler(): Promise<void> {
    return super.saveEndOfCrawler(STATUS_FILE_PATH);
  }
}
