import { autoInjectable, singleton } from 'tsyringe';
import axios from 'axios';

import Chapter from '../entity/chapter';
import { ScanDto } from '../dto/chapter.dto';
import generateUid from '../util/generator-id';
import Page from '../entity/page';
import LeitorNetUrls from '../leitor-net-urls';

export const STATUS_FILE_PATH = './data/categories';

@singleton()
@autoInjectable()
export default class PageService {
  constructor(private leitorNetUrls: LeitorNetUrls) {}

  public async createFromChapter(chapter: Chapter, scan: ScanDto): Promise<Page[]> {
    const token: string = await this.getTokenFromChapterPage(scan);

    const imagesUrl: string[] = await this.getImagesUrl(token, scan);

    const pages: Page[] = [];

    let i = 1;
    for (const imageUrl of imagesUrl) {
      const page: Page = new Page();

      page.chapter = chapter;
      page.imageUrl = imageUrl;
      page.number = i;

      i += 1;

      pages.push(page);
    }

    return pages;
  }

  private async getTokenFromChapterPage(scan: ScanDto): Promise<string> {
    const url: string = `${this.leitorNetUrls.url}${scan.link}`;

    const headers = Object.assign(this.leitorNetUrls.defaultHttpHeaders);
    delete headers.accept;

    const response = await axios.get(url, {
      headers,
    });

    // eslint-disable-next-line no-useless-escape
    const regexToken = new RegExp(/[\&\?]token\=(\w+)\&?/i);
    const html = response.data;
    return html.match(regexToken)[1];
  }

  private async getImagesUrl(token: string, scan: ScanDto): Promise<string[]> {
    const url = this.leitorNetUrls.getImagesUrl(scan.id_release, token);
    const response = await axios.get(url, {
      headers: this.leitorNetUrls.defaultHttpHeadersWithXReq,
    });

    return response.data.images as string[];
  }

  public getImageFileName(chapter: Chapter): string {
    return `${chapter.manga.id}-${generateUid(12)}`;
  }
}
