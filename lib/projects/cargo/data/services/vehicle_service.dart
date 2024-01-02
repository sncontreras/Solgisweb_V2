import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/data/models/create_vehicle_body.dart';
import 'package:solgis/projects/cargo/data/models/create_vehicle_response.dart';
import 'package:solgis/projects/cargo/data/models/photo_document_model.dart';
import 'package:solgis/projects/cargo/data/models/validation_vehicule_response.dart';
import 'package:solgis/projects/cargo/data/models/vehicle_type_model.dart';

class VehicleService {

  Future<ValidationVehicleResponse?> validarPlaca( String placa, String codServicio, String codCliente) async {
    const String uncodePath = 'api/validation/vehicle/';

    final url = Uri.http( Environment.apiCargoUrl, uncodePath, {
      'Codigo': placa,
      'CodigoServicio': codServicio,
      'CodigoCliente': codCliente
    });

    final response = await http.get( url, headers: {
      'Content-Type': "application/json; charset=utf-8",
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final resp = ValidationVehicleResponse.fromJson(decodedData);
      return resp;
    }
    return null;
  }

  static Future<List<VehicleTypeModel>> getVehicleTypes(
      String? typeName, String codeCustomer) async {
    const String uncodePath = 'api/vehicle/types';

    final url = Uri.http(Environment.apiCargoUrl, uncodePath, {
      'TypeName': typeName,
      'CodeCustomer': codeCustomer,
    });

    final response = await http.get(url, headers: {
      'Content-Type': "application/json; charset=utf-8",
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final resp = VehicleTypesModel.fromJsonList(decodedData);
      return resp.items;
    } else {
      return [];
    }
  }

  static Future<CreateVehicleResponse?> createVehicle(
      CreateVehicleBody body) async {
    const String uncodePath = 'api/vehicle';
    final url = Uri.http(Environment.apiCargoUrl, uncodePath);

    final resp = await http.post(url,
        headers: {
          'Content-Type': "application/json; charset=utf-8",
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'placa_vehiculo_tracto': body.placaVehiculoTracto,
          'codigo_tipo_vehiculo': body.codigoTipoVehiculo,
          'codigo_tipo_carga': body.codigoTipoCarga,
          'tarjeta_propiedad': body.tarjetaPropiedad,
          'f_soat': body.fSoat?.toIso8601String(),
          'f_revision': body.fRevision?.toIso8601String(),
          'codigo_empresa': body.codigoEmpresa,
          'creado_por': body.creadoPor,
          'codigo_cliente_control': body.codigoClienteControl,
        }));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final createResponse = CreateVehicleResponse.fromJson(decodedData);
      return createResponse;
    } else {
      return null;
    }
  }

  Future<List<PhotosDocumentResponse?>?> getDocuments( String placa ) async {

    const String uncodePath = 'api/vehicle/photosDocument/';

    final url = Uri.http(
      Environment.apiCargoUrl,
      uncodePath, {
        'placa': placa,
      }
    );

    final response = await http.get(
      url, 
      headers: {
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      }
    );

    if (response.statusCode == 200) {
      final resp = photosDocumentResponseFromJson(response.body);
      return resp;
    }
    return null;
  }

}
