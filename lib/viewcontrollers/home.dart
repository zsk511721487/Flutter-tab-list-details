import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../request/homeRequest.dart';
import 'sellDetailsVC.dart';
import 'dart:async';

// import 'dart:convert';

final titleStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

class HomeVC extends StatefulWidget {
  @override
  HomeVCState createState() {
    return new HomeVCState();
  }
}

class HomeVCState extends State<HomeVC> {
  List sellDetails;

  final StreamController<bool> _streamController = StreamController<bool>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getSellList((data) {
      sellDetails = data['data']['thisList'];
      _streamController.sink.add(true);
      // setState(() {

      //   print(sellDetails);
      // });
    });
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    var sellDetail = sellDetails[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => SellDetailsVC(
                    sellId: sellDetail['sell_id'],
                    sellImageUri:
                        'https://meckeeper-test.oss-cn-shanghai.aliyuncs.com/' +
                            '${sellDetail['car_icon']}',
                  ),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.white,
              // borderRadius: BorderRadius.circular(10.0),
              ),
          // color: Colors.white,
          height: 230.0,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Stack(children: <Widget>[
                  Container(
                      height: 230.0,
                      width: 500.0,
                      child: FadeInImage.assetNetwork(
                        image:
                            'https://meckeeper-test.oss-cn-shanghai.aliyuncs.com/' +
                                '${sellDetail['car_icon']}',
                        placeholder: 'images/fila.png',
                        fit: BoxFit.cover,
                      )
                      // Image.network(
                      //   'https://meckeeper-test.oss-cn-shanghai.aliyuncs.com/' +
                      //       '${sellDetail['car_icon']}',
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    height: 100.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 200.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  sellDetail['brand_name'] +
                                      sellDetail['cate_name'] +
                                      sellDetail['name'],
                                  style: titleStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  sellDetail['brand_name'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                          Text(sellDetail['price'] + '万',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0))
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: StreamBuilder(
              stream: _streamController.stream,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return snapshot.data == false
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ))
                    : ListView.builder(
                        itemCount: sellDetails.length,
                        itemBuilder: _listItemBuilder,
                      );
              },
            )));
  }
}

abstract class BlocBase {
  void dispose();
}

class SellBloc extends BlocBase {
  bool _counter;
  StreamController<bool> _counterController = StreamController<bool>();
  StreamSink<bool> get _inAdd => _counterController.sink;
  Stream<bool> get outCounter => _counterController.stream;

  StreamController _actionController = StreamController();
  StreamSink get getAllList => _actionController.sink;

  SellBloc() {
    _counter = false;
    _actionController.stream.listen(_getAllSell);
  }

  void dispose() {
    _counterController.close();
    _actionController.close();
  }

  void _getAllSell(data) {
    _counter = true;
    _inAdd.add(_counter);
  }
}
