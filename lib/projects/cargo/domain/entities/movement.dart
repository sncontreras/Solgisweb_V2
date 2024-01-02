import 'package:equatable/equatable.dart';

abstract class Movement extends Equatable {

  const Movement({
    this.codMovimiento,
    this.codigoVehicular,
    this.placa,
    this.tipoCarga,
    this.nombres,
    this.dni,
    this.cargo,
    this.empresa,
    this.fechaIngreso,
    this.fechaSalida,
  });

  final String?   codMovimiento;
  final String?   codigoVehicular;
  final String?   placa;
  final String?   tipoCarga;
  final String?   nombres;
  final String?   dni;
  final String?   cargo;
  final String?   empresa;
  final DateTime? fechaIngreso;
  final String?   fechaSalida;

  @override
  List<Object?> get props => [ codMovimiento, codigoVehicular, placa, tipoCarga, nombres, dni, cargo, empresa, fechaIngreso, fechaSalida ];

}