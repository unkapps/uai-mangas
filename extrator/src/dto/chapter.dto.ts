import ScanlatorDto from './scanlator.dto';

export default interface ChapterDto {
  id_serie: number;
  id_chapter: number;
  name: string;
  chapter_name: string;
  number: string;
  numberValue: number;
  date: string;
  date_created: string;
  releases: any;
}

export interface ScanDto {
  id_release: number;
  scanlators: ScanlatorDto[];
  views: string;
  link: string;
}
