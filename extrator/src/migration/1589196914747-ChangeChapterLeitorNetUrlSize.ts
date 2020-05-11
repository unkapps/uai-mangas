import {MigrationInterface, QueryRunner} from "typeorm";

export class ChangeChapterLeitorNetUrlSize1589196914747 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `chapter` MODIFY `leitor_net_url` varchar(255);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `chapter` MODIFY `leitor_net_url` varchar(110);');
  }
}
