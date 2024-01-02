import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/helpers/pattern_string.dart';
import 'package:solgis/projects/cargo/data/models/tipos_carga_model.dart';
import 'package:solgis/projects/cargo/data/services/carga_type__services.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class MaterialsFieldOutWidget extends StatelessWidget {

  const MaterialsFieldOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);

    return Stack(

      children: [

        GestureDetector(
          onTap: () async {
            await showMaterialModalBottomSheet(
              context: context,
              expand: false,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Material(
                  child: SafeArea(
                    top: false,
                    child: FutureBuilder(
                      future: CargaTypeService.getCargaType( gProvider.relationModel.codigoCliente.toString(), isMaterial: true),
                      builder: ( _ , AsyncSnapshot<List<TipoCargaModel>> snapshot) {
                        if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                        final cargas = snapshot.data;
                        return ListView.builder(
                          itemCount: cargas!.length,
                          itemBuilder: ( _ , i) {
                            final carga = cargas[i];
                            return ListTile(
                              title: Text( StringHelper.patternString(carga.cargaType!) ),
                              onTap: (){
                                outProvider.materialSelected = carga;
                                Navigator.pop(context);
                              },
                            );
                          } ,
                        );
                      },
                    ),
                  )
                );
              }
            );
          },
          child: Container(
            width:  size.width * .9,
            height: size.height * .065,
            margin: EdgeInsets.symmetric(vertical: size.height * .01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              )
            ),
            child: ( outProvider.materialSelected.codigo == null )
              ? const Text( "Seleccione el Tipo de Material" )
              : Text( StringHelper.patternString( outProvider.materialSelected.cargaType! ) )
          ),
        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xffFAFAFA),
            child: const Text(
              'Material',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

      ],
    );
  }
}