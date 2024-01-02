import 'package:solgis/core/domain/entities/document_type.dart';
import 'package:solgis/core/domain/entities/gender.dart';
import 'package:solgis/core/domain/entities/person_type.dart';
import 'package:solgis/projects/cargo/domain/entities/vehicle_type.dart';

final List<DocumentType> typesDocument = [

  DocumentType(
    codeDocumentType: 1,
    description: 'DNI'
  ),

  DocumentType(
    codeDocumentType: 2,
    description: 'Carnet de Extranjeria'
  ),

  DocumentType(
    codeDocumentType: 3,
    description: 'Pasaporte'
  ),

];

final List<Gender> genders = [

  Gender(
    genderCode: 1,
    gender: 'Masculino'
  ),

  Gender(
    genderCode: 2,
    gender: 'Femenino'
  ),

];

final List<PersonType> typesPerson = [

  PersonType(
    codePersonType: 1,
    personType: 'Propio'
  ),

  PersonType(
    codePersonType: 2,
    personType: 'Visitante'
  ),

  PersonType(
    codePersonType: 3,
    personType: 'Tercero'
  ),

  PersonType(
    codePersonType: 4,
    personType: 'Autoridad'
  ),

  PersonType(
    codePersonType: 5,
    personType: 'Cliente'
  ),

];

final List<VehicleType> vehicleTypes = [

  VehicleType(
    codeVehicleType: 1,
    vehicleType: 'Camioneta'
  ),

  VehicleType(
    codeVehicleType: 2,
    vehicleType: 'Furgoneta'
  ),

  VehicleType(
    codeVehicleType: 3,
    vehicleType: 'Trailer'
  ),

  VehicleType(
    codeVehicleType: 4,
    vehicleType: 'Camion'
  ),

  VehicleType(
    codeVehicleType: 5,
    vehicleType: 'Minivan'
  ),

];

final customers = {
  "yobel" : "22767",
  "saasa" : "25866",
  "hayduk": "00005",
  "centinela": "14517",
  "chec" : "30361",
  "crec 10" : "28463",
};