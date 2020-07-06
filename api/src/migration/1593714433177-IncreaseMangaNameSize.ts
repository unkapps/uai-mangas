import { MigrationInterface, QueryRunner } from "typeorm";

export class IncreaseMangaNameSize1593714433177 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE manga MODIFY name varchar(200) NOT NULL');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE manga MODIFY name varchar(150) NOT NULL');
  }
}
