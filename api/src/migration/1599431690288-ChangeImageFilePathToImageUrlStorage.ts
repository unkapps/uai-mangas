import { MigrationInterface, QueryRunner } from 'typeorm';

export class ChangeImageFilePathToImageUrlStorage1599431690288
  implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(
      'ALTER TABLE page RENAME COLUMN image_file_path TO image_url_storage',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(
      'ALTER TABLE page RENAME COLUMN image_url_storage TO image_file_path',
    );
  }
}
