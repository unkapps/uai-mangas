import { autoInjectable, singleton } from 'tsyringe';
import axios, { AxiosResponse } from 'axios';
import util from 'util';

// import { setTimeout } from 'timers';
import * as parser from 'fast-xml-parser';
import { parse } from 'node-html-parser';


import LeitorNetUrls, { LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT } from '../leitor-net-urls';
import { SitemapUrlDto } from './sitemap.dto';
import { MS_WAIT_BETWEEN_PAGES } from '../config/general-craweler.config';

const setTimeoutPromise = util.promisify(setTimeout);
const MAXIMUM_NUMBER_OF_NEWS = 150;

export interface NewMangaSitemap {
  leitorNetId: number;
  url: string;
}

@singleton()
@autoInjectable()
export default class ExtratorSitemap {
  constructor(
    private leitorNetUrls: LeitorNetUrls,
  ) {
  }

  public async getNewMangas(): Promise<NewMangaSitemap[]> {
    console.log('reading new mangas (sitemap)');

    const regex = /^(https?:\/\/leitor\.net\/manga\/.+\/)\d+\/.+$/;
    const regexId = /\/manga\/.+\/(\d+)$/;

    const response = await this.doRequestForNewMangas();
    const newSeries = parser.parse(response.data).urlset.url as SitemapUrlDto[];
    const seriesUrlByManga: Map<string, string> = new Map<string, string>();

    const limit = newSeries.length > MAXIMUM_NUMBER_OF_NEWS ? MAXIMUM_NUMBER_OF_NEWS : newSeries.length;

    for (let i = 0; i < limit; i += 1) {
      const newSerie = newSeries[i];
      const match = regex.exec(newSerie.loc);
      if (match != null && match.length > 1 && match[1] != null) {
        if (!seriesUrlByManga.has(match[1])) {
          seriesUrlByManga.set(match[1], match[0]);
        }
      }
    }

    // for (const newSerie of newSeries) {
    //   if (!mangaUrlByLeitorNetId.has[newSerie.id_serie]) {
    //     mangaUrlByLeitorNetId.set(newSerie.id_serie, newSerie.link);
    //   }
    // }

    console.log('getting new mangas url (sitemap)');

    const seriesUrl = seriesUrlByManga.values();

    const newMangasReturn: NewMangaSitemap[] = [];

    for (const serieUrl of seriesUrl) {
      try {
        const mangaUrl = await this.getMangaUrl(serieUrl);

        if (mangaUrl != null) {
          const match = regexId.exec(mangaUrl);

          if (match != null && match.length > 1 && match[1] != null) {
            newMangasReturn.push({
              url: mangaUrl,
              leitorNetId: Number(match[1]),
            });
          }

        }
        await setTimeoutPromise(MS_WAIT_BETWEEN_PAGES / 4);
      } catch (err) {
        console.error(`Error on getting url ${serieUrl} - Error on reading sitemap`);
        console.error(err);
      }

      console.log('All new mangas url getted (sitemap)');

      return newMangasReturn;
    }

  private doRequestForNewMangas(): Promise<AxiosResponse<any>> {
    return axios.get(this.leitorNetUrls.sitemapUrl(), {
      headers: LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT,
      timeout: 10000,
    });
  }

  private async getMangaUrl(serieUrl: string): Promise<string> {
    const response = await axios.get(serieUrl, {
      headers: LEITOR_NET_DEFAULT_HTTP_HEADERS_ALL_ACCEPT,
    });

    const root = parse(response.data);

    const linkElement = root.querySelector('#reader-wrapper .series-info-popup-container .series-cover a');

    if (linkElement == null) {
      return null;
    }

    return linkElement.getAttribute('href');
  }
}
