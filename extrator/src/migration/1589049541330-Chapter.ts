import {MigrationInterface, QueryRunner} from "typeorm";

export class Chapter1589049541330 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`chapter\` (
        \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        \`number\` DECIMAL(6, 1) NOT NULL,
        \`manga_id\` INT UNSIGNED NOT NULL,
        \`scan_id\` INT UNSIGNED NOT NULL,
        \`date\` DATETIME NOT NULL,
        \`title\` TINYTEXT NULL DEFAULT NULL,
        PRIMARY KEY (\`id\`),
        INDEX \`fkIdx_44\` (\`manga_id\` ASC) INVISIBLE,
        INDEX \`fkIdx_93\` (\`scan_id\` ASC) VISIBLE,
        CONSTRAINT \`FK_44\`
          FOREIGN KEY (\`manga_id\`)
          REFERENCES \`manga\` (\`id\`),
        CONSTRAINT \`FK_93\`
          FOREIGN KEY (\`scan_id\`)
          REFERENCES \`scan\` (\`id\`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `chapter`;');
  }
}
