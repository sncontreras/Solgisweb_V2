import 'dart:convert';

String consultaModelToJson(List<PersonValidationTimeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonValidationTimeModel {
  
    PersonValidationTimeModel({
        required this.resultado,
        this.nombres,
        this.puesto,

    });

    bool resultado;
    String? nombres;
    String? puesto;


    factory PersonValidationTimeModel.fromJson(Map<String, dynamic> json) => PersonValidationTimeModel(
        resultado: json["Resultado"],
        nombres: json["nombres"],
        puesto: json["puesto"],
    );

    Map<String, dynamic> toJson() => {
        "Resultado": resultado,
        "nombres": nombres,
        "empresa": puesto,
    };

}




