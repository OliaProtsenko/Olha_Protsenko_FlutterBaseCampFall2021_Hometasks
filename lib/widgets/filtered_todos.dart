import 'package:campnotes/helpers/mocks.dart';
import 'package:campnotes/screens/details_screen.dart';
import 'package:campnotes/widgets/tab_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:campnotes/widgets/widgets.dart';
import 'package:campnotes/data/models/todo.dart';

class FilteredTodos extends StatefulWidget {
  TabItem tab;

  FilteredTodos(this.tab, {Key key}) : super(key: key);

  @override
  _FilteredTodosState createState() => _FilteredTodosState();
}

class _FilteredTodosState extends State<FilteredTodos> {
  var selectedValue = '0';

  var isLargeScreen = false;

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    List<Todo> todos;
    switch (widget.tab) {
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
    return OrientationBuilder(builder: (context, orientation) {
      if (MediaQuery.of(context).size.width > 600) {
        isLargeScreen = true;
      } else {
        isLargeScreen = false;
      }
      return Row(children: <Widget>[
        Expanded(
          child: ListView.builder(
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
                  if (isLargeScreen || orientation == Orientation.landscape) {
                    selectedValue = index.toString();
                    setState(() {});
                  } else {
                    Navigator.of(context)
                        .pushNamed('/details', arguments: index.toString());
                  }
                },
                onCheckboxChanged: (_) {},
              );
            },
          ),
        ),
        (isLargeScreen || orientation == Orientation.landscape)
            ? const VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              )
            : Container(),
        (isLargeScreen || orientation == Orientation.landscape)
            ? Expanded(child: DetailsScreen(widget.tab, id: selectedValue))
            : Container(),
      ]);
    });
  }
}
