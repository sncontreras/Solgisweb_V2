import 'package:equatable/equatable.dart';
import 'package:solgis/projects/cargo/domain/entities/cargo.dart';
import 'package:solgis/projects/cargo/domain/entities/enterprise.dart';

class DriverResponse extends Equatable {

  const DriverResponse({

    this.fullname,
    this.cargo,
    this.enterprise,
    this.pathImage,
    this.isAutorizated,
    this.codTipoPer,
  });

  final String? fullname;
  final Cargo? cargo;
  final Enterprise? enterprise;
  final String? pathImage;
  final bool? isAutorizated;
  final int? codTipoPer;

  @override
  List<Object?> get props => [ fullname, cargo, enterprise, pathImage, isAutorizated];

}
