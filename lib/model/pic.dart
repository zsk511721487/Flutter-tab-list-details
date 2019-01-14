
class Pic{
  String source;
  String status;
  String path;
  String ctime;

  Pic(this.source, this.status, this.path, this.ctime);
  factory Pic.fromJson(Map<String, dynamic> json){
    String imageUrl = 'https://meckeeper-test.oss-cn-shanghai.aliyuncs.com/'+json['path'];
    return Pic(json['source'],json['status'],imageUrl,json['ctime']);
  }
}
