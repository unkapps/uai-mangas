import * as admin from 'firebase-admin';
import { Injectable } from '@nestjs/common';
import { UserService } from 'src/user/user.service';
import FirebaseConfig from 'src/firebase/firebase_config';

@Injectable()
export class AuthService {
  constructor(
    private firebaseConfig: FirebaseConfig,
    private userService: UserService,
  ) {
  }

  async getUserId(tokenId: string): Promise<number> {
    if (tokenId == null) {
      return null;
    }

    try {
      const decodedToken = await this.firebaseConfig.adminApp.auth().verifyIdToken(tokenId, true);

      return this.userService.getUserIdByUid(decodedToken.uid);
    } catch (err) {
      return null;
    }
  }

  async firebaseAuth(tokenId: string, fcmToken: string): Promise<number> {
    const decodedToken = await this.firebaseConfig.adminApp.auth().verifyIdToken(tokenId);

    const userId = await this.userService.saveOrGetUser(decodedToken.uid);

    await this.subscribeToAllFavorites(userId, fcmToken);

    return userId;
  }

  async subscribeToAllFavorites(userId: number, fcmToken: string): Promise<void> {
    const mangasId = await this.userService.getFavoriteMangasId(userId);

    for (const mangaId of mangasId) {
      await this.firebaseConfig.adminApp.messaging().subscribeToTopic(fcmToken, `${mangaId}`);
    }
  }
}
