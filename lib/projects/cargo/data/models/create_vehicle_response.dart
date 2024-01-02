class CreateVehicleResponse {
  CreateVehicleResponse({
    this.estado,
    this.codigoVehiculo,
  });

  int? estado;
  int? codigoVehiculo;

  CreateVehicleResponse.fromJson(Map<String, dynamic> json) {
      estado = json["estado"];
      codigoVehiculo = json["codigoVehiculo"];
  }

}
