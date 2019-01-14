import 'pic.dart';

class SellDetails {
  String address;
  String price;
  List<Pic> pic;
  String brandName;
  String cateName;
  String name;
  String numStr;

  SellDetails(this.address, this.price, this.pic, this.brandName, this.cateName,
      this.name,this.numStr);

  factory SellDetails.fromJson(Map<String, dynamic> json) {
    List<Pic> picList = List<Pic>();
    for (var item in json['images']) {
      var picModel = Pic.fromJson(item);
      picList.add(picModel);
    }
    return SellDetails(json['address'], json['price'], picList,
        json['brand_name'], json['cate_name'], json['name'],json['num']);
  }
}
