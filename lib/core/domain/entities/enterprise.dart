import 'package:equatable/equatable.dart';

class Enterprise extends Equatable{

  const Enterprise({
    this.codigo,
    this.empresa,
    this.ruc,
    this.cliente,

  });

  final int? codigo;
  final String? empresa;
  final String? ruc;
  final String? cliente;

  @override
  List<Object?> get props => [ codigo, empresa, ruc, cliente];

}

