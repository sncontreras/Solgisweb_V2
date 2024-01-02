// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class PhotosVehicleField extends Equatable {
  bool? delantera;
  bool? derecho;
  bool? trasera;
  bool? izquierdo;
  bool? cabina;
  bool? guantera;
  bool? carga;

  PhotosVehicleField({
    this.delantera, 
    this.derecho, 
    this.trasera,
    this.izquierdo, 
    this.cabina, 
    this.guantera,
    this.carga,
  });

  @override
  List<Object?> get props =>[delantera, derecho, trasera, izquierdo, cabina, guantera, carga];
}
