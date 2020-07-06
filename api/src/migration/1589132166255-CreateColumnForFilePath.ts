import { MigrationInterface, QueryRunner } from "typeorm";

export class CreateColumnForFilePath1589132166255 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `manga` ADD COLUMN `cover_file_path` varchar(255);');
    await queryRunner.query('ALTER TABLE `page` ADD COLUMN `image_file_path` varchar(255) NOT NULL;');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `manga` DROP COLUMN `cover_file_path`');
    await queryRunner.query('ALTER TABLE `page` DROP COLUMN `image_file_path`');
  }
}
