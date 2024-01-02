import 'package:equatable/equatable.dart';

class Enterprise extends Equatable {

  const Enterprise({
    this.codigo,
    this.enterprise,
  });

  final String? codigo;
  final String? enterprise;

  @override
  List<Object?> get props => [ codigo, enterprise];

}
