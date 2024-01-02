// ignore_for_file: must_be_immutable, overridden_fields

import 'dart:convert';

import 'package:solgis/projects/alert/domain/entities/configuration.dart';

List<ConfigurationModel> configurationModelFromJson(String str) => List<ConfigurationModel>.from(json.decode(str).map((x) => ConfigurationModel.fromJson(x)));

class ConfigurationModel extends Configuration{

  ConfigurationModel({
    this.codConfig,
    this.codRelPolApp,
    this.param,
    this.value,
    this.unid,
    this.enabled,
  });

  @override
  int? codConfig;
  @override
  int? codRelPolApp;
  @override
  String? param;
  @override
  int? value;
  @override
  String? unid;
  @override
  bool? enabled;

  ConfigurationModel.fromJson(Map<String, dynamic> json){
    codConfig    = json["codigo_config"];
    codRelPolApp = json["codigo_rel_politica_app"];
    param        = json["parametro"];
    value        = json["valor"];
    unid         = json["unidad"];
    enabled      = json["habilitado"];
  }

}