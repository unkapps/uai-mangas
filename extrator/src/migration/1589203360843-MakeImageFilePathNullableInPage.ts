import { MigrationInterface, QueryRunner } from "typeorm";

export class MakeImageFilePathNullableInPage1589203360843 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `page` MODIFY `image_file_path` varchar(255);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('ALTER TABLE `page` MODIFY `image_file_path` varchar(255) NOT NULL;');
  }
}
