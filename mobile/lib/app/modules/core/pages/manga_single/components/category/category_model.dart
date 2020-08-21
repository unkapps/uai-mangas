import 'package:flutter/foundation.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({
    @required this.id,
    @required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
