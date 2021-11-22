import 'package:campnotes/auth/UserModel.dart';
import 'package:campnotes/auth/auth_cubit.dart';
import 'package:campnotes/auth/auth_repository.dart';
import 'package:campnotes/auth/login/login_event.dart';
import 'package:campnotes/auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({this.authRepo, this.authCubit}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final userId = await authRepo.login(
          username: state.username,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());
        final user = UserModel(
          username: state.username,
          userId: userId,
        );
        authCubit.launchSession(user);
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
