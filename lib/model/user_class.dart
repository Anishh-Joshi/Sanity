import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final bool? isEmailVerified;
  final int? id;
  const User({this.email, this.isEmailVerified, this.id});

  @override
  List<Object?> get props => [email, isEmailVerified, id];
  factory User.fromJson(Map response) {
    return User(
        id: response['id'],
        email: response['email'],
        isEmailVerified: response['is_email_verified']);
  }
}
