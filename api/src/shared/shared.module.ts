import { Module } from '@nestjs/common';
import { UserModule } from 'src/user/user.module';
import { AuthModule } from 'src/auth/auth.module';
import { FirebaseModule } from 'src/firebase/firebase.module';

@Module({
  imports: [
    FirebaseModule,
    UserModule,
    AuthModule,
  ],
  exports: [
    FirebaseModule,
    UserModule,
    AuthModule,
  ],
  providers: [
  ],
})
export class SharedModule { }
