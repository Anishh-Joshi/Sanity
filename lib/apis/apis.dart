class APIs {
  get localhost => "10.0.2.2:8000";
  get getDoctorList => "http://$localhost/api/assistant/doctors/";

  get loginUrl => "http://$localhost/api/user/login/";
  get signInUrl => "http://$localhost/api/user/register/";
  get user => "http://$localhost/api/user/profile/";
  get setProfile => "http://$localhost/api/user/setprofile/";
  get sendDailyLog => "http://$localhost/api/assistant/set/dailylog/";

  String retrieveLog({int id = 1}) {
    return "http://$localhost/api/assistant/get/dailylog/?id=1";
  }

  String userProfile({required int id}) {
    return "http://$localhost/api/user/get/profile/?id=$id";
  }

  String retrieveAppointment({required int id}) {
    return "http://$localhost/api/assistant/retrieve/appointment/?id=$id";
  }

  String requestAppointment() {
    return "http://$localhost/api/assistant/request/appointment/";
  }

  String updateAppointment(int id) {
    return "http://$localhost/api/assistant/update/appointment/?id=$id";
  }
}
