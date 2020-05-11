import CategoryDto from './category.dto';

export default interface MangaDto {
  id_serie: number;
  name: string;
  chapters: number;
  description: string;
  cover: string;
  /**
   * string containing one or more authors splitted by &
   */
  author: string;
  /**
   * string containing one or more authors splitted by &
   */
  artist: string;
  score: string;
  votes: string;
  categories: CategoryDto[];
  link: string;
  is_complete: boolean;
}
