
import {
  Controller,
  Get,
} from '@nestjs/common';

import Category from 'src/entity/category';
import { CategoryService } from './category.service';

@Controller('/api/v1/category')
export class CategoryController {
  constructor(private readonly categoryService: CategoryService) { }

  @Get('')
  findAll(): Promise<Category[]> {
    return this.categoryService.getAll();
  }
}
