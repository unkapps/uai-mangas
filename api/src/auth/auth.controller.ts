import {
  Controller,
  Post,
  Req,
} from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) { }

  @Post('firebase')
  async firebaseAuth(@Req() request: any) {
    const tokenId = request.headers['token-id'] ?? null;

    await this.authService.firebaseAuth(tokenId);
  }
}
