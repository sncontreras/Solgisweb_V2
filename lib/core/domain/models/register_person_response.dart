import 'dart:convert';

RegisterPersonResponse registerPersonResponseFromJson(String str) => RegisterPersonResponse.fromJson(json.decode(str));

String registerPersonResponseToJson(RegisterPersonResponse data) => json.encode(data.toJson());

class RegisterPersonResponse {
    RegisterPersonResponse({
        this.message,
        this.personalMaestro,
    });

    String? message;
    int? personalMaestro;

    RegisterPersonResponse.fromJson(Map<String, dynamic> json){
        message =  json["message"];
        personalMaestro =  json["personal_maestro"];
    }


    Map<String, dynamic> toJson() => {
        "message": message,
        "personal_maestro": personalMaestro,
    };
}
