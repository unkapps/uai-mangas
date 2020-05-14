import {MigrationInterface, QueryRunner} from "typeorm";

export class IndexDateOnChapter1589420598061 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('CREATE INDEX `idx_date` ON `chapter`(`date`);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP INDEX `idx_date` ON chapter;');
  }
}
