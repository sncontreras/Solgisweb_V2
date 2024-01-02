import 'package:flutter/foundation.dart';
import 'package:solgis/projects/patrol/data/services/tiposfoto_service.dart';

class TipoFotosProvider extends ChangeNotifier {
  List<Map<String, int>> _perfiles = [];

  List<Map<String, int>> get perfiles => _perfiles;

  void actualizarTiposFoto() async {
    final tiposfotoService = TiposFotoService();
    final tiposfoto = await tiposfotoService.getTiposFoto('3');
    for (var i = 0; i < tiposfoto.length; i++) {
      //_perfiles[i] = {"s": 1};
      _perfiles.add({"${tiposfoto[i].nombre}": tiposfoto[i].codigoBien!});
    }
    //_perfiles = tiposfoto.map((aux) => {aux.nombre: aux.codigoBien}).toList();
  }

  void actualizarPerfiles(List<Map<String, int>> nuevosPerfiles) {
    _perfiles = [];
    _perfiles = nuevosPerfiles;
    notifyListeners();
  }
}
