import 'dart:convert';

PersonBasicInformationReponse personUnAutorizedReponseFromJson(String str) => PersonBasicInformationReponse.fromJson(json.decode(str));

class PersonBasicInformationReponse {
  PersonBasicInformationReponse({
    this.name,
    this.cargo,
    this.enterprise,
    this.img
  });

  String? name;
  String? cargo;
  String? enterprise;
  String? img;
  String? message;

  PersonBasicInformationReponse.fromJson(Map<String, dynamic> json) {
    name= json["name"];
    cargo= json["cargo"];
    enterprise= json["enterprise"];
  }

}
