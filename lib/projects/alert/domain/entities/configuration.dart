import 'package:equatable/equatable.dart';

class Configuration extends Equatable {

  final int? codConfig;
  final int? codRelPolApp;
  final String? param;
  final int? value;
  final String? unid;
  final bool? enabled;

  const Configuration({
    this.codConfig,
    this.codRelPolApp,
    this.param, 
    this.value,
    this.unid,
    this.enabled
  });

  @override
  List<Object?> get props => [ codConfig, codRelPolApp, param, value, unid, enabled ];

}
