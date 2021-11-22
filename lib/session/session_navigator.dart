import 'package:campnotes/auth/auth_cubit.dart';
import 'package:campnotes/auth/auth_navigator.dart';
import 'package:campnotes/screens/home_screen.dart';
import 'package:campnotes/session/loading_view.dart';
import 'package:campnotes/session/session_cubit.dart';

import 'package:campnotes/session/session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: AuthNavigator(),
              ),
            ),

          // Show session flow
          if (state is Authenticated) MaterialPage(child: HomeScreen())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
