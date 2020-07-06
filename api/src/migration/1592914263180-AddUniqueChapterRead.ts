import { MigrationInterface, QueryRunner } from "typeorm";

export class AddUniqueChapterRead1592914263180 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('RENAME TABLE `chapted_read` TO `chapter_read`;');
    await queryRunner.query('CREATE UNIQUE INDEX `idx_unique_chapter_read` ON `chapter_read`(`user_id`, `chapter_id`);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP INDEX `idx_unique_chapter_read` ON chapter_read;');
    await queryRunner.query('RENAME TABLE `chapter_read` TO `chapted_read`;');
  }
}
