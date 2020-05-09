import {MigrationInterface, QueryRunner} from "typeorm";

export class ChapterRead1589049839947 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
      CREATE TABLE \`chapted_read\` (
        \`chapter_id\` INT UNSIGNED NOT NULL,
        \`user_id\` INT UNSIGNED NOT NULL,
        INDEX \`fkIdx_72\` (\`chapter_id\` ASC) VISIBLE,
        INDEX \`fkIdx_75\` (\`user_id\` ASC) VISIBLE,
        CONSTRAINT \`FK_72\`
          FOREIGN KEY (\`chapter_id\`)
          REFERENCES \`chapter\` (\`id\`),
        CONSTRAINT \`FK_75\`
          FOREIGN KEY (\`user_id\`)
          REFERENCES \`user\` (\`id\`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `chapted_read`;');
  }
}
