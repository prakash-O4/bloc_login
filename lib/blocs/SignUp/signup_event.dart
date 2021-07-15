part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignUpNameChanged extends SignupEvent {
  final String userName;
  SignUpNameChanged({required this.userName});
  @override
  List<Object?> get props => [userName];
}

class SignUpEmailChanged extends SignupEvent {
  final String email;
  SignUpEmailChanged({required this.email});
  @override
  List<Object?> get props => [email];
}

class SignUpPasswordChanged extends SignupEvent {
  final String password;
  SignUpPasswordChanged({required this.password});
  @override
  List<Object?> get props => [password];
}

class SignUpConfPassChanged extends SignupEvent {
  final String confPassword;
  SignUpConfPassChanged({required this.confPassword});
  @override
  List<Object?> get props => [confPassword];
}

class SignUpSubmitted extends SignupEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
