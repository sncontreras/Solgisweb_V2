class CreateCargoResponse {
  CreateCargoResponse({
    this.estado,
    this.codigo,
  });

  int? estado;
  int? codigo;

  CreateCargoResponse.fromJson(Map<String, dynamic> json) {
      estado = json["estado"];
      codigo = json["codigo"];
  }

}
