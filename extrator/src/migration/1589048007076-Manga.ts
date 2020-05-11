import { MigrationInterface, QueryRunner } from "typeorm";

export class Manga1589048007076 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`manga\` (
        \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        \`name\` VARCHAR(150) NOT NULL,
        \`slug\` VARCHAR(200) NOT NULL,
        \`finished\` TINYINT(1) NULL DEFAULT NULL,
        \`description\` TEXT NULL DEFAULT NULL,
        \`leitor_net_id\` INT UNSIGNED NOT NULL,
        \`leitor_net_url\` VARCHAR(110) NOT NULL,
        PRIMARY KEY (\`id\`),
        UNIQUE INDEX \`name_UNIQUE\` (\`name\` ASC) VISIBLE,
        UNIQUE INDEX \`leitor_net_id_UNIQUE\` (\`leitor_net_id\` ASC) VISIBLE,
        UNIQUE INDEX \`leitor_net_url_UNIQUE\` (\`leitor_net_url\` ASC) VISIBLE)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `manga`;');
  }
}
