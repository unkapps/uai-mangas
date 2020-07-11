import { CronJob, CronJobParameters } from 'cron';

export default class CronJobExtended {
  private cronJob: CronJob;

  private taskInProgress: boolean;

  constructor(cronJobParameters: CronJobParameters, task: () => Promise<void>) {
    // eslint-disable-next-line no-param-reassign
    cronJobParameters.onTick = async () => {
      console.log('trying start');
      if (this.taskInProgress) {
        return;
      }
      console.log('task started');

      this.taskInProgress = true;

      try {
        await task();
      } catch (err) {
        console.error(err);
      }

      this.taskInProgress = false;
    };

    this.cronJob = new CronJob(cronJobParameters);
  }

  start() {
    this.cronJob.start();
  }
}
