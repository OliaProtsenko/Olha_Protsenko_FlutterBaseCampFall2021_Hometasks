import 'package:campnotes/screens/sign_up_screen.dart';
import 'package:campnotes/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';



class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show login
          if (state == AuthState.login) MaterialPage(child: LoginScreen()),

          // Allow push animation
          if (state == AuthState.signUp) ...[
            // Show Sign up
            MaterialPage(child: SignUpScreen()),

            // Show confirm sign up

          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}

