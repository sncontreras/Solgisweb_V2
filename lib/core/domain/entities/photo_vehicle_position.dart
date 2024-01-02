import 'package:image_picker/image_picker.dart';

class PhotoVehiclePosition{

  final int position ;
  XFile? file;

  PhotoVehiclePosition({
    required this.position,
    this.file,
  });

}