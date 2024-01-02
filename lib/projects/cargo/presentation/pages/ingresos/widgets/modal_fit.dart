import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/domain/entities/option_radio.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class ModalFit extends StatelessWidget {

  final List<OptionRadio> options;

  const ModalFit({
    Key? key, 
    required this.options, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Material(

      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map(
            (option) => ListTile(
              title: Text(option.tamanio.toString()),
              onTap:  () => entryProvider.selectedOptionRadio = option
            )
          ).toList(),

        ),
      )
    );
  }
}