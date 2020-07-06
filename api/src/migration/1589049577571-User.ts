import { MigrationInterface, QueryRunner } from "typeorm";

export class User1589049577571 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`user\` (
        \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        \`name\` VARCHAR(100) NOT NULL,
        \`login\` VARCHAR(15) NOT NULL,
        \`email\` VARCHAR(255) NOT NULL,
        PRIMARY KEY (\`id\`),
        UNIQUE INDEX \`login_UNIQUE\` (\`login\` ASC) VISIBLE,
        UNIQUE INDEX \`email_UNIQUE\` (\`email\` ASC) VISIBLE)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `user`;');
  }
}
