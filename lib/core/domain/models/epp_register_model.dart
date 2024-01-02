import 'dart:convert';

List<EppRegister> eppRegisterFromJson(String str) => List<EppRegister>.from(json.decode(str).map((x) => EppRegister.fromJson(x)));

String eppRegisterToJson(List<EppRegister> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class EppRegister {
  EppRegister({
    this.codeEpp,
  });

  int? codeEpp;

  EppRegister.fromJson(Map<String, dynamic> json) {
    codeEpp =  json["codeEpp"];
  }

  Map<String, dynamic> toJson() => {
    "codeEpp": codeEpp,
  };
}
