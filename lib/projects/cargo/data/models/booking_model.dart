
// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/booking_field.dart';

class BookingModel extends BookingField{

  BookingModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  BookingModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }

  }

}