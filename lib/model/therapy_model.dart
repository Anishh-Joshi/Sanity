import 'package:sanity/model/user_info_model.dart';

class TherapyModel {
  final String? title;
  final int? therapyId;
  final int? doctorId;
  final String? category;
  final String? emoji;
  final int? involved;
  final DateTime? createdAt;
  final UserInfoModel? byDoctor;
  

  TherapyModel(
      {required this.title,
      required this.byDoctor,
      required this.therapyId,
      required this.doctorId,
      required this.category,
      required this.emoji,
      required this.involved,
      required this.createdAt});

  factory TherapyModel.fromJSON(Map response, Map emote,Map docInfo) {
    return TherapyModel(
        byDoctor: UserInfoModel.fromJson(docInfo),
        title: response['title'],
        therapyId: response["therapy_id"],
        doctorId: response['added_by_doctor'],
        category: response['category'],
        emoji: emote[response['category']],
        involved: response['involved'],
        createdAt: DateTime.parse(response['created_at']));
  }
}
