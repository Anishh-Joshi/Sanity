class APIs {
  get localhost => "10.0.2.2:8000";
  // get localhost => "sanityhealth.herokuapp.com";

  get getDoctorList => "http://$localhost/api/assistant/doctors/";

  String getDocInfo({required int profileId}) =>
      "http://$localhost/api/user/get/info/?id=$profileId";
  String setDocInfo() => "http://$localhost/api/user/set/info";
  String updateDocInfo({required int profileId}) =>
      "http://$localhost/api/user/update/info/?id=$profileId";

  get loginUrl => "http://$localhost/api/user/login/";
  get changePassword => "http://$localhost/api/user/changepassword/";
  get signInUrl => "http://$localhost/api/user/register/";
  get sendVerification => "http://$localhost/api/user/send/verification/";
  get user => "http://$localhost/api/user/profile/";
  get setProfile => "http://$localhost/api/user/setprofile/";
  get sendDailyLog => "http://$localhost/api/assistant/set/dailylog/";
  get getDass => "http://$localhost/api/assistant/get/das/";
  String retrieveLog({int? id}) {
    return "http://$localhost/api/assistant/get/dailylog/?id=$id";
  }

  String setEmailVerified({int? id}) {
    return "http://$localhost/api/user/verify/?id=$id";
  }

  String getAnswers({required int? id}) {
    return "http://$localhost/api/assistant/get/answer/?id=$id";
  }

  get setAnswer => "http://$localhost/api/assistant/set/answer/";

  String updateProfile({required int id}) {
    return "http://$localhost/api/user/update/profile/?id=$id";
  }

  String userProfile({required int id}) {
    return "http://$localhost/api/user/get/profile/?id=$id";
  }

  String retrieveAppointment(
      {required int id, required int key, required String cat}) {
    return "http://$localhost/api/assistant/retrieve/appointment/?id=$id&key=$key&cat=$cat";
  }

  String requestAppointment() {
    return "http://$localhost/api/assistant/request/appointment/";
  }

  String updateAppointment(int id) {
    return "http://$localhost/api/assistant/update/appointment/?id=$id";
  }

  String getTherapyByDoctor({required int id}) {
    return "http://$localhost/api/assistant/get/therapy/?id=$id";
  }

  String getAllTherapy() {
    return "http://$localhost/api/assistant/get/therapy/";
  }

  String updateTherapy(int id) {
    return "http://$localhost/api/assistant/update/therapy/id=$id";
  }

  String deleteTherapy(int id) {
    return "http://$localhost/api/assistant/delete/therapy/?id=$id";
  }

  String deleteThread({required int threadId}) {
    return "http://$localhost/api/assistant/delete/threads/?id=$threadId";
  }

  String getTherapyDetails({required int id}) {
    return "http://$localhost/api/assistant/get/therapy_details/?id=$id";
  }

  get addTherapy => "http://$localhost/api/assistant/add/therapy/";
  get addTherapyDetails =>
      "http://$localhost/api/assistant/add/therapy_details/";

  String incrementInvolved({required int id}) {
    return "http://$localhost/api/assistant/update/therapy/?id=$id";
  }

  get fetchAllThreads => "http://$localhost/api/assistant/get/threads/?id=x";
  String getuserThread(int id) =>
      "http://$localhost/api/assistant/get/threads/?id$id";

  get upVote => "http://$localhost/api/assistant/add/upvote/";

  String downVote({required int id, required int userId}) {
    return "http://$localhost/api/assistant/remove/upvote/?id=$id&key=$userId";
  }

  get addThread => "http://$localhost/api/assistant/add/threads/";

  String updateDocsInvolved({required int threadId}) =>
      "http://$localhost/api/assistant/update/threads/?id=$threadId";

  get addComment => "http://$localhost/api/assistant/add/comment/";

  String getComment({required int threadId}) =>
      "http://$localhost/api/assistant/get/comment/?id=$threadId";

  String getReplies({required int commentId}) =>
      "http://$localhost/api/assistant/get/replies/?id=$commentId";

  get addReply => "http://$localhost/api/assistant/add/reply/";

  String removeComment({required int commentId}) =>
      "http://$localhost/api/assistant/add/comment/?id=$commentId";
  String removeReply({required int replyId}) =>
      "http://$localhost/api/assistant/add/reply/?id=$replyId";

  get sendReport => "http://$localhost/api/assistant/report/";

  String getNumbers(int id) =>
      "http://$localhost/api/assistant/profile/numbers/?id=$id";

  get setPattern => "http://$localhost/api/assistant/set/pattern/";

  String getPattern(int id) =>
      "http://$localhost/api/assistant/set/pattern/?id=$id";
}
