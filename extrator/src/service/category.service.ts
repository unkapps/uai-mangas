import { autoInjectable, singleton } from 'tsyringe';
import { getConnection, EntityManager } from 'typeorm';
import slugify from 'slugify';

import Category from '../entity/category';
import CategoryDto from '../dto/category.dto';

import WaitBetween, { MINIMUM_HOURS_BETWEEN_CRAWLER_CATEGORY } from './wait-between';
import { fileExists, readFile, writeFile, unlink } from '../util';
import { STATUS_CRAWLER_CATEGORIES_FILE_PATH, CURRENT_CATEGORY_FILE_PATH } from '../config/general-craweler.config';

@singleton()
@autoInjectable()
export default class CategoryService extends WaitBetween {
  public async createOrGetList(dtoList: CategoryDto[], manager: EntityManager): Promise<Category[]> {
    if (dtoList == null) {
      return null;
    }

    if (dtoList.length === 0) {
      return [];
    }

    const entities = [];
    for (const dto of dtoList) {
      entities.push(await this.createOrGet(dto, manager));
    }

    return entities;
  }

  public async createOrGet(dto: CategoryDto, externalManager?: EntityManager): Promise<Category> {
    if (dto == null) {
      return null;
    }

    const connection = await getConnection();

    const manager = externalManager || connection.manager;

    const databaseCategory = await manager
      .getRepository(Category)
      .createQueryBuilder('category')
      .where('category.leitorNetId = :leitorNetId', { leitorNetId: dto.id_category })
      .getOne();

    if (databaseCategory) {
      return databaseCategory;
    }

    if (externalManager) {
      return externalManager.save(await this.dtoToEntity(dto));
    }
    return connection.transaction(async (newManager) => {
      return newManager.save(await this.dtoToEntity(dto));
    });
  }

  public async getAllStartingOnId(id: number): Promise<Category[]> {
    const connection = await getConnection();

    return connection
      .getRepository(Category)
      .createQueryBuilder('category')
      .where('category.id >= :id', { id })
      .getMany();
  }

  public async dtoToEntity(dto: CategoryDto): Promise<Category> {
    const c = new Category();

    c.name = dto.name;
    c.leitorNetUrl = dto.link.replace(/\\\//g, '/');
    c.leitorNetId = dto.id_category;
    c.slug = slugify(c.name);

    return c;
  }

  public async isTimeToCralwer(): Promise<boolean> {
    return super.isTimeToCralwer(STATUS_CRAWLER_CATEGORIES_FILE_PATH, MINIMUM_HOURS_BETWEEN_CRAWLER_CATEGORY);
  }

  public saveEndOfCrawler(): Promise<void> {
    return super.saveEndOfCrawler(STATUS_CRAWLER_CATEGORIES_FILE_PATH);
  }

  public async deleteIfExistisCurrentCategory(): Promise<void> {
    if (await fileExists(CURRENT_CATEGORY_FILE_PATH)) {
      await unlink(CURRENT_CATEGORY_FILE_PATH);
    }
  }

  public async getIdFromCurrentCategoryOnCrawler(): Promise<CategoryIdPage> {
    if (await fileExists(CURRENT_CATEGORY_FILE_PATH)) {
      const fileContent = await readFile(CURRENT_CATEGORY_FILE_PATH, 'utf-8');
      const infos = fileContent.split(',');

      return {
        categoryId: Number(infos[0]),
        page: Number(infos[1]),
      };
    }

    return null;
  }

  public async setIdFromCurrentCategoryOnCrawler(categoryidPage: CategoryIdPage): Promise<void> {
    return writeFile(CURRENT_CATEGORY_FILE_PATH, `${categoryidPage.categoryId},${categoryidPage.page}`, 'utf-8');
  }
}

export interface CategoryIdPage {
  categoryId: number;
  page: number;
}
