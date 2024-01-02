import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/presentation/widgets/dropdown_button.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/projects/patrol/data/models/bien_model.dart';
import 'package:solgis/projects/patrol/data/services/bien_service.dart';
import 'package:solgis/projects/patrol/data/services/tiposfoto_service.dart';
import 'package:solgis/projects/patrol/presentation/providers/bien_provider.dart';
import 'package:solgis/projects/patrol/presentation/providers/registro_provider.dart';
import 'package:solgis/projects/patrol/presentation/providers/tipo_fotos_provider.dart';
import 'package:solgis/projects/people/styles/style.dart';

class BienSelectorWidget extends StatefulWidget {
  const BienSelectorWidget({Key? key}) : super(key: key);

  @override
  BienSelectorState createState() => BienSelectorState();
}

class BienSelectorState extends State<BienSelectorWidget> {
  /* @override
  void initState() {
    super.initState();
    final gProvider = Provider.of<GlobalProvider>(context);

    final bienProvider = Provider.of<BienProvider>(context);
    final registroProvider = Provider.of<RegistroProvider>(context);
    final codcliente = gProvider.relationModel.codigoServicio! - 3169;

    bienProvider.initBienes(codcliente.toString()).then((bienes) {
      if (bienes.isNotEmpty) {
        registroProvider.bienTemp = bienes[0].codigoBien!;
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final bienService = BienService();
    final tiposfotoService = TiposFotoService();
    final size = MediaQuery.of(context).size;
    final tipoFotosProvider = Provider.of<TipoFotosProvider>(context);
    final registroProvider = Provider.of<RegistroProvider>(context);

    //nuevo codigo
    final bienProvider = Provider.of<BienProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);
    final codcliente = gProvider.relationModel.codigoServicio! - 3169;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Bien:  ', style: styleCrearPersonaltextForm()),
        FutureBuilder(
          future: bienService.getBienes(context, '1'),
          //future: bienProvider.initBienes(codcliente.toString()),
          builder: (BuildContext context,
              AsyncSnapshot<List<BienDbModel>> snapshot) {
            if (!snapshot.hasData) {
              return ShimmerWidget(
                  width: size.width * 0.57, height: size.height * 0.04);
            }

            if (snapshot.data!.isEmpty) return Container();
            final bienes = snapshot.data;

            if (bienes!.length == 1) {
              registroProvider.bienTemp = bienes[0].codigoBien!;
              return DropdownButtonWidget(
                items: [
                  DropdownMenuItem(
                      value: bienes[0].codigoBien,
                      child: Text(bienes[0].nombre!.toLowerCase()))
                ],
                onchanged: null,
                value: bienes[0].codigoBien,
              );
            }
            //registroProvider.bienTemp = bienes[0].codigoBien!;
            List<DropdownMenuItem<int>> dropdownmotivos = [];
            for (final bien in bienes) {
              if (bien.codigoBien != null) {
                //perfiles.add({"${bien.nombre}": bien.codigoBien ?? 0});
                final DropdownMenuItem<int> motivoTemp = DropdownMenuItem(
                    value: bien.codigoBien,
                    child: Text(bien.nombre!.toLowerCase()));
                dropdownmotivos.add(motivoTemp);
              }
            }

            /*bienService.getBienes('2').then((_) {
                    if (actualizacionRealizada == 0) {
                      setState(() {
                        actualizacionRealizada = 1;
                        tipoFotosProvider.actualizarPerfiles(perfiles);
                        // No deberías necesitar reiniciar perfiles a perfilesaux.
                      });
                    }
                  });*/
            return DropdownButtonWidget(
              items: dropdownmotivos,
              onchanged: (value) => {
                //registroProvider.cleanPerfiles(),
                registroProvider.bienTemp = value!,
                print(registroProvider.subbienTemp),
                //tiposfotoService.getTiposFoto('3'),
                //tipoFotosProvider.actualizarTiposFoto(),
                //tipoFotosProvider.actualizarPerfiles(perfiles),
              },
              hintText:
                  (bienes.isEmpty) ? 'No hay bienes' : 'Seleccione el bien',
              value: dropdownmotivos.first.value!,
            );
          },
        ),
      ],
    );
  }
}
