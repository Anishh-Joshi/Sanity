import 'package:equatable/equatable.dart';

class LogModel extends Equatable{
  final String text;
  final String createdAt;
  final double depressionScore;

  const LogModel({required this.text, required this.createdAt, required this.depressionScore});

  factory LogModel.fromJson(Map response){
    return LogModel(
      text: response['log'], 
      createdAt: response['created_at'], 
      depressionScore: response['depression_score']);
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [text,createdAt,depressionScore];


}