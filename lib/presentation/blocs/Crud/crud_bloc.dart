import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logss/data/repositary/crud_repo.dart';
import 'package:logss/domain/model/user_details.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final CRUDRepo _crudRepo = CRUDRepo();
  StreamSubscription? _streamSubscription;
  CrudBloc() : super(CrudInitial());

  @override
  Stream<CrudState> mapEventToState(
    CrudEvent event,
  ) async* {
    if (event is AddArticles) {
      yield CrudLoading();
      try {
        AuthCredentials _authCredentials = event.authCredentials;
        await _crudRepo.addNotes(_authCredentials);
        yield CrudSuccess();
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
      yield CrudLoading();
      try {
        await _crudRepo.updateArticles(event.authCredentials);
        yield* _mapStreamToState();
        yield CrudSuccess();
      } catch (e) {
        yield CrudError(error: "update error");
      }
    } else if (event is GetImage) {
      try {
        var _file = await _crudRepo.getImage();
        if (_file != null) {
          yield CrudImage(file: _file);
        }
      } catch (e) {
        yield CrudError(error: "Image error");
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
