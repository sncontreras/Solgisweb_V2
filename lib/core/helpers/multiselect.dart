import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:solgis/projects/cargo/domain/entities/epps.dart';

class MultiSelect {

  static showMultiSelect(BuildContext context, List<Epps> eppsItems) async {

    final multiSelectedItems =  eppsItems.map((epp) => MultiSelectItem( int.parse(epp.codeEpps!) , epp.description!)).toList();


    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: ( _ ) {
        return  MultiSelectBottomSheet<int>(
          items: multiSelectedItems,
          initialValue: const [],
          onConfirm: (values) {},
          maxChildSize: 0.8,
        );
      },
    );
  }


}


