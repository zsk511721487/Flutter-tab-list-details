import 'package:flutter/material.dart';

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
        body: Column(
          children: <Widget>[
            InputActionTip(),
          ],
        ),
      ),
    );
  }
}

class InputActionTip extends StatelessWidget {
  String address;

  String people;

  String date;

  @override
  Widget build(BuildContext context) {
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
              height: 300.0,
              // color: Colors.orange,
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
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
                        address = val;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
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
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DatePickerView(),
                  ],
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
        onTap: (){
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

class _ChoseImagesState extends State<ChoseImages> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      
    );
  }
}