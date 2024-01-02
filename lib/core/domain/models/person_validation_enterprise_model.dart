
class PersonValidationsEnterpriseModel{
  List<PersonValidationEnterpriseModel> items = [];
  PersonValidationsEnterpriseModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final cargo = PersonValidationEnterpriseModel.fromJson(item);
      items.add(cargo);
    }
  }
}

class PersonValidationEnterpriseModel{
  PersonValidationEnterpriseModel({
    this.codEmpresa,
    this.abreviatura,
    this.nroDoc,
    this.ruc,
  });

  int? codEmpresa;
  String? abreviatura;
  String? nroDoc;
  String? ruc;
  int? codControl;

  PersonValidationEnterpriseModel.fromJson(Map<String, dynamic> json) {
    codEmpresa  = json["cod_empresa"];
    abreviatura = json["abreviatura"];
    nroDoc      = json["nro_doc"];
    ruc         = json["ruc"];
    codControl  = json["cod_control"];
  }

}
