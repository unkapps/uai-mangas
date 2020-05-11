import { MigrationInterface, QueryRunner } from "typeorm";

export class ChangeMangaLeitorNetUrlSize1589196619920 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `manga` MODIFY `leitor_net_url` varchar(255);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `manga` MODIFY `leitor_net_url` varchar(110);');
  }
}
