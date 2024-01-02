import 'package:equatable/equatable.dart';

class TipoFoto extends Equatable{

  final String? codeTipoFoto;
  final String? name;

  const TipoFoto({
    this.codeTipoFoto,
    this.name,
  });

  @override
  List<Object?> get props => [ codeTipoFoto, name ];

}
