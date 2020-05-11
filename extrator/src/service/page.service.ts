import { autoInjectable, singleton } from 'tsyringe';
import axios from 'axios';

import Chapter from '../entity/chapter';
import { ScanDto } from '../dto/chapter.dto';
import generateUid from '../util/generator-id';
import Page from '../entity/page';
import LeitorNetUrls, {
  LEITOR_NET_URL,
  LEITOR_NET_DEFAULT_HTTP_HEADERS,
  LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ,
} from '../leitor-net-urls';
import { saveImageFromHttp, compressImage } from '../util';
import { CHAPTERS_PATH } from '../config/general-craweler.config';
import ExitService from './exit.service';

export const STATUS_FILE_PATH = './data/categories';

@singleton()
@autoInjectable()
export default class PageService {
  constructor(
    private leitorNetUrls: LeitorNetUrls,
    private exitService: ExitService,
  ) { }

  public async createFromChapter(chapter: Chapter, scan: ScanDto): Promise<Page[]> {
    const token: string = await this.getTokenFromChapterPage(scan);

    const imagePaths: string[] = await this.downloadImages(await this.getImagesUrl(token, scan), chapter);

    const pages: Page[] = [];

    for (const imagePath of imagePaths) {
      const page: Page = new Page();

      page.chapter = chapter;
      page.imageFilePath = imagePath;
      page.imageUrl = page.imageFilePath.replace(CHAPTERS_PATH, '');

      pages.push(page);
    }

    return pages;
  }

  private async getTokenFromChapterPage(scan: ScanDto): Promise<string> {
    const url: string = `${LEITOR_NET_URL}${scan.link}`;

    const headers = Object.assign(LEITOR_NET_DEFAULT_HTTP_HEADERS);
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
      headers: LEITOR_NET_DEFAULT_HTTP_HEADERS_WITH_X_REQ,
    });

    return response.data.images as string[];
  }

  private async downloadImages(urls: string[], chapter: Chapter): Promise<string[]> {
    const paths: string[] = [];
    const pathWithoutFile = `${CHAPTERS_PATH}/${chapter.manga.id}/${chapter.number}/`;
    this.exitService.currentChapterFolderPath = pathWithoutFile;

    for (const url of urls) {
      const path = await saveImageFromHttp(url, this.getImageFileName(chapter), pathWithoutFile);
      paths.push(path);
    }

    await compressImage(pathWithoutFile);

    return paths;
  }


  public getImageFileName(chapter: Chapter): string {
    return `${chapter.manga.id}-${generateUid(12)}`;
  }
}
