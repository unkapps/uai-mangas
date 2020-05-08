import { Connection } from 'typeorm';
import { autoInjectable } from 'tsyringe';
import axios from 'axios';

import LeitorNetUrls from './leitor-net-urls';
import CategoryService from './service/category.service';
import CategoryDto from './dto/category.dto';
import DatabaseConfig from './config/database.config';

@autoInjectable()
export default class Extrator {
  private connection: Connection;

  constructor(
    private leitorNetUrls: LeitorNetUrls,
    private categoryService: CategoryService,
    private databaseConfig: DatabaseConfig,
  ) {

  }

  public async run(): Promise<void> {
    this.connection = await this.databaseConfig.createConnection();

    try {
      await this.readCategories();
    } finally {
      this.connection.close();
    }
  }

  private async readCategories() {
    const response = await axios.get(this.leitorNetUrls.getCategoriesUrl());
    const categories = response.data.categories_list;

    return Promise.all(categories.map((category) => this.categoryService.createOrGet(category as CategoryDto)));
  }
}
