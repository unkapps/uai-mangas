import { autoInjectable } from "tsyringe";

export const LEITOR_NET_URL = 'https://leitor.net/';
export const CATEGORIES_URL = `${LEITOR_NET_URL}categories/categories_list.json`;

@autoInjectable()
export default class LeitorNetUrls {
  public getCategoriesUrl(): string {
    return CATEGORIES_URL;
  }

  public getSeriesUrl(page: number, categoryId: string): string {
    return `${LEITOR_NET_URL}categories/series_list.json?page=${page}&id_category=${categoryId}`;
  }

  public getChaptersListUrl(page: number, mangaId: string): string {
    return `${LEITOR_NET_URL}series/chapters_list.json?page=${page}&id_serie=${mangaId}`;
  }

  public getImagesUrl(releaseId: string, token: string): string {
    return `${LEITOR_NET_URL}leitor/pages/${releaseId}.json?key=${token}`;
  }

  public newReleasesUrl(page: number): string {
    return `${LEITOR_NET_URL}home/releases?page=${page}`;
  }
}
