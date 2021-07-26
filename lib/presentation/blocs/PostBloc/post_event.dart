part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostLiked extends PostEvent {
  final bool likes;
  PostLiked({required this.likes});
  @override
  List<Object?> get props => [likes];
}
