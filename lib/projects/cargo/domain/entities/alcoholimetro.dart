// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class Alcoholimetro extends Equatable{

  Alcoholimetro({
    required this.result,
    this.photo,
  });

  bool result = false;
  XFile? photo;

  @override
  List<Object?> get props => [ result, photo ];

}
