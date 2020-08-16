import { Module } from '@nestjs/common';
import { UserModule } from 'src/user/user.module';
import { FirebaseModule } from 'src/firebase/firebase.module';
import { AuthController } from './auth.controller';
import { FirebaseAuthGuard } from './firebase-auth.guard';
import { AuthService } from './auth.service';
import { AuthOldController } from './auth.controller.old';

@Module({
  imports: [
    FirebaseModule,
    UserModule,
  ],
  providers: [
    AuthService,
    FirebaseAuthGuard,
  ],
  controllers: [
    AuthController,
    AuthOldController,
  ],
  exports: [
    AuthService,
    FirebaseAuthGuard,
  ],
})
export class AuthModule { }
