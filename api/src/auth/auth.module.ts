import { Module } from '@nestjs/common';
import { UserModule } from 'src/user/user.module';
import { AuthController } from './auth.controller';
import { FirebaseAuthGuard } from './firebase-auth.guard';
import { AuthService } from './auth.service';

@Module({
  imports: [
    UserModule,
  ],
  providers: [
    AuthService,
    FirebaseAuthGuard,
  ],
  controllers: [AuthController],
  exports: [
    AuthService,
    FirebaseAuthGuard,
  ],
})
export class AuthModule { }
