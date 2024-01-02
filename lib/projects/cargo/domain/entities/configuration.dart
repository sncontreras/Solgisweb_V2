import 'package:equatable/equatable.dart';
import 'package:solgis/projects/cargo/domain/entities/configuration_type.dart';
import 'package:solgis/projects/cargo/domain/entities/epps.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/alcoholimetro_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/photos_vehicule_field.dart';

class Configuration extends Equatable{

  const Configuration({
    this.epps,
    this.alcoholimetro,
    this.photos, 
    this.configuration
  });

  final List<Epps>? epps;
  final AlcoholimetroField? alcoholimetro;
  final PhotosVehicleField? photos;
  final ConfigurationType? configuration;

  @override
  List<Object?> get props => [ epps, alcoholimetro, photos, configuration ];

}
