import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:job_find_pro/view/CustomShapeClipper.dart';
import 'dart:ui';
import '../model/sellDetails.dart';
import '../model/pic.dart';
import 'dart:async';
import '../bloc/sellDetailsBloc.dart';
import '../bloc/bloc_provider.dart';

class SellDetailsVC extends StatelessWidget {
  final String sellId;
  final String sellImageUri;
  SellDetailsVC({this.sellId, this.sellImageUri});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          // appBar: CupertinoNavigationBar(
          //   backgroundColor: Colors.white,
          //   middle: Text(sellId),
          //   border: null,
          //   leading: CupertinoButton(
          //       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       child: Icon(
          //         Icons.arrow_back,
          //         color: Colors.black,
          //       )),
          // ),
          bottomNavigationBar: _BottomButtonView(),
          body: BlocProvider(
            bloc: SellDetailsBloc(sellId),
            child: NestedScrollView(
              body: _BodyView(
                sellId: sellId,
                sellImageUri: sellImageUri,
              ),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    title: Text('详情',style: TextStyle(color: Colors.black),),
                    centerTitle: true,
                    expandedHeight: 250.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SellTopView(
                        sellId: sellId,
                        sellImageUri: sellImageUri,
                      ),
                    ),
                  )
                ];
              },
            ),
          )),
    );
  }
}

class _BodyView extends StatelessWidget {
  final String sellId;
  final String sellImageUri;
  _BodyView({this.sellId, this.sellImageUri});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DetailsView(),
          DetailsView(),
          DetailsView(),
          DetailsView(),
          DetailsView(),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}

class SellTopView extends StatefulWidget {
  final String sellId;
  final String sellImageUri;
  SellTopView({this.sellId, this.sellImageUri});
  @override
  _SellTopViewState createState() => _SellTopViewState();
}

class _SellTopViewState extends State<SellTopView> {
  Widget _itemBuilder(BuildContext context, int index, String imageUrl) {
    return ImagePageItem(
      sellImageUri: imageUrl,
    );
  }


  SellDetails details;

  @override
  void dispose() {
    super.dispose();
  }

  void _getSellDetails(SellDetailsBloc bloc) {
    bloc.actionSink.add(null);
  }

  Widget sellNumber(SellDetails sell) {
    return Positioned(
        left: 16.0,
        bottom: 20.0,
        child: Text(
          sell.numStr,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(0, 3.0),
                    blurRadius: 8.0)
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    SellDetailsBloc sellBloc = BlocProvider.of<SellDetailsBloc>(context);
    _getSellDetails(sellBloc);
    return StreamBuilder(
      stream: sellBloc.outStream,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ));
        } else {
          return Stack(
            children: <Widget>[
              PageView.builder(
                pageSnapping: true,
                physics: ClampingScrollPhysics(),
                // reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.pic.length,
                itemBuilder: (context, index) {
                  Pic sellPic = snapshot.data.pic[index];
                  return _itemBuilder(context, index, sellPic.path);
                  // return _itemBuilder(context,index);
                },
              ),
              sellNumber(snapshot.data)
            ],
          );
        }
      },
    );
  }
}

final TextStyle detialsStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 14.0,
);

class ImagePageItem extends StatelessWidget {
  final String sellImageUri;
  ImagePageItem({this.sellImageUri});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ClipPath(
            // clipper: CustomShapeClipper(),
            child: Container(
              width: window.physicalSize.width,
              height: 300.0,
              child: FadeInImage.assetNetwork(
                image: sellImageUri,
                placeholder: 'images/fila.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SellDetailsBloc bloc = BlocProvider.of<SellDetailsBloc>(context);
    return StreamBuilder<Object>(
        stream: bloc.outStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ));
            ;
          } else {
            SellDetails details = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '品牌：' + details.brandName,
                  style: detialsStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('型号：' + details.name, style: detialsStyle),
                SizedBox(
                  height: 20.0,
                ),
                Text('类型：' + details.cateName, style: detialsStyle)
              ],
            );
          }
        });
  }
}

class _BottomButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey))),
      height: MediaQuery.of(context).padding.bottom + 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  right: BorderSide(color: Colors.grey, width: 0.5),
                )),
                child: Center(
                    child: Text(
                  '收藏',
                  textAlign: TextAlign.center,
                ))),
            flex: 1,
          ),
          Expanded(
            child: Container(
                child: Center(
                    child: Text(
              '联系我',
              textAlign: TextAlign.center,
            ))),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
