import 'package:campnotes/data/models/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.todo,
  }) : super(key: key ?? ArchSampleKeys.addTodoScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  String _task;
  String _note;

  bool get isEditing => widget.isEditing;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                onSaved: (String value) {
                  _task = value;
                },
                decoration: InputDecoration(
                    hintStyle: textTheme.headline5, // border: ,
                    hintText: "What needs to be done?"),
              ),
              TextFormField(
                onSaved: (String value) {
                  _note = value;
                },
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(bottom: 200.0),
                    hintStyle: textTheme.subtitle1, // border: ,
                    hintText: "Additional Notes..."),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            print("New task: " + _task);
            print("Annotations: " + _note);
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
