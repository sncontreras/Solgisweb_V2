class InputsModel{
  List<InputModel> items = [];
  InputsModel.fromJsonList(List<dynamic> jsonList){
    for ( var item in jsonList ){
      final cargo = InputModel.fromJson(item);
      items.add(cargo);
    }
  }
}

class InputModel{

  InputModel({
    this.codigoCampoForm,
    this.etiqueta,
    this.hasFoto,
  });

  int? codigoCampoForm;
  String? etiqueta;
  bool? hasFoto;

  InputModel.fromJson(Map<String, dynamic> json){
    codigoCampoForm = json["codigo_campo_form"];
    etiqueta = json["etiqueta"];
    hasFoto = json["has_Foto"];
  }

}