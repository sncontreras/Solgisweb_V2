import 'package:equatable/equatable.dart';

class OptionRadio extends Equatable{

  final String? codeOptionRadio;
  final int? tamanio;

  const OptionRadio({
    this.codeOptionRadio,
    this.tamanio,
  });

  @override
  List<Object?> get props => [ codeOptionRadio, tamanio];

}
