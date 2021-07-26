import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostLiked) {
      print("inside post bloc");
      try {
        await Future.delayed(Duration(milliseconds: 300));
        yield CrudLiked(likes: event.likes ? false : true);
        print("post completed");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
