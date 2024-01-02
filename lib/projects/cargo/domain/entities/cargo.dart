import 'package:equatable/equatable.dart';

class Cargo extends Equatable {

  const Cargo({
    this.codigo,
    this.cargo,
  });

  final String? codigo;
  final String? cargo;

  @override
  List<Object?> get props => [ codigo, cargo];

}
