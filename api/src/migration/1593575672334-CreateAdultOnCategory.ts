import { MigrationInterface, QueryRunner } from "typeorm";

export class CreateAdultOnCategory1593575672334 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE category add column adult TINYINT(1)');
    await queryRunner.query('UPDATE category SET adult = 0');
    await queryRunner.query('ALTER TABLE category CHANGE adult adult TINYINT(1) NOT NULL');
    await queryRunner.query('CREATE INDEX `idx_adult` ON `category`(`adult`);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP INDEX `idx_adult` ON category;');
    await queryRunner.query('ALTER TABLE category drop column adult');
  }
}
