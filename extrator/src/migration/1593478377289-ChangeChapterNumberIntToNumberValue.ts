import { MigrationInterface, QueryRunner } from "typeorm";

export class ChangeChapterNumberIntToNumberValue1593478377289 implements MigrationInterface {

  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP INDEX `idx_number_int` ON chapter;');
    await queryRunner.query('ALTER TABLE `chapter` DROP COLUMN `number_int`;');

    await queryRunner.query('ALTER TABLE `chapter` ADD COLUMN `number_value` DOUBLE UNSIGNED;');
    await queryRunner.query('CREATE INDEX `idx_number_int` ON chapter (number_value);');
    await queryRunner.query('CREATE UNIQUE INDEX `idx_unique_manga_chapter_number` ON chapter (manga_id, number_value);');
  }

  public async down(): Promise<any> {
    // I DON'T WANNA COME BACK :D
  }

}
