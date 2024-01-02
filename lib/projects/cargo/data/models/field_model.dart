// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/data/models/booking_model.dart';
import 'package:solgis/projects/cargo/data/models/carga_model.dart';
import 'package:solgis/projects/cargo/data/models/carreta_model.dart';
import 'package:solgis/projects/cargo/data/models/container_model.dart';
import 'package:solgis/projects/cargo/data/models/contrato_model.dart';
import 'package:solgis/projects/cargo/data/models/destino_model.dart';
import 'package:solgis/projects/cargo/data/models/gtransportista_model.dart';
import 'package:solgis/projects/cargo/data/models/guia_model.dart';
import 'package:solgis/projects/cargo/data/models/kilometraje_model.dart';
import 'package:solgis/projects/cargo/data/models/op_logistico_model.dart';
import 'package:solgis/projects/cargo/data/models/origin_model.dart';
import 'package:solgis/projects/cargo/data/models/precinto_model.dart';
import 'package:solgis/projects/cargo/data/models/tcontenedor_model.dart';
import 'package:solgis/projects/cargo/data/models/tipo_material_model.dart';
import 'package:solgis/projects/cargo/data/models/tipo_vehiculo_model.dart';
import 'package:solgis/projects/cargo/domain/entities/field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/booking_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/carga_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/carreta_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/container_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/contrato_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/destino_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/g_transportista_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/guia_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/kilometraje_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/op_logistico_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/origin_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/precinto_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/tamanio_contenedor_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/tipo_material_field.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/tipo_vehiculo_field.dart';

class FieldModel extends Field {
  FieldModel({
    this.carreta,
    this.carga,
    this.origin,
    this.guia,
    this.container,
    this.tContenedor,
    this.gTransportista,
    this.precinto,
    this.booking,
    this.contrato,
    this.opLogistico,
    //config para MARCONA
    this.tipoMaterial,
    this.tipoVehiculo,
    this.destino,
    this.kilometraje,
  });

  @override
  CarretaField? carreta;

  @override
  CargaField? carga;

  @override
  OriginField? origin;

  @override
  GuiaField? guia;

  @override
  ContainerField? container;

  @override
  TContenedorField? tContenedor;

  @override
  GTransportistaField? gTransportista;

  @override
  PrecintoField? precinto;

  @override
  BookingField? booking;

  @override
  ContratoField? contrato;

  @override
  OpLogisticoField? opLogistico;

  @override
  TipoMaterialField? tipoMaterial;

  @override
  TipoVehiculoField? tipoVehiculo;

  @override
  DestinoField? destino;

  @override
  KilometrajeField? kilometraje;

  FieldModel.fromJson(Map<String, dynamic> json) {
    carreta = CarretaModel.fromJson(json["carreta"]);
    carga = CargaModel.fromJson(json["carga"]);
    origin = OriginModel.fromJson(json["origen"]);
    origin = OriginModel.fromJson(json["origen"]);
    guia = GuiaModel.fromJson(json["guia"]);
    container = ContainerModel.fromJson(json["contenedor"]);
    tContenedor = TContenedorModel.fromJson(json["tcontenedor"]);
    gTransportista = GTranspModel.fromJson(json["guiaTransp"]);
    precinto = PrecintoModel.fromJson(json["precinto"]);
    booking = BookingModel.fromJson(json["booking"]);
    contrato = ContratoModel.fromJson(json["contrato"]);
    opLogistico = OpLogModel.fromJson(json["opLogistico"]);
    tipoMaterial = TipoMaterialModel.fromJson(json["tipoMaterial"]);
    tipoVehiculo = TipoVehiculoModel.fromJson(json["tipoVehiculo"]);
    destino = DestinoModel.fromJson(json["destino"]);
    kilometraje = KilometrajeModel.fromJson(json["kilometraje"]);
  }
}
