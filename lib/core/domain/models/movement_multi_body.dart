//import 'package:solgis/core/domain/models/epp_register_model.dart';
import 'package:solgis/core/domain/models/multi_input_model.dart';

class MovementMultiBody {
  MovementMultiBody({
    this.codCargo,
    this.codCliente,
    this.codServicio,
    this.creadoPor,
    this.multi
  });

  int? codCargo;
  String? codCliente;
  int? codServicio;
  String? creadoPor;
  List<MultiInput>? multi;

}
