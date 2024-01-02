import 'package:equatable/equatable.dart';
import 'package:solgis/projects/patrol/domain/tipo_foto.dart';

class TipoFotosPatrol extends Equatable{

  const TipoFotosPatrol({
    this.tipoFoto
  });

  final List<TipoFoto>? tipoFoto;

  @override
  List<Object?> get props => [ tipoFoto ];

}
