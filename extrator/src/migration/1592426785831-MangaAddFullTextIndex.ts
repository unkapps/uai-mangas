import { MigrationInterface, QueryRunner } from "typeorm";

export class MangaAddFullTextIndex1592426785831 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE manga ADD FULLTEXT INDEX manga_full (name);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE manga DROP INDEX manga_full;');
  }
}
