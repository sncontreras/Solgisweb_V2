import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/salida/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';

class InitializedOutData extends StatelessWidget {
  const InitializedOutData({super.key});

  @override
  Widget build(BuildContext context) {
    
    final configProvider = Provider.of<ConfigProvider>(context);
    final config = configProvider.configuration!.configuration!.codeConfig!;

    switch ( config ){
      case 1:  
        return  const CargaTypeOutDataWidget();
      case 2:  
        return  const CargaStateOutDataWidget();
      case 3:  
        return  const OutDataWidget();
      default: 
        return  const CargaTypeOutDataWidget();
    }

  }
}