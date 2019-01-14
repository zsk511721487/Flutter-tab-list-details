import 'dart:async';
import './bloc_provider.dart';
import '../model/sellDetails.dart';
import '../request/homeRequest.dart';

class SellDetailsBloc extends BlocBase {
  SellDetails _sellDetail;
  String sellId;
  
  StreamController<SellDetails> _dataStream = StreamController<SellDetails>.broadcast();
  StreamSink<SellDetails> get _dataSink => _dataStream.sink;
  Stream<SellDetails> get outStream => _dataStream.stream;

  StreamController _actionController = StreamController();
  StreamSink get actionSink => _actionController.sink;


  SellDetailsBloc(this.sellId){
    _sellDetail = null;
    _actionController.stream.listen(_getSellDetails);
  }

  _getSellDetails(data){
    getSellDetails(sellId, (data){
      _sellDetail = data;
      _dataSink.add(data);
    }, (error){
      print(error);
    });
  }

  @override
  void dispose() {
      _actionController.close();
      _dataStream.close();
    }
}