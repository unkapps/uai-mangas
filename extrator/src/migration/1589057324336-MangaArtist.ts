import { MigrationInterface, QueryRunner } from "typeorm";

export class MangaArtist1589057324336 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query(`
    CREATE TABLE \`manga_artist\` (
      \`author_id\` INT UNSIGNED NOT NULL,
      \`manga_id\` INT UNSIGNED NOT NULL,
      INDEX \`fkIdx_mangaArtist_authorId_author_id\` (\`author_id\` ASC) VISIBLE,
      INDEX \`fkIdx_mangaArtist_mangaId_manga_id\` (\`manga_id\` ASC) VISIBLE,
      CONSTRAINT \`fk_mangaArtist_authorId_author_id\`
        FOREIGN KEY (\`author_id\`)
        REFERENCES \`author\` (\`id\`),
      CONSTRAINT \`fk_mangaArtist_mangaId_manga_id\`
        FOREIGN KEY (\`manga_id\`)
        REFERENCES \`manga\` (\`id\`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;
  `);
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.query('DROP TABLE `manga_artist`;');
  }
}
