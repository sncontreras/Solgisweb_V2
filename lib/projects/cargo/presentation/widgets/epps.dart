import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/domain/entities/epps.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class EppsWidget extends StatelessWidget {

  final List<Epps> epps;
  const EppsWidget({
    Key? key, 
    required this.epps
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final items = epps.map((epp) => MultiSelectItem<Epps>(epp, epp.description!)).toList();

    return SizedBox(
      width: double.infinity,
      child: MultiSelectBottomSheetField<Epps?>(
        cancelText:  const Text("Cancelar"),
        confirmText: const Text("Confirmar"),
        buttonIcon:  const Icon(Icons.arrow_drop_down),
        items: items,
        listType: MultiSelectListType.LIST,
        onConfirm: ( value ) {
          entryProvider.selectedEpps = value.cast<Epps>();
          // ignore: avoid_print
          print("Actualizando el provider: ${entryProvider.selectedEpps}");
        },
        initialChildSize: .45,
        buttonText: const Text("Seleccione los EPPS"),
        title: const Text("EPPS"),
        chipDisplay: MultiSelectChipDisplay(),
        initialValue: entryProvider.selectedEpps!
      ),
    );

  }
}

