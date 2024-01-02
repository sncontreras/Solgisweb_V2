// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/data/models/alcoholimetro_model.dart';
import 'package:solgis/projects/cargo/data/models/epps_model.dart';
import 'package:solgis/projects/cargo/data/models/photos_vehicle_model.dart';
import 'package:solgis/projects/cargo/domain/entities/configuration.dart';
import 'package:solgis/projects/cargo/domain/entities/configuration_type.dart';
import 'package:solgis/projects/cargo/domain/entities/epps.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/alcoholimetro_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/photos_vehicule_field.dart';

class ConfigurationModel extends Configuration{

  ConfigurationModel({
    // this.fields, 
    this.epps,
    this.alcoholimetro,
    this.photos,
    this.configuration,
  });

  // @override
  // Field? fields;

  @override
  List<Epps>? epps;

  @override
  AlcoholimetroField? alcoholimetro;

  @override
  PhotosVehicleField? photos;

  @override
  ConfigurationType? configuration;

  ConfigurationModel.fromJson(Map<String, dynamic> json){
    final epps = EppssModel.fromJsonList(json["epps"]);
    this.epps = epps.items;
    alcoholimetro = AlcoholimetroModel.fromJson(json["alcoholimetro"]);
    photos = PhotosVehicleModel.fromJson(json["photos"]);
    configuration = ConfigurationTypeModel.fromJson(json["configuration"]);
  }

}