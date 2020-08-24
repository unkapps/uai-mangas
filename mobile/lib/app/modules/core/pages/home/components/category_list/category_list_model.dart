import 'package:flutter/foundation.dart';

class CategoryListModel {
  final int id;
  final String name;

  CategoryListModel({
    @required this.id,
    @required this.name,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return CategoryListModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
