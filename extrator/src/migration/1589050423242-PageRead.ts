import {MigrationInterface, QueryRunner} from "typeorm";

export class PageRead1589050423242 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`page_read\` (
        \`page_id\` INT UNSIGNED NOT NULL,
        \`user_id\` INT UNSIGNED NOT NULL,
        INDEX \`fkIdx_79\` (\`page_id\` ASC) VISIBLE,
        INDEX \`fkIdx_82\` (\`user_id\` ASC) VISIBLE,
        CONSTRAINT \`FK_79\`
          FOREIGN KEY (\`page_id\`)
          REFERENCES \`page\` (\`id\`),
        CONSTRAINT \`FK_82\`
          FOREIGN KEY (\`user_id\`)
          REFERENCES \`user\` (\`id\`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `page_read`;');
  }
}
