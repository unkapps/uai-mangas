import {
  Controller,
  Post,
  Req,
  Query,
} from '@nestjs/common';

import { AuthService } from './auth.service';

@Controller('api/v1/auth')
export class AuthController {
  constructor(
    private authService: AuthService,
  ) { }

  @Post('firebase')
  async firebaseAuth(@Req() request: any, @Query('fcmToken') fcmToken: string) {
    const tokenId = request.headers['token-id'] ?? null;

    await this.authService.firebaseAuth(tokenId, fcmToken);
  }
}
