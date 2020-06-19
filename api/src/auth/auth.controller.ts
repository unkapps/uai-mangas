import {
  Controller,
  Body,
  Post,
} from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) { }

  @Post('firebase')
  async firebaseAuth(@Body() data: {tokenId}) {
    await this.authService.firebaseAuth(data.tokenId);
  }
}
