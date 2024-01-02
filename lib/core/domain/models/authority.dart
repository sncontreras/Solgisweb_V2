import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Authority extends Equatable {

  Authority({
    this.codigo,
    this.codPersonal,
    this.nombrePersonal,
    this.dniPersonal,
  });

  String? codigo;
  String? codPersonal;
  String? nombrePersonal;
  String? dniPersonal;

  @override
  List<Object?> get props => [ codigo, codPersonal, nombrePersonal, dniPersonal];

}
