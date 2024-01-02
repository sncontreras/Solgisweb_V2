import 'package:equatable/equatable.dart';

class Reason extends Equatable {

  const Reason({
    this.codigo,
    this.tipo,

  });

  final String? codigo;
  final String? tipo;

  @override
  List<Object?> get props => [ codigo, tipo];

}

