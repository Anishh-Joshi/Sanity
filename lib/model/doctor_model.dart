class DoctorModel {
  final String name;
  final String gender;
  final int doctorId;
  final String location;
  final int nmcId;
  final String profileUrl;

  DoctorModel(
      {required this.profileUrl,
      required this.doctorId,
      required this.name,
      required this.gender,
      required this.location,
      required this.nmcId});
  // final String worksIn;

  factory DoctorModel.fromJson(Map response) {
    return DoctorModel(
        name: response['full_name'],
        doctorId: response['id'],
        gender: response['gender'],
        location: response['location'],
        nmcId: response['nmcId'],
        profileUrl: response['profileImage']);
  }
}
