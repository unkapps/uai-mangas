import { autoInjectable, singleton } from 'tsyringe';
import { AxiosProxyConfig } from 'axios';

export const LEITOR_NET_URL = 'https://leitor.net';
export const MANGA_LIVRE_NET_URL = 'https://mangalivre.net';

const LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT = {
  authority: 'leitor.net',
  accept: '*/*',
  'user-agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36',
  'Accept-Encoding': 'gzip',
};

const LEITOR_NET_DEFAULT_HTTP_HEADERS = {
  ...LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT,
  accept: 'application/json, text/javascript, */*; q=0.01',
};

const LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ = {
  ...LEITOR_NET_DEFAULT_HTTP_HEADERS,
  'x-requested-with': 'XMLHttpRequest',
};

const MANGA_LIVRE_DEFAULT_HTTP_HEADERS_ALL_ACCEPT = {
  authority: 'mangalivre.net',
  accept: '*/*',
  'user-agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36',
  'Accept-Encoding': 'gzip',
};

const MANGA_LIVRE_DEFAULT_HTTP_HEADERS = {
  ...MANGA_LIVRE_DEFAULT_HTTP_HEADERS_ALL_ACCEPT,
  accept: 'application/json, text/javascript, */*; q=0.01',
};

const MANGA_LIVRE_DEFAULT_HTTP_HEADERS_WITH_X_REQ = {
  ...MANGA_LIVRE_DEFAULT_HTTP_HEADERS,
  'x-requested-with': 'XMLHttpRequest',
};

@singleton()
@autoInjectable()
export default class LeitorNetUrls {
  public useLeitorNet = true;

  get url() {
    return this.useLeitorNet ? LEITOR_NET_URL : MANGA_LIVRE_NET_URL;
  }

  get defaultHttpHeadersAllAccept() {
    return this.useLeitorNet ? LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT : MANGA_LIVRE_DEFAULT_HTTP_HEADERS_ALL_ACCEPT;
  }

  get proxy(): AxiosProxyConfig | false {
    if (this.useLeitorNet) {
      return false;
    }

    return {
      host: '167.250.65.246',
      port: 8080,
      protocol: 'http',
    } as AxiosProxyConfig;
  }

  get defaultHttpHeaders() {
    return this.useLeitorNet ? LEITOR_NET_DEFAULT_HTTP_HEADERS : MANGA_LIVRE_DEFAULT_HTTP_HEADERS;
  }

  get defaultHttpHeadersWithXReq() {
    return this.useLeitorNet ? LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ : MANGA_LIVRE_DEFAULT_HTTP_HEADERS_WITH_X_REQ;
  }

  get categoriesUrl() {
    return `${this.url}/categories/categories_list.json`;
  }

  public getCategoriesUrl(): string {
    return this.categoriesUrl;
  }

  public getSeriesUrl(page: number, categoryId: number): string {
    return `${this.url}/categories/series_list.json?page=${page}&id_category=${categoryId}`;
  }

  public getMangaUrl(mangaId: number, url?: string): string {
    if (url != null) {
      return `${this.url}${url}`;
    }
    return `${this.url}/manga/a/${mangaId}`;
  }

  public getChaptersListUrl(page: number, mangaId: number): string {
    return `${this.url}/series/chapters_list.json?page=${page}&id_serie=${mangaId}`;
  }

  public getImagesUrl(releaseId: number, token: string): string {
    return `${this.url}/leitor/pages/${releaseId}.json?key=${token}`;
  }

  public newReleasesUrl(page: number): string {
    return `${this.url}/home/releases?page=${page}`;
  }

  public newMangasUrl(): string {
    return `${this.url}/home/getNewSeries`;
  }

  public sitemapUrl(): string {
    return `${this.url}/leitor/sitemap/1.xml`;
  }
}
