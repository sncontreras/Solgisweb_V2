import 'package:equatable/equatable.dart';
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

class Field extends Equatable {
  final CarretaField? carreta;
  final CargaField? carga;
  final OriginField? origin;
  final GuiaField? guia;
  final ContainerField? container;
  final TContenedorField? tContenedor;
  final GTransportistaField? gTransportista;
  final PrecintoField? precinto;
  final BookingField? booking;
  final ContratoField? contrato;
  final OpLogisticoField? opLogistico;
  //campos nuevos para marcona
  final TipoMaterialField? tipoMaterial;
  final TipoVehiculoField? tipoVehiculo;
  final DestinoField? destino;
  final KilometrajeField? kilometraje;

  const Field({
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
    this.tipoMaterial,
    this.tipoVehiculo,
    this.destino,
    this.kilometraje,
  });

  @override
  List<Object?> get props => [
        // alcoholimetro,
        carreta,
        carga,
        tContenedor,
        origin,
        guia,
        container,
        contrato
      ];
}
