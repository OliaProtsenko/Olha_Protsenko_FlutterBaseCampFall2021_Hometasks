import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:campnotes/widgets/widgets.dart';
import 'package:campnotes/data/models/todo.dart';
import 'package:campnotes/helpers/mocks.dart';

class DetailsScreen extends StatefulWidget {
  final TabItem tab;
  final String id;
  List<Todo> todos;

  DetailsScreen(this.tab, {Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.todoDetailsScreen) {
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
  }

  @override
  State<StatefulWidget> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
      child: Column(children: <Widget>[
        Container(
            height: 100,
            child: Text(widget.todos[int.parse(widget.id)].task,
                style: textTheme.headline5)),
        Divider(),
        Container(
            height: 200,
            child: Text(
              widget.todos[int.parse(widget.id)].note,
              style: textTheme.subtitle1,
            )),
        Divider(),
      ]),
    );
  }
}
