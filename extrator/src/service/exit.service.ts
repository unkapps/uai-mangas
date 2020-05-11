import { autoInjectable, singleton } from 'tsyringe';
import fs from 'fs';

@singleton()
@autoInjectable()
export default class ExitService {
  /**
   * Used to delete the 'cover' of disk in errors or ungraceful exit.
   */
  public currentMangaCoverFilePath: string;

  public currentChapterFolderPath: string;

  public doActionBeforeExit() {
    process.on('exit', this.exitHandler.bind(this, { cleanup: true }));

    // catches ctrl+c event
    process.on('SIGINT', this.exitHandler.bind(this, { exit: true }));

    // catches "kill pid" (for example: nodemon restart)
    process.on('SIGUSR1', this.exitHandler.bind(this, { exit: true }));
    process.on('SIGUSR2', this.exitHandler.bind(this, { exit: true }));

    // catches uncaught exceptions
    process.on('uncaughtException', this.exitHandler.bind(this, { exit: true }));
  }

  private exitHandler(options) {
    console.log('Cleaning unnecessary files before exit.');
    this.deleteSyncCoverFileOfCurrentCover();
    this.deleteSyncImagesFromCurrentChapter();
    if (options.exit) process.exit();
  }

  private deleteSyncCoverFileOfCurrentCover(): void {
    if (!this.currentMangaCoverFilePath || !fs.existsSync(this.currentMangaCoverFilePath)) {
      return;
    }

    fs.unlinkSync(this.currentMangaCoverFilePath);
  }

  private deleteSyncImagesFromCurrentChapter(): void {
    if (!this.currentChapterFolderPath || !fs.existsSync(this.currentChapterFolderPath)) {
      return;
    }

    fs.rmdirSync(this.currentChapterFolderPath, { recursive: true });
  }
}
