class RegisterPersonModel {
  RegisterPersonModel({
      required this.codigoPersonal,
      required this.codigoTipoPersonal,
      required this.codigoEmpresa,
      required this.codigoTipoDocumento,
      required this.codigoCargo,
      required this.nombre1,
      required this.nombre2,
      required this.apellido1,
      required this.apellido2,
      required this.docPersonal,
      required this.sexo,
      required this.creadoPor,
      required this.nroLicense,
      required this.esAutorizante,
      required this.habilitado,
      required this.tieneFoto,
      required this.codigoClienteControl,
  });

  int codigoPersonal;
  int codigoTipoPersonal;
  int codigoEmpresa;
  int codigoTipoDocumento;
  int codigoCargo;
  String nombre1;
  String nombre2;
  String apellido1;
  String apellido2;
  String docPersonal;
  String sexo;
  String creadoPor;
  String nroLicense;

  String esAutorizante;
  bool habilitado;
  bool tieneFoto;
  int codigoClienteControl;
}
