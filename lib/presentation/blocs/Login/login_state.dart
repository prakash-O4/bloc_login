part of 'login_bloc.dart';


class LoginState {
  final String email;
  final String password;
  final FormSubmissionStatus status;
  LoginState({
    this.email = "",
    this.password = "",
    this.status = const InitialFormStatus(),
  });

  LoginState copyWith(
      {String? email, String? password, FormSubmissionStatus? status}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  bool get isValidEmail {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidPassword {
    if (password.length < 6) {
      return false;
    } else {
      return true;
    }
  }
}

