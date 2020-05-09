import {MigrationInterface, QueryRunner} from "typeorm";

export class FollowingManga1589049965404 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`following_manga\` (
        \`user_id\` INT UNSIGNED NOT NULL,
        \`manga_id\` DECIMAL(11,1) UNSIGNED NOT NULL,
        INDEX \`fkIdx_63\` (\`user_id\` ASC) VISIBLE,
        INDEX \`fkIdx_68\` (\`manga_id\` ASC) VISIBLE,
        CONSTRAINT \`FK_63\`
          FOREIGN KEY (\`user_id\`)
          REFERENCES \`user\` (\`id\`),
        CONSTRAINT \`FK_68\`
          FOREIGN KEY (\`manga_id\`)
          REFERENCES \`manga\` (\`id\`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `following_manga`;');
  }
}
