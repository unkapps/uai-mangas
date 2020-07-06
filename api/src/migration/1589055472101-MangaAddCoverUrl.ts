import { MigrationInterface, QueryRunner } from "typeorm";

export class MangaAddCoverUrl1589055472101 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `manga` ADD COLUMN `cover_url` varchar(255);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `manga` DROP COLUMN `cover_url`');
  }
}
