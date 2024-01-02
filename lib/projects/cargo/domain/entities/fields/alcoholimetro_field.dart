// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class AlcoholimetroField extends Equatable{
    
    AlcoholimetroField({
      this.hasfoto,
      this.isMultiple,
    });

    bool? hasfoto;
    bool? isMultiple;
    
    @override
    List<Object?> get props => [ hasfoto, isMultiple ];


}
