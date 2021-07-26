part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class CrudLiked extends PostState {
  final bool likes;
  CrudLiked({required this.likes});
  @override
  List<Object?> get props => [likes];
}
