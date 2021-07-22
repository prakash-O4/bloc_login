import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logss/model/user_details.dart';
import 'package:logss/repositary/crud_repo.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final CRUDRepo _crudRepo = CRUDRepo();
  // ignore: cancel_subscriptions
  StreamSubscription? _streamSubscription;
  CrudBloc() : super(CrudInitial());

  @override
  Stream<CrudState> mapEventToState(
    CrudEvent event,
  ) async* {
    if (event is AddArticles) {
      try {
        await _crudRepo.addNotes(event.authCredentials);
      } catch (e) {}
    } else if (event is ReadArticles) {
      yield CrudLoading();
      try {
        yield* _mapStreamToState();
      } catch (e) {
        yield CrudError(error: e.toString());
      }
    } else if (event is ArticlesUpdatd) {
      yield* _mapToFetchArticles(event);
    } else if (event is DeleteArticles) {
      try {
        yield* _mapDeleteToStates(event.authCredential);
        yield* _mapStreamToState();
      } catch (e) {
        yield CrudError(error: e.toString());
      }
    } else if (event is UpdateArticles) {
      try {
        print("id is"+event.authCredentials.id);
        await _crudRepo.updateArticles(event.authCredentials);
        yield* _mapStreamToState();
        print("finished update");
      } catch (e) {
        yield CrudError(error: "update error");
      }
    }
  }

  Stream<CrudState> _mapStreamToState() async* {
    _crudRepo.getArticles().listen((event) {
      add(ArticlesUpdatd(auth: event));
    });
    _streamSubscription?.cancel();
  }

  Stream<CrudState> _mapToFetchArticles(ArticlesUpdatd event) async* {
    yield CrudLoaded(authCredentials: event.auth);
  }

  Stream<CrudState> _mapDeleteToStates(AuthCredentials authCredentials) async* {
    await _crudRepo.deleteArticles(authCredentials);
    _mapStreamToState();
  }
}
