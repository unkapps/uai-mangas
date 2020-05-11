import { MigrationInterface, QueryRunner } from "typeorm";

export class PageChangeAttr1589055279522 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `page` CHANGE `url` `image_url` varchar(255);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `page` CHANGE `image_url` `url` varchar(255);');
  }
}
