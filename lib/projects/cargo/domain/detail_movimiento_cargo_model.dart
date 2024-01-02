class DetailMovimientoCargoModel {
  String tipoVehiculo;
  String empresa;
  String nombres;
  String dni;
  String placa;
  String resultado;

  DetailMovimientoCargoModel({
    required this.tipoVehiculo,
    required this.empresa,
    required this.nombres,
    required this.dni,
    required this.placa,
    required this.resultado,
  });

  // Método para convertir un mapa (json) en una instancia de DetailMovimientoCargoModel
  factory DetailMovimientoCargoModel.fromJson(Map<String, dynamic> json) {
    return DetailMovimientoCargoModel(
      tipoVehiculo: json['tipo_vehiculo'],
      empresa: json['empresa'],
      nombres: json['conductor'],
      dni: json['dni'],
      placa: json['placa'],
      resultado: json['resultado'],
    );
  }

  // Método para convertir una instancia de DetailMovimientoCargoModel en un mapa (json)
  Map<String, dynamic> toJson() {
    return {
      'tipoVehiculo': tipoVehiculo,
      'empresa': empresa,
      'nombres': nombres,
      'dni': dni,
      'placa': placa,
      'resultado': resultado,
    };
  }
}
