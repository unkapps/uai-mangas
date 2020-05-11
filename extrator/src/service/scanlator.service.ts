import { autoInjectable, singleton } from 'tsyringe';
import { EntityManager } from 'typeorm';

import Scanlator from '../entity/scanlator';
import ScanlatorDto from '../dto/scanlator.dto';

export const STATUS_FILE_PATH = './data/categories';

@singleton()
@autoInjectable()
export default class ScanlatorService {
  public async createOrGet(dto: ScanlatorDto, manager: EntityManager): Promise<Scanlator> {
    if (dto == null) {
      return null;
    }

    const databaseEntity = await manager
      .getRepository(Scanlator)
      .createQueryBuilder('scanlator')
      .where('scanlator.name = :name', { name: dto.name })
      .getOne();

    if (databaseEntity) {
      return databaseEntity;
    }

    return manager.save(await this.dtoToEntity(dto));
  }

  public async dtoToEntity(dto: ScanlatorDto): Promise<Scanlator> {
    const entity = new Scanlator();

    entity.name = dto.name;

    return entity;
  }
}
