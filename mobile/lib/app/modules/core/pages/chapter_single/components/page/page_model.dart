import 'package:flutter/foundation.dart';

class PageModel {
  final String imageUrl;

  double height = 50;

  PageModel({
    @required this.imageUrl,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      imageUrl: json['imageUrl'] as String,
    );
  }
}
