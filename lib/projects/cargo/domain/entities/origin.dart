import 'package:equatable/equatable.dart';

class Origin extends Equatable{
  const Origin({
    this.originCode,
    this.origin,
  });

  final String? originCode;
  final String? origin;

  @override
  List<Object?> get props => [ originCode, origin ];

}
