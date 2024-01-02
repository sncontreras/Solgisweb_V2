import 'package:equatable/equatable.dart';

class AccessArea extends Equatable {

  const AccessArea({
    this.codigo,
    this.area,
  });

  final String? codigo;
  final String? area;

  @override
  List<Object?> get props => [ codigo, area];

}
