
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/projects/cargo/domain/objetos/objetos.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/ingresos_pages.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class IngresoDenegadoCargoPage extends StatelessWidget {

  const IngresoDenegadoCargoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return IngresoCargoPage(
      titleIngreso: 'INGRESO DENEGADO',
      colorAppBar: Colors.red,
      body: const _IngresoDenegadoBody(),
      /*registrarFunction: () async {
        validatingFieldsEntryMovCargo(context, consulta);
      },*/
    ); 
  }
}

class _IngresoDenegadoBody extends StatelessWidget {
  const _IngresoDenegadoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    // ignore: unused_local_variable
    final config = Provider.of<ConfigProvider>(context).configuration;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height *  .03),

          //FOTO
          FutureBuilder(

            future: getImage('https://c0.klipartz.com/pngpicture/252/313/gratis-png-vista-frontal-del-carro-acura.png'),

            builder: ( _ , AsyncSnapshot<Widget>  snapshot) {

              if(!snapshot.hasData){
                return SizedBox(
                  width: size.width*0.4,
                  height: size.width*0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      image: AssetImage('assets/gifs/loader.gif'),
                    ),
                  ),
                );
              }

              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: size.width*0.4,
                  height: size.width*0.4,
                  child: snapshot.data,
                ),
              );

            },
          ),

          SizedBox(height: size.height *  .03),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Placa: ' , style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 18
              )),
              SizedBox(width:  size.width * .05),
              Text('abc123', style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 18
              ))
            ],
          ),

          SizedBox(height: size.height *  .03),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [

              Text('Tipo de Vehiculo: ' , style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 18
              )),
              SizedBox(width:  size.width * .05),
              Text('Camioneta', style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 18
              ))
            ],
          ),

          SizedBox(height: size.height *  .03),

          Stack(
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: cargastype.map(
                              (option) => ListTile(
                                title: Text( option.cargaType! ),
                                onTap: (){
                                  entryProvider.cargaTypeSelected = option;
                                  Navigator.pop(context);
                                },
                              )
                            ).toList(),
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
                  child: ( entryProvider.cargaTypeSelected.codigo == null )
                    ? const Text("Seleccione el Tipo de Carga")
                    : Text(entryProvider.cargaTypeSelected.cargaType!)
                ),
              ),

              Positioned(
                left: 20,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  color: const Color(0xffFAFAFA),
                  child: const Text(
                    'Tipo de Carga',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ),

            ],
          ),

          SizedBox(height: size.height *  .03),

          Container(
            width: double.infinity,
            // color: Colors.red,
            height: size.height  * .3,
            alignment: Alignment.center,
            child: Text(
              'NO PUEDE INGRESAR POR FALTA DE AUTORIZACION',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 20,
                color: Colors.red
              ),
            ),
          )

        ],
      ),
    );
    
  }
}

