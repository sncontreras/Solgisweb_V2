import 'package:equatable/equatable.dart';

class CargaType extends Equatable {

  const CargaType({
    this.codigo,
    this.cargaType,
  });

  final String? codigo;
  final String? cargaType;

  @override
  List<Object?> get props => [ codigo, cargaType];

}
