import { autoInjectable, singleton } from 'tsyringe';

export const LEITOR_NET_URL = 'https://leitor.net';
export const CATEGORIES_URL = `${LEITOR_NET_URL}/categories/categories_list.json`;

export const LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT = {
  authority: 'leitor.net',
  accept: '*/*',
  'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36',
  'Accept-Encoding': 'gzip',
};
export const LEITOR_NET_DEFAULT_HTTP_HEADERS = {
  ...LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT,
  accept: 'application/json, text/javascript, */*; q=0.01',
};

export const LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ = {
  ...LEITOR_NET_DEFAULT_HTTP_HEADERS,
  'x-requested-with': 'XMLHttpRequest',
};

@singleton()
@autoInjectable()
export default class LeitorNetUrls {
  public getCategoriesUrl(): string {
    return CATEGORIES_URL;
  }

  public getSeriesUrl(page: number, categoryId: number): string {
    return `${LEITOR_NET_URL}/categories/series_list.json?page=${page}&id_category=${categoryId}`;
  }

  public getMangaUrl(mangaId: number, url?: string): string {
    if (url != null) {
      return `${LEITOR_NET_URL}${url}`;
    }
    return `${LEITOR_NET_URL}/manga/a/${mangaId}`;
  }

  public getChaptersListUrl(page: number, mangaId: number): string {
    return `${LEITOR_NET_URL}/series/chapters_list.json?page=${page}&id_serie=${mangaId}`;
  }

  public getImagesUrl(releaseId: number, token: string): string {
    return `${LEITOR_NET_URL}/leitor/pages/${releaseId}.json?key=${token}`;
  }

  public newReleasesUrl(page: number): string {
    return `${LEITOR_NET_URL}/home/releases?page=${page}`;
  }
}
