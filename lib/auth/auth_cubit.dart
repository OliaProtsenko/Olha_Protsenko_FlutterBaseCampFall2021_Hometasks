import 'package:campnotes/session/session_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum AuthState { login, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({this.sessionCubit}) : super(AuthState.login);



  void showLogin() => emit(AuthState.login);

  void showSignUp() => emit(AuthState.signUp);


  void launchSession(User authCredentials) =>
      sessionCubit.showSession(authCredentials);
}
