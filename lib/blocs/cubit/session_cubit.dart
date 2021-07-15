import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logss/repositary/auth_repo.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepo _authRepo = AuthRepo();
  SessionCubit() : super(UnknownState()) {
    checkSession();
  }

  void checkSession() async {
    var status = await _authRepo.isLogIn();
    if (status) {
      showAuth();
    } else {
      showUnAuth();
    }
  }

  void showAuth() => emit(Authenticated());

  void showUnAuth() => emit(UnAuthenticated());

  void logOut() {
    _authRepo.logOut();
    showUnAuth();
    print("logged out");
  }

  Future<User?> getUserInfo() async {
    User? user = await _authRepo.getUser();
    return user;
  }
}
