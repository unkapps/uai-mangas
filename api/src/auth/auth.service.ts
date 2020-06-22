import * as admin from 'firebase-admin';
import { Injectable } from '@nestjs/common';
import { UserService } from 'src/user/user.service';

@Injectable()
export class AuthService {
  private adminApp: admin.app.App;

  constructor(private userService: UserService) {
    this.adminApp = admin.initializeApp({
      credential: admin.credential.applicationDefault(),
      databaseURL: 'https://uai-mangas.firebaseio.com',
    });
  }

  async getUserId(tokenId: string): Promise<number> {
    if (tokenId == null) {
      return null;
    }

    try {
      const decodedToken = await this.adminApp.auth().verifyIdToken(tokenId, true);

      return this.userService.getUserIdByUid(decodedToken.uid);
    } catch (err) {
      return null;
    }
  }

  async firebaseAuth(tokenId: string) {
    const decodedToken = await this.adminApp.auth().verifyIdToken(tokenId);

    return this.userService.saveOrGetUser(decodedToken.uid);
  }
}
