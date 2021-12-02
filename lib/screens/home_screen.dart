import 'package:campnotes/bloc/models/app_tab.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:campnotes/widgets/widgets.dart';
import 'package:campnotes/localization.dart';

class HomeScreen extends StatelessWidget {
   final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.work: GlobalKey<NavigatorState>(),
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.leisure: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    final activeTab = AppTab.todos;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(FlutterBlocLocalizations.of(context).appTitle),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.work),
              ),
              Tab(
                icon: Icon(Icons.insert_emoticon),
              )
            ],
          ),
          actions: [
            FilterButton(visible: activeTab == AppTab.todos),
            ExtraActions(),
          ],
        ),
        body: activeTab == AppTab.todos
            ? TabBarView(children: [
                TabBarItem(TabItem.home, navigatorKeys[TabItem.home]),
                TabBarItem(TabItem.work, navigatorKeys[TabItem.work]),
                TabBarItem(TabItem.leisure, navigatorKeys[TabItem.leisure])
              ])
            : Stats(),
        floatingActionButton: FloatingActionButton(
          key: ArchSampleKeys.addTodoFab,
          onPressed: () {
            Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
          },
          child: Icon(Icons.add),
          tooltip: ArchSampleLocalizations.of(context).addTodo,
        ),
        bottomNavigationBar: TabSelector(
          activeTab: activeTab,
          onTabSelected: (tab) {},
        ),
      ),
    );
  }
}
