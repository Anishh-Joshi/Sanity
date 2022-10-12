class DasModel {
  final int dasId;
  final String question;
  final bool check;
  bool one = true;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  bool six = false;
  bool seven = false;

  DasModel({required this.dasId, required this.question, required this.check});


  setBoolOne(bool value){
    one = !value;

  }

  factory DasModel.fromJSON({required Map resposne}) {
    return DasModel(
        dasId: resposne['question_id'],
        question: resposne['question'],
        check: resposne['checked']);
  }
}
