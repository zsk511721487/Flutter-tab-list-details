import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/bloc_provider.dart';
import '../bloc/addLife_bloc.dart';
import '../model/addLifeModel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

class AddLifeVC extends StatefulWidget {
  @override
  _AddLifeVCState createState() => _AddLifeVCState();
}

class _AddLifeVCState extends State<AddLifeVC> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.flip_to_back,
              color: Colors.black,
            ),
          ),
          appBar: AppBar(
            title: Text('添加小时间哦',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
            backgroundColor: Colors.white,
          ),
          body: BlocProvider(
            bloc: AddLifeBloc(),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    InputActionTip(),
                    ChoseImages(),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class InputActionTip extends StatefulWidget {
  @override
  InputActionTipState createState() {
    return new InputActionTipState();
  }
}

class InputActionTipState extends State<InputActionTip> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddLifeBloc lifeBloc = BlocProvider.of<AddLifeBloc>(context);
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text('今天的你也是很开心哦^_^ :',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: 20.0,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12))),
              // height: 300.0,
              // color: Colors.orange,
              child: Form(
                key: _formKey,
                child: StreamBuilder(
                  initialData: AddLifeModel.defaultModel(),
                  stream: lifeBloc.addLifeStream,
                  builder: (context, snapshot) {
                    AddLifeModel model = snapshot.data;
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          initialValue: model.address,
                          decoration: InputDecoration(
                              labelText: '事件地址',
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.map),
                              // prefixText: '',
                              hintStyle: TextStyle(color: Colors.black26),
                              // counterText: 'sdsss',
                              // helperText: 'sssdddddddd',
                              hintText: '说明一下你的时间地址哦',
                              errorMaxLines: 20,
                              focusedBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                          validator: (val) {
                            return val.length < 2 ? "你这个地方有点问题哦" : null;
                          },
                          onSaved: (val) {
                            lifeBloc.actionSink.add(val);
                            // address = val;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          initialValue: model.persons,
                          decoration: InputDecoration(
                            labelText: '参与人员',
                            labelStyle: TextStyle(color: Colors.black),
                            // icon: Icon(Icons.people),
                            prefixIcon: Icon(Icons.person_add),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintStyle: TextStyle(color: Colors.black26),
                            // counterText: 'sdsss',
                            // helperText: 'sssdddddddd',
                            hintText: '添加一下您的同行人员吧。',
                          ),
                          onSaved: (val) {
                            lifeBloc.personsSink.add(val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        DatePickerView(),
                      ],
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class DatePickerView extends StatefulWidget {
  @override
  _DatePickerViewState createState() => _DatePickerViewState();
}

class _DatePickerViewState extends State<DatePickerView> {
  _showDataPocker() async {
    Locale myLocale = Localizations.localeOf(context);
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2020),
        locale: myLocale);
    setState(() {
      _timer = _formartDate(picker.year, picker.month, picker.day);
    });
  }

  String _formartDate(int year, int month, int day) {
    return '${year.toString()}年${month.toString()}月${day.toString()}日';
  }

  // _showTimePicker() async {
  //   var picker =
  //       await showTimePicker(context: context, initialTime: TimeOfDay.now());
  //   setState(() {
  //     _timer = picker.toString();
  //   });
  // }

  var _timer = '请选择您的出行时间';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      height: 65.0,
      child: GestureDetector(
        onTap: () {
          _showDataPocker();
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.access_time,
              color: Colors.black54,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              _timer,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoseImages extends StatefulWidget {
  @override
  _ChoseImagesState createState() => _ChoseImagesState();
}

class _ChoseImagesState extends State<ChoseImages> with LoadingDelegate {
  Future<File> _imageFile;
  Future<File> _secondimageFile;
  Future<File> _thireimageFile;
  Future<File> _fourthimageFile;

  Future _getImage(int index) async {
    var image = ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      switch (index) {
        case 0:
          _imageFile = image;
          break;
        case 1:
          _secondimageFile = image;
          break;
        case 2:
          _thireimageFile = image;
          break;
        case 3:
          _fourthimageFile = image;
          break;
        default:
      }
    });
  }

  // Future<File> imageFile;

  // Future _pickImage() async {
  //   var photoList = await PhotoPicker.pickAsset(
  //     context: context,
  //     themeColor: Colors.white,
  //     padding: 1.0,
  //     dividerColor: Colors.white,
  //     disableColor: Colors.black,
  //     itemRadio: 0.88,
  //     maxSelected: 1,
  //     provider: I18nProvider.chinese,
  //     rowCount: 3,
  //     textColor: Colors.black,
  //     thumbSize: 150,
  //     sortDelegate: SortDelegate.common,
  //     checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
  //         activeColor: Colors.black, unselectedColor: Colors.black),
  //     loadingDelegate: this,
  //     badgeDelegate: const DurationBadgeDelegate(),
  //   );

  //   if (photoList != null) {
  //     var file = photoList[0].file;
  //     imageFile = file;
  //   }

  //   setState(() {
  //     // print("imageListCount:${imageList.length}");
  //   });

  //   // _getImage(file);
  // }

  @override
  Widget buildBigImageLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    return Center(
      child: Container(
        width: 50.0,
        height: 50.0,
        child: CupertinoActivityIndicator(
          radius: 25.0,
        ),
      ),
    );
  }

  @override
  Widget buildPreviewLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    return Center(
      child: Container(
        width: 50.0,
        height: 50.0,
        child: CupertinoActivityIndicator(
          radius: 25.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orange,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('上传您的美图吧！'),
          SizedBox(
            height: 16.0,
          ),
          Container(
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: 16.0,
              runSpacing: 16.0,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.width - 48.0) / 2 + 40,
                  width: (MediaQuery.of(context).size.width - 48.0) / 2,
                  color: Colors.orange,
                  child: GestureDetector(
                    onTap: (){
                      _getImage(0);
                    },
                    child: Stack(
                      children: <Widget>[
                        FutureBuilder(
                          future: _imageFile,
                          // initialData: imageList,
                          builder: (context, snapshot) {
                            // File filestr = snapshot.data;
                            // print(filestr.absolute.path);
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              // File filestr = snapshot.data;
                              // print(filestr.absolute.path);
                              return ConstrainedBox(
                                child: Image.file(snapshot.data, fit: BoxFit.cover,gaplessPlayback:true),
                                constraints: BoxConstraints.expand(),
                              );
                            } else {
                              return ConstrainedBox(
                                child: Image.asset("images/fila.png",
                                    height: 70.0, width: 70.0),
                                constraints: BoxConstraints.expand(),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width - 48.0) / 2 + 40,
                  width: (MediaQuery.of(context).size.width - 48.0) / 2,
                  color: Colors.orange,
                  child: GestureDetector(
                    onTap: (){
                      _getImage(1);
                    },
                    child: Stack(
                      children: <Widget>[
                        FutureBuilder(
                          future: _secondimageFile,
                          builder: (context, snapshot) {
                            print('ssssssssssss');
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return ConstrainedBox(
                                child: Image.file(snapshot.data, fit: BoxFit.cover),
                                constraints: BoxConstraints.expand(),
                              );
                            } else {
                              return ConstrainedBox(
                                child: Image.asset("images/fila.png",
                                    height: 70.0, width: 70.0),
                                constraints: BoxConstraints.expand(),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width - 48.0) / 2 + 40,
                  width: (MediaQuery.of(context).size.width - 48.0) / 2,
                  color: Colors.orange,
                  child: GestureDetector(
                    onTap: (){
                      _getImage(2);
                    },
                    child: Stack(
                      children: <Widget>[
                        FutureBuilder(
                          future: _thireimageFile,
                          // initialData: imageList,
                          builder: (context, snapshot) {
                            // File filestr = snapshot.data;
                            // print(filestr.absolute.path);
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              // File filestr = snapshot.data;
                              // print(filestr.absolute.path);
                              return ConstrainedBox(
                                child: Image.file(snapshot.data, fit: BoxFit.cover,gaplessPlayback:true),
                                constraints: BoxConstraints.expand(),
                              );
                            } else {
                              return ConstrainedBox(
                                child: Image.asset("images/fila.png",
                                    height: 70.0, width: 70.0),
                                constraints: BoxConstraints.expand(),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width - 48.0) / 2 + 40,
                  width: (MediaQuery.of(context).size.width - 48.0) / 2,
                  color: Colors.orange,
                  child: GestureDetector(
                    onTap: (){
                      _getImage(3);
                    },
                    child: Stack(
                      children: <Widget>[
                        FutureBuilder(
                          future: _fourthimageFile,
                          // initialData: imageList,
                          builder: (context, snapshot) {
                            // File filestr = snapshot.data;
                            // print(filestr.absolute.path);
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              // File filestr = snapshot.data;
                              // print(filestr.absolute.path);
                              return ConstrainedBox(
                                child: Image.file(snapshot.data, fit: BoxFit.cover,gaplessPlayback:true),
                                constraints: BoxConstraints.expand(),
                              );
                            } else {
                              return ConstrainedBox(
                                child: Image.asset("images/fila.png",
                                    height: 70.0, width: 70.0),
                                constraints: BoxConstraints.expand(),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
