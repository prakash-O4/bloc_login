import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logss/presentation/blocs/cubit/navigation_cubit.dart';
import 'package:logss/presentation/blocs/cubit/session_cubit.dart';
import 'package:logss/data/repositary/auth_repo.dart';
import 'package:meta/meta.dart';

import '../../../FormSubmissionStatus.dart';



part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // final FakeRepo _fakeRepo = FakeRepo();
  final AuthRepo _authRepo = AuthRepo();
  final SessionCubit sessionCubit;
  final NavigationCubit navigationCubit;
  LoginBloc({required this.navigationCubit, required this.sessionCubit})
      : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    //email updated
    if (event is LogInEmailChanged) {
      yield state.copyWith(email: event.email);
    }
    //password updated
    else if (event is LogInPasswordChanged) {
      yield state.copyWith(password: event.password);
    }
    //when button clicked
    else if (event is LogInSubmitted) {
      //loading state
      yield state.copyWith(status: FormSubmitting());
      try {
        //success state
        await _authRepo.logIn(
            email: state.email.trim(), password: state.password.trim());
        yield state.copyWith(status: SubmissionSuccess());
        _authRepo.setUserName();
        sessionCubit.showAuth();
      } catch (e) {
        //failed state
        yield state.copyWith(status: SubmissionFailed(exception: e.toString()));
      }
    }
  }
}
