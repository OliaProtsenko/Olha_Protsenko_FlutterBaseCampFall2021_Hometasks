import 'package:campnotes/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:campnotes/widgets/widgets.dart';


enum TabItem { home, work, leisure }

class TabBarItem extends StatefulWidget {
  final TabItem tab;

  final GlobalKey<NavigatorState> navigationKey;

  const TabBarItem(this.tab, this.navigationKey, {Key key}) : super(key: key);

  @override
  _TabBarItemState createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive {
    if (widget.tab == TabItem.leisure)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Navigator(
            key: widget.navigationKey,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              final String routeName = settings.name ?? '/';
              if (routeName == '/') {
                return MaterialPageRoute(builder: (_) {
                  return FilteredTodos(widget.tab);
                });
              }
              if (routeName == '/details') {
                final String todoIndex = settings.arguments;

                return MaterialPageRoute(
                  settings: settings,
                  builder: (_) {
                    return DetailsScreen(widget.tab, id: todoIndex);
                  },
                );
              }

            }));
  }
}
