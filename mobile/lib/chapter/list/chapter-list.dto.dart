import 'package:flutter/foundation.dart';

class ChapterListDto {
  final int id;
  final String number;
  final DateTime date;
  final bool readed;

  ChapterListDto({
    @required this.id,
    @required this.number,
    this.date,
    this.readed,
  });

  factory ChapterListDto.fromJson(Map<String, dynamic> json) {
    return ChapterListDto(
      id: json['id'] as int,
      number: json['number'] as String,
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      readed: (json['readed'] as String == '1'),
    );
  }
}
