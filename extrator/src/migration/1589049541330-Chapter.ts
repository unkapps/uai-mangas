import {MigrationInterface, QueryRunner} from "typeorm";

export class Chapter1589049541330 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`chapter\` (
        \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        \`number\` DECIMAL(6, 1) NOT NULL,
        \`manga_id\` INT UNSIGNED NOT NULL,
        \`scanlator_id\` INT UNSIGNED,
        \`date\` DATETIME NOT NULL,
        \`title\` TINYTEXT NULL DEFAULT NULL,
        \`leitor_net_id\` INT UNSIGNED NOT NULL,
        \`leitor_net_release_id\` INT UNSIGNED NOT NULL,
        \`leitor_net_url\` VARCHAR(110) NOT NULL,
        PRIMARY KEY (\`id\`),
        INDEX \`fkIdx_44\` (\`manga_id\` ASC) INVISIBLE,
        INDEX \`fkIdx_93\` (\`scanlator_id\` ASC) VISIBLE,
        UNIQUE INDEX \`leitor_net_id_UNIQUE\` (\`leitor_net_id\` ASC) VISIBLE,
        UNIQUE INDEX \`leitor_net_release_id_UNIQUE\` (\`leitor_net_release_id\` ASC) VISIBLE,
        UNIQUE INDEX \`leitor_net_url_UNIQUE\` (\`leitor_net_url\` ASC) VISIBLE,
        CONSTRAINT \`FK_44\`
          FOREIGN KEY (\`manga_id\`)
          REFERENCES \`manga\` (\`id\`),
        CONSTRAINT \`FK_93\`
          FOREIGN KEY (\`scanlator_id\`)
          REFERENCES \`scanlator\` (\`id\`)
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
