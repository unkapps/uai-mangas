import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MangaModule } from './manga/manga.module';
import { ChapterModule } from './chapter/chapter.module';
import { AuthModule } from './auth/auth.module';
import { defaultConnectionConfig } from './config/db.config';
import { envFilePath } from './config/env.config';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath,
    }),
    TypeOrmModule.forRootAsync({
      useFactory: async () => {
        return defaultConnectionConfig();
      },
    }),
    AuthModule,
    MangaModule,
    ChapterModule,
  ],
  controllers: [
    AppController,
  ],
  providers: [
    AppService,
  ],
})
export class AppModule {
  constructor() {
    console.log(`Running application in env: ${envFilePath} ${process.env.TYPE_ORM_LOGGING}`);
  }
}
