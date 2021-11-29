import 'package:campnotes/auth/form_submission_status.dart';

class LoginState {
  final String email;

  bool get isValidEmail => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  final String password;

  bool get isValidPassword => password.length > 6;
  final FormSubmissionStatus formStatus;

  LoginState(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  LoginState copyWith(
      {String username, String password, FormSubmissionStatus formStatus}) {
    return LoginState(
      email: username ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
