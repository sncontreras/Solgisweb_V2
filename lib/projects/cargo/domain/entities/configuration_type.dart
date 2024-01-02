// ignore_for_file: must_be_immutable, overridden_fields

import 'package:equatable/equatable.dart';
import 'package:solgis/projects/cargo/data/models/field_model.dart';
import 'package:solgis/projects/cargo/domain/entities/field.dart';

class ConfigurationType extends Equatable {

  int? codeConfig;
  ExtraConfiguration? configExtra;

  ConfigurationType({
    this.codeConfig, 
    this.configExtra, 
  });

  @override
  List<Object?> get props =>[codeConfig, configExtra];

}

class ConfigurationTypeModel extends ConfigurationType{

  ConfigurationTypeModel({
    this.codeConfig, 
    this.configExtra,
  });

  @override 
  int? codeConfig;

  @override
  ExtraConfiguration? configExtra;

  ConfigurationTypeModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      codeConfig = json["code_conf"];
      configExtra = ExtraConfigurationModel.fromJson(json["config_extra"]) ;
    }
  }
}

class ExtraConfiguration extends Equatable {

  Field? fieldsEntry;
  Field? fieldsOut;

  ExtraConfiguration({
    this.fieldsEntry, 
    this.fieldsOut, 
  });

  @override
  List<Object?> get props =>[fieldsEntry, fieldsOut];

}


class ExtraConfigurationModel extends ExtraConfiguration{

  ExtraConfigurationModel({
    this.fieldsEntry, 
    this.fieldsOut,
  });

  @override 
  Field? fieldsEntry;

  @override
  Field? fieldsOut;

  ExtraConfigurationModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      fieldsEntry =  FieldModel.fromJson(json["fields_entry"]);
      fieldsOut   =  FieldModel.fromJson(json["fields_out"]);
    }
  }
}
