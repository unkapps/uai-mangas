import { MigrationInterface, QueryRunner } from "typeorm";

export class Author1589046369681 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`author\` (
        \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        \`name\` VARCHAR(100) NOT NULL,
        PRIMARY KEY (\`id\`),
        UNIQUE INDEX \`name_UNIQUE\` (\`name\` ASC) VISIBLE)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `author`;');
  }
}
