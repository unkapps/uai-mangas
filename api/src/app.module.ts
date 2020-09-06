import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CoreModule } from './v1/modules/core/core.module';
import { AuthModule } from './v1/modules/auth/auth.module';
import { defaultConnectionConfig } from './config/db.config';
import { envFilePath } from './config/env.config';
import { migrationRunner } from './migration-runner';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath,
    }),
    TypeOrmModule.forRootAsync({
      useFactory: async () => {
        await migrationRunner();

        return defaultConnectionConfig();
      },
    }),
    AuthModule,
    CoreModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {
  constructor() {
    console.log(
      `Running application in env: ${envFilePath} ${process.env.TYPE_ORM_LOGGING}`,
    );
  }
}
