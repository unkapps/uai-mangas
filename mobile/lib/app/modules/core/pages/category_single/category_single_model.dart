import 'package:flutter/foundation.dart';

class CategorySingleModel {
  final int id;
  final String name;

  CategorySingleModel({
    @required this.id,
    @required this.name,
  });

  factory CategorySingleModel.fromJson(Map<String, dynamic> json) {
    return CategorySingleModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
