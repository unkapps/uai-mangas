import { MigrationInterface, QueryRunner } from "typeorm";

export class ChangePageNumberType1593611446765 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE page CHANGE number number SMALLINT UNSIGNED NOT NULL');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE page CHANGE number number TINYINT NOT NULL');
  }
}
