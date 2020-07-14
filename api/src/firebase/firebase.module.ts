import { Module } from '@nestjs/common';
import FirebaseConfig from './firebase_config';

@Module({
  imports: [
  ],
  providers: [
    FirebaseConfig,
  ],
  controllers: [],
  exports: [
    FirebaseConfig,
  ],
})
export class FirebaseModule { }
