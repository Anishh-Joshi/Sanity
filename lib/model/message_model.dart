import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final Timestamp? timeStamp;
  final int? sentBy;
  final String? messageText;
  final List seenBy;

  MessageModel(
      {required this.messageText,
      required this.seenBy,
      required this.messageId,
      required this.sentBy,
      required this.timeStamp});

  factory MessageModel.fromJSON(DocumentSnapshot response) {
    return MessageModel(
        messageId: response.id,
        messageText: response.get('messageText'),
        seenBy: response.get('seenBy'),
        sentBy: response.get('sentBy'),
        timeStamp: response.get('timestamp'));
  }
}
