part of 'dass41_bloc.dart';

abstract class Dass41State extends Equatable {
  const Dass41State();

  @override
  List<Object> get props => [];
}

class Dass41Initial extends Dass41State {}

class Dass41Loaded extends Dass41State {
  final bool? termsAndConditions;
  final List? questions;
  final String? category;

  const Dass41Loaded({this.category, this.questions, this.termsAndConditions});
  @override
  List<Object> get props => [
        termsAndConditions!,
        questions!,
        category!,
      ];
}

class PdfRequested extends Dass41State {
  final List? questionsPdf;
  final String? category;
  final List? answers;
  final String? created_at;

  const PdfRequested({this.created_at, this.questionsPdf, this.category, this.answers});

  @override
  List<Object> get props => [category!,created_at!, answers!, questionsPdf!];
}

class Dass41Error extends Dass41State {}
