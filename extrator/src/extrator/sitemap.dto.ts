export interface SitemapDto {
  url: SitemapUrlDto;
}

export interface SitemapUrlDto {
  loc: string;
  changefreq: string;
  priority: number;
}
