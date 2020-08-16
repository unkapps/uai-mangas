import PageDto from 'src/page/dto/page.dto';

export default interface ChapterDto {
  id: number;

  mangaName: string;
  mangaId: number;

  number: string;
  pages: PageDto[];

  previousChapterId?: number;
  nextChapterId?: number;

  readed: string;
}
