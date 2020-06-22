import {MigrationInterface, QueryRunner} from "typeorm";

export class AddUniqueFollowingManga1592869157835 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('CREATE UNIQUE INDEX `idx_unique_following_manga` ON `following_manga`(`user_id`, `manga_id`);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP INDEX `idx_unique_following_manga` ON following_manga;');
  }
}
