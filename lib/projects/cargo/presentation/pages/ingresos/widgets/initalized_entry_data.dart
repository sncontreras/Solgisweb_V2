import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';

class InitializedEntryData extends StatelessWidget {
  const InitializedEntryData({super.key});

  @override
  Widget build(BuildContext context) {

    final configProvider = Provider.of<ConfigProvider>(context);
    final config         = configProvider.configuration?.configuration!.codeConfig!;

    switch ( config ){
      case 1:  
        return const CargaTypeEntryDataWidget();
      case 2:  
        return const CargaStateEntryDataWidget();
      case 3:  
        return const EntryDataWidget();
      default: 
        return const CargaTypeEntryDataWidget();
    }

  }
}