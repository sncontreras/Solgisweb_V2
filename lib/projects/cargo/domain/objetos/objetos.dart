import 'package:solgis/projects/cargo/domain/entities/carga_type.dart';
import 'package:solgis/projects/cargo/domain/entities/cargo.dart';
import 'package:solgis/projects/cargo/domain/entities/driver_response.dart';
import 'package:solgis/projects/cargo/domain/entities/enterprise.dart';
import 'package:solgis/projects/cargo/domain/entities/operator.dart';
import 'package:solgis/projects/cargo/domain/entities/option_radio.dart';
import 'package:solgis/projects/cargo/domain/entities/origin.dart';

const driverResponse = DriverResponse(

  cargo: Cargo(
    codigo: "001",
    cargo: "Jefe de Sistemas"
  ),
  enterprise: Enterprise(
    codigo: "001",
    enterprise: "Solmar Security SAC"
  ),
  fullname: "Cesar Salazar",
  pathImage: "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
  isAutorizated: true, 
  codTipoPer: 1,
  // accessAreas: [
  //   AccessArea(
  //     codigo: "001",
  //     area: "Sistemas"
  //   ),
  //   AccessArea(
  //     codigo: "002",
  //     area: "Administracion"
  //   ),
  //   AccessArea(
  //     codigo: "003",
  //     area: "Contabilidad"
  //   ),
  //   AccessArea(
  //     codigo: "004",
  //     area: "Operaciones"
  //   ),
  // ],

  // autorizantes: [
  //   Autorizante(
  //     codPersonal: "001",
  //     codigo: "002",
  //     dniPersonal: "12345678",
  //     nombrePersonal: "Gian Nanfaro"
  //   ),

  //   Autorizante(
  //     codPersonal: "002",
  //     codigo: "003",
  //     dniPersonal: "87654321",
  //     nombrePersonal: "Pamela Herrera Tank"
  //   ),

  //   Autorizante(
  //     codPersonal: "003",
  //     codigo: "004",
  //     dniPersonal: "11111111",
  //     nombrePersonal: "Fiorella"
  //   ),
  // ],

  // reasons: [

  //   Reason(
  //     codigo: "001",
  //     tipo: "Descargar container"
  //   ),

  //   Reason(
  //     codigo: "002",
  //     tipo: "Llenar agua"
  //   ),

  //   Reason(
  //     codigo: "003",
  //     tipo: "LLevar almuerzo"
  //   ),
  // ]


);

const driverResponse1 = DriverResponse(

  cargo: Cargo(
    codigo: "001",
    cargo: "Doctrina Operativa"
  ),
  enterprise: Enterprise(
    codigo: "001",
    enterprise: "Solmar Security SAC"
  ),
  fullname: "Melvin Huayanay ",
  pathImage: "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
  isAutorizated: true, 
  codTipoPer: 2,
  // accessAreas: [
  //   AccessArea(
  //     codigo: "001",
  //     area: "Sistemas"
  //   ),
  //   AccessArea(
  //     codigo: "002",
  //     area: "Administracion"
  //   ),
  //   AccessArea(
  //     codigo: "003",
  //     area: "Contabilidad"
  //   ),
  //   AccessArea(
  //     codigo: "004",
  //     area: "Operaciones"
  //   ),
  // ],

  // autorizantes: [
  //   Autorizante(
  //     codPersonal: "001",
  //     codigo: "002",
  //     dniPersonal: "12345678",
  //     nombrePersonal: "Gian Nanfaro"
  //   ),

  //   Autorizante(
  //     codPersonal: "002",
  //     codigo: "003",
  //     dniPersonal: "87654321",
  //     nombrePersonal: "Pamela Herrera Tank"
  //   ),

  //   Autorizante(
  //     codPersonal: "003",
  //     codigo: "004",
  //     dniPersonal: "11111111",
  //     nombrePersonal: "Fiorella"
  //   ),
  // ],

  // reasons: [

  //   Reason(
  //     codigo: "001",
  //     tipo: "Descargar container"
  //   ),

  //   Reason(
  //     codigo: "002",
  //     tipo: "Llenar agua"
  //   ),

  //   Reason(
  //     codigo: "003",
  //     tipo: "LLevar almuerzo"
  //   ),
  // ]
);

