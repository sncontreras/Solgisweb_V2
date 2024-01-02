import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotoProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  PickedFile? _foto; // Variable que almacenará la foto capturada

  PickedFile? get foto => _foto;
//  ImagePicker? get picker => _picker;

  Future<void> tomarFotoDirecto() async {
    try {
      _foto = await _picker.getImage(source: ImageSource.camera);
      if (_foto != null) {
        notifyListeners(); // Notifica a los oyentes sobre el cambio en la foto
      }
    } catch (e) {
      print('Error al tomar la foto: $e');
    }
  }

  void limpiarFoto() {
    _foto = null; // Borra la foto actual
    notifyListeners(); // Notifica a los oyentes sobre el cambio
  }
}
