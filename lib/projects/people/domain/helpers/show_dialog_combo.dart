import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/people/data/services/cliente_service.dart';
import 'package:solgis/projects/people/domain/models/cliente_model.dart';

showSheet( BuildContext context, String route ){

  final size = MediaQuery.of(context).size;
  final clienteService = ClienteService();
  final gProvider = Provider.of<GlobalProvider>(context, listen: false);
  final relacion = gProvider.relationModel;

  showModalBottomSheet(
    context: context,
    shape: _shapeModal(),
    builder: (context) {
      return SizedBox(
        height: size.height * .3,
        child: FutureBuilder(
          future: clienteService.getServiciosXCliente(relacion.codigoCliente!),
          builder: (BuildContext context, AsyncSnapshot<List<ServicioXClienteModel>> snapshot) {

            if(!snapshot.hasData)return const Center(child: CircularProgressIndicator());

            final servicios = snapshot.data;

            return Column(

              children: [

                Container(
                  alignment: Alignment.center,
                  height: size.height * .05,
                  width:  double.infinity,
                  child:  Text('Seleccione el Servicio', style: TextStyle(fontSize: size.width * .05, fontWeight: FontWeight.bold))
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: servicios!.length,
                    itemBuilder: ( context, index ) => GestureDetector(
                      onTap: () {
                        _updateService(context, servicios[index]);
                        Navigator.pushNamed(context, route);
                      },
                      child: ListTile(title: Text( servicios[index].sede!.toLowerCase())),
                    ),
                  ),
                )

              ],
            );
          },
        ),
      );
    },
  );

}

void _updateService( BuildContext context, ServicioXClienteModel servicios ) {
  final gProvider             = Provider.of<GlobalProvider>(context, listen: false);
  final relacion              = gProvider.relationModel;
  relacion.codigoServicio     = int.parse(servicios.codigo!);
  relacion.codigoSubArea      = servicios.codigoSubArea;
  relacion.nombreArea         = servicios.nombreArea;
  relacion.nombreSubArea      = servicios.nombreSubArea;
  relacion.nombreSucursal     = servicios.nombreSucursal;
  relacion.aliasSede          = servicios.aliasSede;
  relacion.codigoTipoServicio = servicios.codTipoServicio;
}

RoundedRectangleBorder _shapeModal() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top:Radius.circular(20)
    )
  );
}