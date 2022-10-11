class DasModel {
  final int dasId;
  final String question;
  final bool check;

  DasModel({required this.dasId, required this.question, required this.check});

  factory DasModel.fromJSON({required Map resposne}) {
    return DasModel(
        dasId: resposne['question_id'],
        question: resposne['question'],
        check: resposne['checked']);
  }
}
