// import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/sellDetails.dart';

getSellList(Function successCallBack) async {
  var url = 'https://testadmin.meckeeper.com/business/v7/sell';
  var httpClient = new HttpClient();
  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);

      successCallBack(data);
    } else {}
  } catch (exception) {
    print(exception);
  }
}

getSellDetails(
    String paramamters, Function successBlcok, Function errBlock) async {
  var url =
      'https://testadmin.meckeeper.com/business/v7/sell/detail?jsondata={"sell_id":' +
          paramamters +
          '}';
  http.get(url).then((response) {
    var json = jsonDecode(response.body);
    var sell = SellDetails.fromJson(json['data']);
    print(sell.address);
    successBlcok(sell);
  }).catchError((error) {
    print(error);
    errBlock(error);
  });
}
