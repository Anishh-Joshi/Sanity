class DoctorInfoModel {
  final String major;
  final String degree;
  final String tenure;
  final int infoId;
  final int rating;
  final String education;

  DoctorInfoModel({
    required this.education,
    required this.major,
    required this.rating,
    required this.infoId,
    required this.degree,
    required this.tenure,
  });

  factory DoctorInfoModel.fromJson(Map response) {
    return DoctorInfoModel(
        major: response['major_in'],
        infoId: response['id'],
        degree: response['degree'],
        rating: response['rating'],
        tenure: response['tenure'],
        education: response['education']);
  }
}
