import 'package:equatable/equatable.dart';

class Epps extends Equatable{

  final String? codeEpps;
  final String? description;

  const Epps({
    this.codeEpps,
    this.description,
  });

  @override
  List<Object?> get props => [ codeEpps, description ];

}
