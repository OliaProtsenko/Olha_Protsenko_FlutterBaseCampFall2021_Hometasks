import 'package:campnotes/auth/auth_repository.dart';
import 'package:campnotes/session/session_cubit.dart';
import 'package:campnotes/session/session_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:campnotes/localization.dart';
import 'package:campnotes/screens/screens.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    TodosApp(),
  );
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return RepositoryProvider(
            create: (context) => AuthRepository(FirebaseAuth.instance),
            child: BlocProvider(
                create: (context) =>
                    SessionCubit(authRepo: context.read<AuthRepository>()),
                child: SessionNavigator()),
          );
          // HomeScreen();
        },
        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(
            key: ArchSampleKeys.addTodoScreen,
            onSave: (task, note) {},
            isEditing: false,
          );
        },
      },
    );
  }
}
