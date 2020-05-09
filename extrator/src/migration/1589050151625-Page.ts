import {MigrationInterface, QueryRunner} from "typeorm";

export class Page1589050151625 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`page\` (
        \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        \`chapter_id\` INT UNSIGNED NOT NULL,
        \`url\` VARCHAR(255) NOT NULL,
        PRIMARY KEY (\`id\`),
        INDEX \`fkIdx_53\` (\`chapter_id\` ASC) VISIBLE,
        CONSTRAINT \`FK_53\`
          FOREIGN KEY (\`chapter_id\`)
          REFERENCES \`chapter\` (\`id\`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `page`;');
  }
}
