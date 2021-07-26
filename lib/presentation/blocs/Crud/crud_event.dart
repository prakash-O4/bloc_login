part of 'crud_bloc.dart';

abstract class CrudEvent extends Equatable {
  const CrudEvent();
}

class AddArticles extends CrudEvent {
  final AuthCredentials authCredentials;
  AddArticles({required this.authCredentials});
  @override
  List<Object?> get props => [];
}

class ReadArticles extends CrudEvent {
  @override
  List<Object?> get props => [];
}

class UpdateArticles extends CrudEvent {
  final AuthCredentials authCredentials;
  UpdateArticles({required this.authCredentials});
  @override
  List<Object?> get props => [authCredentials];
}

class DeleteArticles extends CrudEvent {
  final AuthCredentials authCredential;
  DeleteArticles({required this.authCredential});
  @override
  List<Object?> get props => [authCredential];
}

class ArticlesUpdatd extends CrudEvent {
  final List<AuthCredentials> auth;
  ArticlesUpdatd({required this.auth});
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetImage extends CrudEvent {
  @override
  List<Object?> get props => [];
}
