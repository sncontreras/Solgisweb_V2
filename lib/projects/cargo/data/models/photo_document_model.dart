
import 'dart:convert';

List<PhotosDocumentResponse> photosDocumentResponseFromJson(String str) => List<PhotosDocumentResponse>.from(json.decode(str).map((x) => PhotosDocumentResponse.fromJson(x)));
String photosDocumentResponseToJson(List<PhotosDocumentResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotosDocumentResponse {
  int codigoTipoFotoVehiculo;
  String tipoVehiculo;
  int codigoFotoVehiculo;
  String pathImage;

  PhotosDocumentResponse({
    required this.codigoTipoFotoVehiculo,
    required this.tipoVehiculo,
    required this.codigoFotoVehiculo,
    required this.pathImage,
  });

  factory PhotosDocumentResponse.fromJson(Map<String, dynamic> json) => PhotosDocumentResponse(
    codigoTipoFotoVehiculo: json["codigo_tipo_fotoVehiculo"],
    tipoVehiculo: json["tipoVehiculo"],
    codigoFotoVehiculo: json["codigo_foto_vehiculo"],
    pathImage: json["pathImage"],
  );

  Map<String, dynamic> toJson() => {
    "codigo_tipo_fotoVehiculo": codigoTipoFotoVehiculo,
    "tipoVehiculo": tipoVehiculo,
    "codigo_foto_vehiculo": codigoFotoVehiculo,
    "pathImage": pathImage,
  };

}
