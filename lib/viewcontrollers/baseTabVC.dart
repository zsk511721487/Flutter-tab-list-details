import 'package:flutter/cupertino.dart';
import './home.dart';
import './mine.dart';

class BaseTabVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 25.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              title: Text('Mine'),
            ),
          ],
        ),
        
        tabBuilder: (context, index) {
          if (index == 0) {
            return HomeVC();
          } else {
            return MineVC();
          }
        });
  }
}
