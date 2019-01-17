import 'bloc_provider.dart';
import 'dart:async';
import '../model/addLifeModel.dart';

class AddLifeBloc extends BlocBase {
  AddLifeModel _addLifeModel = AddLifeModel.defaultModel();
  // String address;
  // String persons;
  // String date;
  // List<String> imageUriList;

//数据stream
  StreamController<AddLifeModel> _addLifeStreamController = StreamController<AddLifeModel>();
  StreamSink<AddLifeModel> get _addLifeSink => _addLifeStreamController.sink;
  Stream<AddLifeModel> get addLifeStream => _addLifeStreamController.stream;

  StreamController _actionStreamC = StreamController();
  StreamSink get actionSink => _actionStreamC.sink;

  StreamController _personsStreamC = StreamController();
  StreamSink get personsSink => _personsStreamC.sink;

  AddLifeBloc(){
    _addLifeModel = AddLifeModel.defaultModel();
    _actionStreamC.stream.listen(_addAddress);
    _personsStreamC.stream.listen(_addPersons);
  }

  void _addAddress(data){
    print(data);
    _addLifeModel.address = data;
    _addLifeSink.add(_addLifeModel);
  }

  void _addPersons(data){
    _addLifeModel.persons = data;
    _addLifeSink.add(_addLifeModel);
  }


  @override
  void dispose() {
    _addLifeStreamController.close();
    _actionStreamC.close();
    _personsStreamC.close();
    // TODO: implement dispose
  }
}
