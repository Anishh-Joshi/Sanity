class DoctorModel {
  final String name;
  final String gender;
  final String location;
  final int nmcId;
  final String profileUrl;

  DoctorModel(
      {required this.profileUrl,
      required this.name,
      required this.gender,
      required this.location,
      required this.nmcId});
  // final String worksIn;

  factory DoctorModel.fromJson(Map response) {
    return DoctorModel(
        name: response['full_name'],
        gender: response['gender'],
        location: response['location'],
        nmcId: response['nmcId'],
        profileUrl: response['profileImage']);
  }
}
