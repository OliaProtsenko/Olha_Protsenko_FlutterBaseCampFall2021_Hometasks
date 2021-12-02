import 'package:campnotes/data/models/todo.dart';
import 'package:campnotes/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTodo extends Mock implements Todo {}

Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
         home: child,
    );
  }

void main() {
  MockTodo todo = MockTodo();
  testWidgets('AddEditScreen   has a hintText', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: AddEditScreen(
      onSave: (task, note) {},
      todo: todo,
      isEditing: false,
    )));
    final titleFinder = find.text("What needs to be done?");

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('AddEditScreen find two TextFormField by type',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: AddEditScreen(
      onSave: (task, note) {},
      todo: todo,
      isEditing: false,
    )));

    expect(find.byType(TextFormField), findsNWidgets(2));
  });
  testWidgets('AddEditScreen find add-icon by widget type',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: AddEditScreen(
      onSave: (task, note) {},
      todo: todo,
      isEditing: false,
    )));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
