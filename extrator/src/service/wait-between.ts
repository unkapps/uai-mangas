import { fileExists, writeFile, readFile } from '../util';

export const MINIMUM_HOURS_BETWEEN_CRAWLER_CATEGORY = 48;

export default abstract class WaitBetween {
  protected async isTimeToCralwer(filePath: string, minimumHoursBetweenCrawler: number): Promise<boolean> {
    if (await fileExists(filePath)) {
      const lastDate = new Date(await readFile(filePath, 'utf-8'));
      const msBetweenCrawler = new Date().getTime() - lastDate.getTime();
      return msBetweenCrawler / 3600000 >= minimumHoursBetweenCrawler;
    }

    return true;
  }

  protected saveEndOfCrawler(filePath: string): Promise<void> {
    return writeFile(filePath, new Date().toISOString(), 'utf-8');
  }
}
