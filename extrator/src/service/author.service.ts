import { autoInjectable, singleton } from 'tsyringe';
import { EntityManager } from 'typeorm';

import Author from '../entity/author';

export const STATUS_FILE_PATH = './data/categories';

@singleton()
@autoInjectable()
export default class AuthorService {
  public async createOrGetList(dtoList: string[], manager: EntityManager): Promise<Author[]> {
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

  public async createOrGet(dto: string, manager: EntityManager): Promise<Author> {
    if (dto == null) {
      return null;
    }

    const databaseEntity = await manager
      .getRepository(Author)
      .createQueryBuilder('author')
      .where('author.name = :name', { name: dto })
      .getOne();

    if (databaseEntity) {
      return databaseEntity;
    }

    return manager.save(await this.dtoToEntity(dto));
  }

  public async dtoToEntity(dto: string): Promise<Author> {
    const entity = new Author();

    entity.name = dto;

    return entity;
  }
}
