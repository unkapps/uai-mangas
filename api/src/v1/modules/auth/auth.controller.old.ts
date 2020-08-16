import {
  Controller,
  Post,
  Req,
  Query,
} from '@nestjs/common';

import { AuthService } from './auth.service';

/**
 * Old controller without /api/{version}
 * @deprecated
 */
@Controller('auth')
export class AuthOldController {
  constructor(
    private authService: AuthService,
  ) { }

  @Post('firebase')
  async firebaseAuth(@Req() request: any, @Query('fcmToken') fcmToken: string) {
    const tokenId = request.headers['token-id'] ?? null;

    await this.authService.firebaseAuth(tokenId, fcmToken);
  }
}
