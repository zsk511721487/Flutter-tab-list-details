import 'package:flutter/cupertino.dart';
import 'package:job_find_pro/viewcontrollers/youAndMe.dart';

class MineVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => YouAndMeVC()));
          },
          child: Text('MineVC'),
        ),
      ),
    );
  }
}
