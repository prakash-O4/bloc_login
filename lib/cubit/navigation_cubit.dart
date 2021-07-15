import 'package:bloc/bloc.dart';

enum NavigationState { LogIn, SignUp, HomePage, SignOut }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.SignUp);

  //log in state
  void showLogIn() => emit(NavigationState.LogIn);
  //sign up state
  void showSignUp() => emit(NavigationState.SignUp);

  //home page state
  void homePage() {
    emit(NavigationState.HomePage);
    print("home state emitted");
  }

  //signing out
  void signOut() => emit(NavigationState.SignOut);
}
