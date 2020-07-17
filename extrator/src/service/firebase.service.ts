import * as admin from 'firebase-admin';
import { autoInjectable, singleton } from 'tsyringe';

@singleton()
@autoInjectable()
export default class FirebaseService {
  adminApp: admin.app.App;

  constructor() {
    this.adminApp = admin.initializeApp({
      credential: admin.credential.applicationDefault(),
      databaseURL: 'https://uai-mangas.firebaseio.com',
    });
  }

  newChapter(mangaId: number, mangaName: string, chapterNumber: string): Promise<admin.messaging.MessagingTopicResponse> {
    return this.adminApp.messaging().sendToTopic(`${mangaId}`, {
      notification: {
        title: 'Novo Capítulo',
        body: `#${chapterNumber} de ${mangaName} está disponível`,
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
        sound: 'default',
      },
      data: {
        manga_id: `${mangaId}`,
      },
    }, {
      timeToLive: 604800, // 1 week
      priority: 'high',
    });
  }
}
