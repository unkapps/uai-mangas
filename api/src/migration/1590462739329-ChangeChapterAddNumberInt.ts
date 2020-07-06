import {MigrationInterface, QueryRunner} from "typeorm";

export class ChangeChapterAddNumberInt1590462739329 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `chapter` ADD COLUMN`number_int` INT UNSIGNED;');
    await queryRunner.query('UPDATE IGNORE chapter set number_int = cast(number as unsigned);');
    await queryRunner.query('CREATE INDEX `idx_number_int` ON `chapter`(`number_int`);');
    await queryRunner.query('ALTER TABLE `chapter` MODIFY `number_int` INT UNSIGNED NOT NULL;');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `chapter` DROP COLUMN `number_int`;');
    await queryRunner.query('DROP INDEX `idx_number_int` ON chapter;');
  }
}
