import 'package:flutter/material.dart';
import 'package:solgis/projects/patrol/data/models/subbien_model.dart';
import 'package:solgis/projects/patrol/data/services/subbien_service.dart';

class SubBienProvider extends ChangeNotifier {
  SubBienService listaSubBien = SubBienService();

  List<SubBienDbModel> _itemsSubBien = [];

  List<SubBienDbModel> get itemsSubBien => _itemsSubBien;

  Future<List<SubBienDbModel>> initSubBienes(String codBien) async {
    if (_itemsSubBien.isEmpty) {
      _itemsSubBien = await listaSubBien.getSubBienes(codBien);
      notifyListeners();
    }
    return _itemsSubBien;
  }
}
