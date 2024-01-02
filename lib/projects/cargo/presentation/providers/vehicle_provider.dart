import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/data/models/photo_document_model.dart';
import 'package:solgis/projects/cargo/data/models/validation_vehicule_response.dart';
import 'package:solgis/projects/cargo/data/services/driver_service.dart';

class VehicleProvider extends ChangeNotifier{

  ValidationVehicleResponse? _vehicleResponse;
  List<PhotosDocumentResponse>? _photosDocumentResponse;

  bool _iswithin = true;

  String _documentDriverwithin = '';

  ValidationVehicleResponse? get vehicleResponse => _vehicleResponse;

  set vehicleResponse( ValidationVehicleResponse? vehicle ){
    _vehicleResponse = vehicle;
    notifyListeners();
  }

  List<PhotosDocumentResponse>? get photosDocuments => _photosDocumentResponse;

  set photosDocuments( List<PhotosDocumentResponse>? photosDocuments ){
    _photosDocumentResponse = photosDocuments;
    notifyListeners();
  }


  bool get iswithin => _iswithin;

  set iswithin( bool value ){
    _iswithin= value;
    notifyListeners();
  }

  String get documentDriverwithin => _documentDriverwithin;

  verifyDriver(int codServicio, String codCliente) async {
    final driverDocument = await DriverService.getDocumentInDriver( _vehicleResponse!.codigoVehiculo!, codServicio );
    final isWithin  =  await DriverService.driverVerify(driverDocument!, codServicio.toString(), codCliente );
    _iswithin = isWithin;
    _documentDriverwithin = driverDocument;
    notifyListeners();
  }

  verifyDriverForYobel( int codServicio, String codCliente ) async {
    if( _vehicleResponse != null ){
      final driverDocument = await DriverService.getDocumentInDriverForYobel( _vehicleResponse!.nroPlaca!, codCliente );
      if( driverDocument != null ){
        final isWithin = await DriverService.driverVerify(driverDocument, codServicio.toString(), codCliente );
        _iswithin = isWithin;
        _documentDriverwithin = driverDocument;
      }else{
        _iswithin = false;
      }
      notifyListeners();
    }
  }

  cleandata(){
    _vehicleResponse = null;
    _iswithin = true;
    _documentDriverwithin = '';
    notifyListeners();
  }

}
