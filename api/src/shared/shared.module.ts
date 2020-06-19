import { Module } from '@nestjs/common';
import { UserModule } from 'src/user/user.module';

@Module({
  imports: [
    UserModule,
  ],
  exports: [
    UserModule,
  ],
})
export class SharedModule { }
