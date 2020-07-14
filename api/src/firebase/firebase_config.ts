import * as admin from 'firebase-admin';
import { Injectable } from '@nestjs/common';

@Injectable()
export default class FirebaseConfig {
  adminApp: admin.app.App;

  constructor() {
    this.adminApp = admin.initializeApp({
      credential: admin.credential.applicationDefault(),
      databaseURL: 'https://uai-mangas.firebaseio.com',
    });
  }
}
