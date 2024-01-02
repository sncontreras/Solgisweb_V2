// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
//import 'package:image_picker/image_picker.dart';

class VerifyDriverResponse extends Equatable{

  VerifyDriverResponse({
    this.isWithin,
    this.document,
  });

  bool? isWithin;
  String? document;

  @override
  List<Object?> get props => [ isWithin, document ];

}
