import 'dart:convert';

List<MultiInput> multiInputFromJson(String str) => List<MultiInput>.from(json.decode(str).map((x) => MultiInput.fromJson(x)));
String eppRegisterToJson(List<MultiInput> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MultiInput{
  MultiInput({
    this.inputCode,
    this.description,
    this.codePhoto,
  });

  int? inputCode;
  String? description;
  int? codePhoto;

  MultiInput.fromJson(Map<String, dynamic> json) {
    inputCode   =  json["inputCode"];
    description =  json["description"];
    codePhoto   =  json["codePhoto"];
  }

  Map<String, dynamic> toJson() => {
    "inputCode"  : inputCode,
    "description": description,
    "codePhoto"  : codePhoto,
  };
  
}