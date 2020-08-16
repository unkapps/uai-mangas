import { Injectable } from '@nestjs/common';

import { CategoryRepository } from './category.repository';
import Category from 'src/entity/category';

@Injectable()
export class CategoryService {
  constructor(
    private categoryRepository: CategoryRepository,
  ) { }
  getAll(): Promise<Category[]> {
    return this.categoryRepository.getAll();
  }
}
