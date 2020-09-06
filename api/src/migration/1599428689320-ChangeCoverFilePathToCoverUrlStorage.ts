import { MigrationInterface, QueryRunner } from 'typeorm';

export class ChangeCoverFilePathToCoverUrlStorage1599428689320
  implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(
      'ALTER TABLE manga RENAME COLUMN cover_file_path TO cover_url_storage',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(
      'ALTER TABLE manga RENAME COLUMN cover_url_storage TO cover_file_path',
    );
  }
}
