import 'package:flutter/material.dart';
import 'package:solgis/projects/patrol/data/models/bien_model.dart';
import 'package:solgis/projects/patrol/data/services/bien_service.dart';

class BienProvider extends ChangeNotifier {
  BienService listaBien = BienService();

  final List<BienDbModel> _itemsBien = [];

  List<BienDbModel> get itemsBien => _itemsBien;

  Future<List<BienDbModel>> initBienes(String codCliente) async {
    if (_itemsBien.isEmpty) {
      //_itemsBien = await listaBien.getBienes(codCliente);
      notifyListeners();
    }
    return _itemsBien;
  }
}
