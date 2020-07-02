import {MigrationInterface, QueryRunner} from "typeorm";

export class IncreaseMangaNumberSize1593708971798 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE chapter MODIFY number varchar(15) NOT NULL');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE chapter MODIFY number varchar(10) NOT NULL');
  }
}
