part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class UnknownState extends SessionState {}

class Authenticated extends SessionState {}

class UnAuthenticated extends SessionState {}
