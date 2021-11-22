import 'package:campnotes/bloc/models/extra_action.dart';
import 'package:campnotes/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:campnotes/flutter_todos_keys.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key}) : super(key: ArchSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      key: FlutterTodosKeys.extraActionsPopupMenuButton,
      onSelected: (action) {
        switch (action) {
          case ExtraAction.clearCompleted:
            break;
          case ExtraAction.signOut:
            BlocProvider.of<SessionCubit>(context).signOut();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          key: ArchSampleKeys.clearCompleted,
          value: ExtraAction.clearCompleted,
          child: Text(
            ArchSampleLocalizations.of(context).clearCompleted,
          ),
        ),
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.signOut,
          child: Text("Log out"),
        ),
      ],
    );
  }
}