const driverResponse2= DriverResponse(
  codTipoPer: 1,

  cargo: Cargo(
    codigo: "001",
    cargo: "Soporte Tecnico "
  ),
  enterprise: Enterprise(
    codigo: "001",
    enterprise: "Solmar Security SAC"
  ),
  fullname: "Walter Escudero",
  pathImage: "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
  isAutorizated: true,
  // accessAreas: [
  //   AccessArea(
  //     codigo: "001",
  //     area: "Sistemas"
  //   ),
  //   AccessArea(
  //     codigo: "002",
  //     area: "Administracion"
  //   ),
  //   AccessArea(
  //     codigo: "003",
  //     area: "Contabilidad"
  //   ),
  //   AccessArea(
  //     codigo: "004",
  //     area: "Operaciones"
  //   ),
  // ],

  // autorizantes: [
  //   Autorizante(
  //     codPersonal: "001",
  //     codigo: "002",
  //     dniPersonal: "12345678",
  //     nombrePersonal: "Gian Nanfaro"
  //   ),

  //   Autorizante(
  //     codPersonal: "002",
  //     codigo: "003",
  //     dniPersonal: "87654321",
  //     nombrePersonal: "Pamela Herrera Tank"
  //   ),

  //   Autorizante(
  //     codPersonal: "003",
  //     codigo: "004",
  //     dniPersonal: "11111111",
  //     nombrePersonal: "Fiorella"
  //   ),
  // ],

  // reasons: [

  //   Reason(
  //     codigo: "001",
  //     tipo: "Descargar container"
  //   ),

  //   Reason(
  //     codigo: "002",
  //     tipo: "Llenar agua"
  //   ),

  //   Reason(
  //     codigo: "003",
  //     tipo: "LLevar almuerzo"
  //   ),
  // ]
);

const driverResponse3= DriverResponse(
  codTipoPer: 1,
  cargo: Cargo(
    codigo: "001",
    cargo: "Asistente de Sistemas"
  ),
  enterprise: Enterprise(
    codigo: "001",
    enterprise: "Solmar Security SAC"
  ),
  fullname: "Jean Chunga ",
  pathImage: "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
  isAutorizated: true,
  // accessAreas: [
  //   AccessArea(
  //     codigo: "001",
  //     area: "Sistemas"
  //   ),
  //   AccessArea(
  //     codigo: "002",
  //     area: "Administracion"
  //   ),
  //   AccessArea(
  //     codigo: "003",
  //     area: "Contabilidad"
  //   ),
  //   AccessArea(
  //     codigo: "004",
  //     area: "Operaciones"
  //   ),
  // ],

  // autorizantes: [
  //   Autorizante(
  //     codPersonal: "001",
  //     codigo: "002",
  //     dniPersonal: "12345678",
  //     nombrePersonal: "Gian Nanfaro"
  //   ),

  //   Autorizante(
  //     codPersonal: "002",
  //     codigo: "003",
  //     dniPersonal: "87654321",
  //     nombrePersonal: "Pamela Herrera Tank"
  //   ),

  //   Autorizante(
  //     codPersonal: "003",
  //     codigo: "004",
  //     dniPersonal: "11111111",
  //     nombrePersonal: "Fiorella"
  //   ),
  // ],

  // reasons: [

  //   Reason(
  //     codigo: "001",
  //     tipo: "Descargar container"
  //   ),

  //   Reason(
  //     codigo: "002",
  //     tipo: "Llenar agua"
  //   ),

  //   Reason(
  //     codigo: "003",
  //     tipo: "LLevar almuerzo"
  //   ),
  // ]
);

List<Origin> origins = const [

  Origin(
    originCode: "001",
    origin: "Chimbote"
  ),

  Origin(
    originCode: "002",
    origin: "Paita"
  ),

  Origin(
    originCode: "003",
    origin: "Callao"
  ),

];


List<Operator> operators = const [

  Operator(
    operatorCode: "001",
    name: "Juan Gabriel"
  ),

  Operator(
    operatorCode: "002",
    name: "Jose Jose "
  ),

  Operator(
    operatorCode: "003",
    name: "Luis Perales"
  ),

];

List<CargaType> cargastype = const [
  CargaType(
    codigo: "123",
    cargaType: "Liviano",
  ),
  CargaType(
    codigo: "345",
    cargaType: "Pesado",
  ),
  CargaType(
    codigo: "567",
    cargaType: "Aceite",
  ),
  CargaType(
    codigo: "890",
    cargaType: "Harina",
  ),
  CargaType(
    codigo: "445",
    cargaType: "Ligero",
  ),
];

List<OptionRadio> options = const [
  OptionRadio(
    codeOptionRadio: '001',
    tamanio: 12
  ),
  OptionRadio(
    codeOptionRadio: '001',
    tamanio: 30
  ),
  OptionRadio(
    codeOptionRadio: '001',
    tamanio: 40
  )
];