import 'dart:convert';
/// userId : 1
/// id : 1
/// title : "Sample title 1"
/// body : "Sample body content for item 1"
/// coordinates : [-5.819962,-50.619234]
/// imageUrl : "https://loremflickr.com/320/240"

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      int? userId, 
      int? id, 
      String? title, 
      String? body, 
      List<double>? coordinates, 
      String? imageUrl,}){
    _userId = userId;
    _id = id;
    _title = title;
    _body = body;
    _coordinates = coordinates;
    _imageUrl = imageUrl;
}

  Product.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    _imageUrl = json['imageUrl'];
  }
  int? _userId;
  int? _id;
  String? _title;
  String? _body;
  List<double>? _coordinates;
  String? _imageUrl;
Product copyWith({  int? userId,
  int? id,
  String? title,
  String? body,
  List<double>? coordinates,
  String? imageUrl,
}) => Product(  userId: userId ?? _userId,
  id: id ?? _id,
  title: title ?? _title,
  body: body ?? _body,
  coordinates: coordinates ?? _coordinates,
  imageUrl: imageUrl ?? _imageUrl,
);
  int? get userId => _userId;
  int? get id => _id;
  String? get title => _title;
  String? get body => _body;
  List<double>? get coordinates => _coordinates;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    map['coordinates'] = _coordinates;
    map['imageUrl'] = _imageUrl;
    return map;
  }

}