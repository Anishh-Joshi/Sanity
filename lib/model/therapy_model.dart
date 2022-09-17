import 'package:flutter/foundation.dart';
import 'dart:convert' show utf8;
class TherapyModel {
  final String? title;
  final int? therapyId;
  final int? doctorId;
  final String? category;
  final String? emoji;
  final int? involved;
  final DateTime? createdAt;

  TherapyModel(
      {required this.title,
      required this.therapyId,
      required this.doctorId,
      required this.category,
      required this.emoji,
      required this.involved,
      required this.createdAt});

  factory TherapyModel.fromJSON(Map response, Map emote) {
    return TherapyModel(
        title: response['title'],
        therapyId: response["therapy_id"],
        doctorId: response['added_by_doctor'],
        category: response['category'],
        emoji: emote[response['category']],
        involved: response['involved'],
        createdAt: DateTime.parse(response['created_at']));
  }
}
