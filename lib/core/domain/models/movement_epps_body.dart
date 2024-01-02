import 'package:solgis/core/domain/models/epp_register_model.dart';

class MovementEppsBody {
  MovementEppsBody({
    this.codCargo,
    this.codCliente,
    this.codServicio,
    this.creadoPor,
    this.codeEpps
  });

  int? codCargo;
  String? codCliente;
  int? codServicio;
  String? creadoPor;
  List<EppRegister>? codeEpps;
}
