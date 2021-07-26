part of 'crud_bloc.dart';

abstract class CrudState extends Equatable {
  const CrudState();
}

class CrudInitial extends CrudState {
  @override
  List<Object?> get props => [];
}

class CrudLoading extends CrudState {
  @override
  List<Object?> get props => [];
}

class CrudSuccess extends CrudState {
  @override
  List<Object?> get props => [];
}

class CrudLoaded extends CrudState {
  final List<AuthCredentials> authCredentials;
  CrudLoaded({required this.authCredentials});
  @override
  List<Object?> get props => [authCredentials];
}

class CrudError extends CrudState {
  final String error;
  CrudError({required this.error});
  @override
  List<Object?> get props => [error];
}

class CrudImage extends CrudState {
  final File file;
  CrudImage({required this.file});
  @override
  List<Object?> get props => [file];
}
