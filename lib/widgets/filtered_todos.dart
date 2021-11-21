import 'package:campnotes/helpers/mocks.dart';
import 'package:campnotes/widgets/tab_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:campnotes/widgets/widgets.dart';
import 'package:campnotes/data/models/todo.dart';

class FilteredTodos extends StatelessWidget {
  TabItem tab;

  FilteredTodos(this.tab, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    List<Todo> todos;
    switch (tab) {
      case TabItem.home:
        todos = mockTodosHome;
        break;
      case TabItem.work:
        todos = mockTodosWork;
        break;
      case TabItem.leisure:
        todos = mockTodosLeisure;
        break;
    }
    return ListView.builder(
      key: ArchSampleKeys.todoList,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onDismissed: (direction) {
            ScaffoldMessenger.of(context).showSnackBar(DeleteTodoSnackBar(
              key: ArchSampleKeys.snackbar,
              todo: todo,
              onUndo: () {},
              localizations: localizations,
            ));
          },
          onTap: () async {
            Navigator.of(context)
                .pushNamed('/details', arguments: index.toString());
          },
          onCheckboxChanged: (_) {},
        );
      },
    );
  }
}
