import { MigrationInterface, QueryRunner } from "typeorm";

export class AlterUser1592592368689 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('alter table user drop index login_unique;');
    await queryRunner.query('alter table user drop index email_unique;');
    await queryRunner.query('alter table user drop column name;');
    await queryRunner.query('alter table user drop column login;');
    await queryRunner.query('alter table user drop column email;');
    await queryRunner.query('alter table user add uid varchar(128) NOT NULL;');
    await queryRunner.query('create unique index `uid_unique` on user (`uid`);');
  }

  public async down(queryRunner: QueryRunner): Promise<any> {

    await queryRunner.query('alter table \`name\` VARCHAR(100) NOT NULL');
    await queryRunner.query('alter table \`login\` VARCHAR(15) NOT NULL');
    await queryRunner.query('alter table \`email\` VARCHAR(255) NOT NULL');
    await queryRunner.query('create unique index `login_UNIQUE` on user (`login`);');
    await queryRunner.query('create unique index `email_UNIQUE` on user (`email`);');
    await queryRunner.query('ALTER TABLE user DROP INDEX uid_unique;');
    await queryRunner.query('alter table user drop column uid;');
  }
}
