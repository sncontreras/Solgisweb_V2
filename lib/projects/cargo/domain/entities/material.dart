import 'package:equatable/equatable.dart';

class Material extends Equatable{
  const Material({
    this.cargaType,
    this.description,
  });

  final int? cargaType;
  final String? description;

  @override
  List<Object?> get props => [ cargaType, description ];

}
