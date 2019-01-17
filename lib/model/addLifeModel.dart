class AddLifeModel {
  String address;
  String persons;
  String date;
  List<String> imageUriList;

  AddLifeModel(this.address, this.persons,this.date, this.imageUriList);

  factory AddLifeModel.fromJson(Map<String, dynamic> json) {
    return AddLifeModel(json['address'], json['persons'],json['date'], json['imageUriList']);
  }

  factory AddLifeModel.defaultModel(){
    return AddLifeModel('','','',null);
  }

  Map<String,dynamic> toJson(){
    return {
      'address':address,
      'persons':persons,
      'imageUriList': imageUriList
    };
  }
}
