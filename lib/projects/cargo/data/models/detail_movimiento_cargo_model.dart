class DetailMovimientoCargoModel {
  String? tipoVehiculo;
  String? tipoCarga;
  String? ingresoVehicular;
  String? imagen;

  DetailMovimientoCargoModel({
    this.tipoVehiculo,
    this.tipoCarga,
    this.ingresoVehicular,
    this.imagen
  });

  // Método para convertir un mapa (json) en una instancia de DetailMovimientoCargoModel
  factory DetailMovimientoCargoModel.fromJson(Map<String, dynamic> json) {
    return DetailMovimientoCargoModel(
      tipoVehiculo: json['tipo_vehiculo'],
      tipoCarga: json['tipo_carga'],
      ingresoVehicular: json['ingreso_vehicular'],
      imagen: json['imagen'],
    );
  }

  // Método para convertir una instancia de DetailMovimientoCargoModel en un mapa (json)
  Map<String, dynamic> toJson() {
    return {
      'tipo_vehiculo': tipoVehiculo,
      'tipo_carga': tipoCarga,
      'ingreso_vehicular': ingresoVehicular,
      'imagen': imagen,
    };
  }
}
