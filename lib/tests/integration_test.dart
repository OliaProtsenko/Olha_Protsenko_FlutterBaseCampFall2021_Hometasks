import 'package:campnotes/localization.dart';
import 'package:campnotes/screens/add_edit_screen.dart';
import 'package:campnotes/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todos_app_core/todos_app_core.dart';



Widget createAppForTestingHomeScreenAndAddEditScreen({Widget child}) {
  return MaterialApp(
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      title: FlutterBlocLocalizations().appTitle,

      routes: {ArchSampleRoutes.home: (context) {
        return child;
      },
        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(key: ArchSampleKeys.addTodoScreen,
            onSave: (task, note) {},
            isEditing: false,);
        }
      });
}


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
            (WidgetTester tester) async {
          await tester.pumpWidget(
              createAppForTestingHomeScreenAndAddEditScreen(
                  child: HomeScreen()));
          await tester.pumpAndSettle();
          // Verify that current page is HomeScreen
          expect(find.byIcon(Icons.add), findsOneWidget);
          expect(find.text("Flutter Todos"),findsOneWidget);
          // Finds the floating action button to tap on.
          final Finder fab = find.byIcon(Icons.add);

          // Emulate a tap on the floating action button.
          await tester.tap(fab);
          await tester.pumpAndSettle();
          //Verify that current page is AddEditScreen
          expect(find.text("Add Todo"), findsOneWidget);
        });
  });
}
