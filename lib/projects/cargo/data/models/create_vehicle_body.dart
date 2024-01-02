class CreateVehicleBody {
  CreateVehicleBody({
    this.placaVehiculoTracto,
    this.codigoTipoVehiculo,
    this.codigoTipoCarga,
    this.tarjetaPropiedad,
    this.fSoat,
    this.fRevision,
    this.codigoEmpresa,
    this.creadoPor,
    this.codigoClienteControl,
  });

  String? placaVehiculoTracto;
  int? codigoTipoVehiculo;
  int? codigoTipoCarga;
  String? tarjetaPropiedad;
  DateTime? fSoat;
  DateTime? fRevision;
  int? codigoEmpresa;
  String? creadoPor;
  String? codigoClienteControl;
}
