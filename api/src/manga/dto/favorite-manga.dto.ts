export default interface FavoriteMangaDto {
  id: number;
  name: string;
  nextChapterId: number;
  nextChapterNumber: string;
  neverReaded: boolean;
  coverUrl?: string;
}
