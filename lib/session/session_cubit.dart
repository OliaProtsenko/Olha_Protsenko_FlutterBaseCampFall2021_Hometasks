import 'package:campnotes/auth/auth_repository.dart';
import 'package:campnotes/session/session_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  SessionCubit({this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final user = await authRepo.attemptAutoLogin();

      print(user);
      (user != null) ? emit(Authenticated(user: user)) : emit(
          Unauthenticated());
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void showAuth() => emit(Unauthenticated());

  void showSession(User userCredentials) {
    final user = userCredentials.displayName;
    emit(Authenticated(user: user));
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
