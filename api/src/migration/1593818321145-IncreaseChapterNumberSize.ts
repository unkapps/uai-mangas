import { MigrationInterface, QueryRunner } from "typeorm";

export class IncreaseChapterNumberSize1593818321145 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE chapter MODIFY number varchar(25) NOT NULL');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE chapter MODIFY number varchar(15) NOT NULL');
  }
}
