import 'package:equatable/equatable.dart';

class Operator extends Equatable{
  const Operator({
    this.operatorCode,
    this.name,
  });

  final String? operatorCode;
  final String? name;

  @override
  List<Object?> get props => [ operatorCode, name ];

}
