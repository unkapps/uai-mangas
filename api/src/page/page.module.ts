import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { PageService } from './page.service';
import { PageController } from './page.controller';
import { PageRepository } from './page.repository';

@Module({
  imports: [
    TypeOrmModule.forFeature([PageRepository]),
  ],
  providers: [
    PageService,
  ],
  controllers: [
    PageController,
  ],
})
export class PageModule { }
