import {MigrationInterface, QueryRunner} from "typeorm";

export class MangaCategories1589050082905 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`manga_categories\` (
        \`category_id\` INT UNSIGNED NOT NULL,
        \`manga_id\` INT UNSIGNED NOT NULL,
        INDEX \`fkIdx_20\` (\`category_id\` ASC) VISIBLE,
        INDEX \`fkIdx_23\` (\`manga_id\` ASC) VISIBLE,
        CONSTRAINT \`FK_20\`
          FOREIGN KEY (\`category_id\`)
          REFERENCES \`category\` (\`id\`),
        CONSTRAINT \`FK_23\`
          FOREIGN KEY (\`manga_id\`)
          REFERENCES \`manga\` (\`id\`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;    
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `manga_categories`;');
  }
}
