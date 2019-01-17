import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_find_pro/viewcontrollers/addLife.dart';
import 'mylife.dart';
import 'mymoney.dart';

class YouAndMeVC extends StatefulWidget {
  @override
  YouAndMeVCState createState() {
    return new YouAndMeVCState();
  }
}

class YouAndMeVCState extends State<YouAndMeVC> {
  int _currentIndex = 0;

  var _pageController = PageController(
    initialPage: 0,
  );
  List<Widget> controllers = List();

  void _pageChange(int index) {
    setState(() {
      if (_currentIndex != index) {
        _currentIndex = index;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllers..add(MyLifeVC())..add(MyMoneyVC());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black,
          accentIconTheme: IconThemeData(
            color: Colors.black,
          ),
          accentTextTheme: TextTheme(title: TextStyle(color: Colors.black))),
      home: Scaffold(
        body: PageView.builder(
          // pageSnapping: true,
          onPageChanged: _pageChange,
          controller: _pageController,
          itemCount: 2,
          itemBuilder: (context, index) {
            return controllers[_currentIndex];
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: '记录你的生活',
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(
                builder: (context) {
                  return AddLifeVC();
                },
                fullscreenDialog: true));
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.toys),
                onPressed: () {
                  _pageController.jumpToPage(0);
                  _pageChange(0);
                },
              ),
              IconButton(
                icon: Icon(Icons.monetization_on),
                onPressed: () {
                  _pageController.jumpToPage(1);
                  _pageChange(1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
