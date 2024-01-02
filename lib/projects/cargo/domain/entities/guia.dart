// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class Guia extends Equatable{

  Guia({
    required this.descripcion,
    this.file,
  });

  String descripcion;
  XFile? file;

  @override
  List<Object?> get props => [ descripcion, file ];

}
