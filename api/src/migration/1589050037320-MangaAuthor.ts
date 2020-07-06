import {MigrationInterface, QueryRunner} from "typeorm";

export class MangaAuthor1589050037320 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`manga_author\` (
        \`author_id\` INT UNSIGNED NOT NULL,
        \`manga_id\` INT UNSIGNED NOT NULL,
        INDEX \`fkIdx_36\` (\`author_id\` ASC) VISIBLE,
        INDEX \`fkIdx_39\` (\`manga_id\` ASC) VISIBLE,
        CONSTRAINT \`FK_36\`
          FOREIGN KEY (\`author_id\`)
          REFERENCES \`author\` (\`id\`),
        CONSTRAINT \`FK_39\`
          FOREIGN KEY (\`manga_id\`)
          REFERENCES \`manga\` (\`id\`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `manga_author`;');
  }
}
