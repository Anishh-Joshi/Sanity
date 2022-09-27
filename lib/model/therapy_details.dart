import 'package:sanity/model/user_info_model.dart';

class TherapyDetailsModel {
  final int? therapyDetailId;
  final int? therapyId;
  final int? doctorProfileId;
  final String? contents;
  final UserInfoModel? byDoctor;

  TherapyDetailsModel({
    this.byDoctor,
    this.therapyDetailId,
    this.therapyId,
    this.doctorProfileId,
    this.contents,
  });

  factory TherapyDetailsModel.fromJSON(Map responseTherapy) {
    return TherapyDetailsModel(
        therapyDetailId: responseTherapy["id"],
        therapyId: responseTherapy["fk_therapy_id"],
        doctorProfileId: responseTherapy["doctor_profile_id"],
        contents: responseTherapy["contents"],);
  }
}
