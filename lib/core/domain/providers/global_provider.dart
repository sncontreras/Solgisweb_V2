import 'package:flutter/material.dart';
import 'package:solgis/core/domain/models/device_model.dart';

class GlobalProvider extends ChangeNotifier{

  RelacionDispositivoModel relationModel = RelacionDispositivoModel();

  //METODOS PARA LA VARIABLE RELACIONDISPOSITIVOMODEL
  RelacionDispositivoModel get relationmodel => relationModel;

  set relationmodel( RelacionDispositivoModel value ){
    relationModel = value;
    // notifyListeners();
  }


}