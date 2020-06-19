import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SnakeNamingStrategy } from 'typeorm-naming-strategies';
import { getConnectionOptions } from 'typeorm';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MangaModule } from './manga/manga.module';
import { ChapterModule } from './chapter/chapter.module';
import { AuthModule } from './auth/auth.module';

const envFilePath = process.env.NODE_ENV === 'prod' ? '.env' : '.local.env';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath,
    }),
    TypeOrmModule.forRootAsync({
      useFactory: async () => {
        const connectionOptions = await getConnectionOptions();


        return Object.assign(connectionOptions, {
          namingStrategy: new SnakeNamingStrategy(),
          logging: true,
        });
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
