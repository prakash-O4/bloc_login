part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class LogInEmailChanged extends LoginEvent {
  final String email;
  LogInEmailChanged({required this.email});
  @override
  List<Object?> get props => [email];
}

class LogInPasswordChanged extends LoginEvent {
  final String password;
  LogInPasswordChanged({required this.password});
  @override
  List<Object?> get props => [password];
}

class LogInSubmitted extends LoginEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
