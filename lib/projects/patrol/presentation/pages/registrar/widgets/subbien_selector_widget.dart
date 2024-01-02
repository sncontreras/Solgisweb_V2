import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/presentation/widgets/dropdown_button.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/projects/patrol/data/models/subbien_model.dart';
import 'package:solgis/projects/patrol/data/services/subbien_service.dart';
import 'package:solgis/projects/patrol/presentation/providers/registro_provider.dart';
import 'package:solgis/projects/patrol/presentation/providers/subbien_provider.dart';
import 'package:solgis/projects/people/styles/style.dart';

class SubBienSelectorWidget extends StatefulWidget {
  const SubBienSelectorWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SubBienSelectorState createState() => _SubBienSelectorState();
}

class _SubBienSelectorState extends State<SubBienSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);
    final subBienService = SubBienService();
    final size = MediaQuery.of(context).size;

    //nuevo codigo
    final subBienProvider = Provider.of<SubBienProvider>(context);
    final codbien = registroProvider.bienTemp;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('SubBien:  ', style: styleCrearPersonaltextForm()),
        FutureBuilder(
          future: subBienService.getSubBienes(registroProvider.bienTemp.toString()),
          //future: subBienProvider.initSubBienes(codbien.toString()),
          builder: (BuildContext context,
              AsyncSnapshot<List<SubBienDbModel>> snapshot) {
            if (!snapshot.hasData) {
              return ShimmerWidget(
                  width: size.width * 0.57, height: size.height * 0.04);
            }

            if (snapshot.data!.isEmpty) return Container();
            final subbienes = snapshot.data;

            if (subbienes!.length == 1) {
              registroProvider.subbienTemp = subbienes[0].codigoSubBien!;
              return DropdownButtonWidget(
                items: [
                  DropdownMenuItem(
                      value: subbienes[0].codigoSubBien,
                      child: Text(subbienes[0].nombre!.toLowerCase()))
                ],
                onchanged: null,
                value: subbienes[0].codigoSubBien,
              );
            }

            List<DropdownMenuItem<int>> dropdownsubbienes = [];
            for (final subbien in subbienes) {
              if (subbien.codigoSubBien != null) {
                final DropdownMenuItem<int> subbienTemp = DropdownMenuItem(
                    value: subbien.codigoSubBien,
                    child: Text(subbien.nombre!.toLowerCase()));
                dropdownsubbienes.add(subbienTemp);
              }
            }
            return DropdownButtonWidget(
              items: dropdownsubbienes,
              onchanged: (value) => {
                registroProvider.subbienTemp = value!,
              },
              hintText: (subbienes.isEmpty)
                  ? 'No hay subbienes'
                  : 'Seleccione el subbien',
              value: dropdownsubbienes.first.value!,
            );
          },
        ),
      ],
    );
  }
}
