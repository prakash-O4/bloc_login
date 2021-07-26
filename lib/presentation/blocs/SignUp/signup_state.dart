part of 'signup_bloc.dart';

class SignupState {
  final String username;
  final String email;
  final String password;
  final String confPassword;
  final FormSubmissionStatus status;
  SignupState({
    this.username = "",
    this.confPassword = "",
    this.email = "",
    this.password = "",
    this.status = const InitialFormStatus(),
  });

  SignupState copyWith(
      {String? username,
      String? email,
      String? password,
      String? confPassword,
      FormSubmissionStatus? status}) {
    return SignupState(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        confPassword: confPassword ?? this.confPassword,
        status: status ?? this.status);
  }

  bool get isValidateUserName {
    if (username.length > 3) {
      return true;
    }
    return false;
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

  bool get matchPassword {
    if (password == confPassword) {
      return true;
    } else {
      return false;
    }
  }
}
