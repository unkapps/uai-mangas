import { MigrationInterface, QueryRunner } from "typeorm";

export class ChangeChapterNumberTypeToVarchar1589298505448 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `chapter` MODIFY `number` varchar(10) NOT NULL;');
    await queryRunner.query('CREATE INDEX `idx_manga_number` ON `chapter`(`manga_id`, `number`);');
    await queryRunner.query('CREATE INDEX `idx_number` ON `chapter`(`number`);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `chapter` MODIFY `number` decimal(6,1) NOT NULL;');
    await queryRunner.query('DROP INDEX `idx_manga_number` ON chapter;');
    await queryRunner.query('DROP INDEX `idx_number` ON chapter;');
  }
}
