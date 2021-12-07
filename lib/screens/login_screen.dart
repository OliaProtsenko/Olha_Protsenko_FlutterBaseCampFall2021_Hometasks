import 'package:campnotes/auth/auth_cubit.dart';
import 'package:campnotes/auth/auth_repository.dart';
import 'package:campnotes/auth/form_submission_status.dart';
import 'package:campnotes/auth/login/login_bloc.dart';
import 'package:campnotes/auth/login/login_event.dart';
import 'package:campnotes/auth/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(
        authRepo: context.read<AuthRepository>(),
        authCubit: context.read<AuthCubit>(),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            _loginForm(textTheme),
            _showSignUpButton(context),
          ]),
        ),
      ),
    ));
  }

  Widget _loginForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _usernameField(textTheme),
          _passwordField(textTheme),
          _loginButton(),
        ]),
      ),
    );
  }

  Widget _usernameField(TextTheme textTheme) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          hintText: "Email",
          hintStyle: textTheme.bodyText1,
        ),
        validator: (value) =>
            state.isValidEmail ? null : 'Username is too short',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUsernameChanged(username: value)),
      );
    });
  }

  Widget _passwordField(TextTheme textTheme) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          hintText: "Password",
          hintStyle: textTheme.bodyText1,
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: Text('Login'),
            );
    });
  }

  Widget _showSignUpButton(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      child: Text('Don\'t have an account? Sign up.',
          style: theme.textTheme.bodyText2),
      onPressed: () => context.read<AuthCubit>().showSignUp(),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
