import { Module } from '@nestjs/common';
import { UserModule } from 'src/user/user.module';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [
    UserModule,
    AuthModule,
  ],
  exports: [
    UserModule,
    AuthModule,
  ],
})
export class SharedModule { }
