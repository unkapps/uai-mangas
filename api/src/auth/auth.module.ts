import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';

@Module({
  imports: [
    SharedModule,
  ],
  providers: [AuthService],
  controllers: [AuthController],
})
export class AuthModule { }
