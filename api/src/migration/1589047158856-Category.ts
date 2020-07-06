import { MigrationInterface, QueryRunner } from "typeorm";

export class Category1589047158856 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`category\` (
        \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        \`name\` VARCHAR(50) NOT NULL,
        \`slug\` VARCHAR(60) NOT NULL,
        \`leitor_net_url\` VARCHAR(60) NOT NULL,
        \`leitor_net_id\` INT UNSIGNED NOT NULL,
        PRIMARY KEY (\`id\`),
        UNIQUE INDEX \`name_UNIQUE\` (\`name\` ASC) VISIBLE,
        UNIQUE INDEX \`slug_UNIQUE\` (\`slug\` ASC) VISIBLE,
        UNIQUE INDEX \`leitor_net_url_UNIQUE\` (\`leitor_net_url\` ASC) VISIBLE,
        UNIQUE INDEX \`leitor_net_id_UNIQUE\` (\`leitor_net_id\` ASC) VISIBLE)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `category`;');
  }
}
