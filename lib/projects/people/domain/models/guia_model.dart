// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class Guia extends Equatable {

  Guia({
    required this.description,
    this.file,
  });

  String description;
  XFile? file;

  @override
  List<Object?> get props => [ description, file];

}
