import 'dart:convert';

Image imageFromJson(String str) => Image.fromJson(json.decode(str));

String imageToJson(Image data) => json.encode(data.toJson());

class Image {
  Image({
    required this.idImage,
    required this.url,
    required this.type,
    required this.idEntity,
  });

  int idImage;
  String url;
  int type;
  int idEntity;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    idImage: json["idImage"],
    url: json["url"],
    type: json["type"],
    idEntity: json["idEntity"],
  );

  Map<String, dynamic> toJson() => {
    "idImage": idImage,
    "url": url,
    "type": type,
    "idEntity": idEntity,
  };
}