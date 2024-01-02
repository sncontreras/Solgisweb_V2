import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/people/data/services/cliente_service.dart';
import 'package:solgis/projects/people/domain/models/cliente_model.dart';

showSheetCustom(BuildContext context, String textTitle) {
  final size = MediaQuery.of(context).size;
  final clienteService = ClienteService();
  final TextEditingController searchController =
      TextEditingController(text: '');

  showModalBottomSheet(
      shape: _shapeModal(),
      context: context,
      builder: (context) {
        return SizedBox(
          height: size.height * .7,
          child: FutureBuilder(
            future: clienteService.getClientes(searchController.text),
            builder: (BuildContext context,
                AsyncSnapshot<List<ClienteModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final clientes = snapshot.data;

              return Column(
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                    width: double.infinity,
                    
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        clienteService.getClientes(value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Buscar cliente',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: clientes!.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          _updateCliente(context, clientes[index]);
                          Navigator.pop(context);
                        },
                        child: ListTile(
                            title: Text(
                                clientes[index].nombCliente!.toLowerCase())),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      });
}

void _updateCliente(BuildContext context, ClienteModel cliente) {
  final gProvider = Provider.of<GlobalProvider>(context, listen: false);
  final relacion = gProvider.relationmodel;
  relacion.codigoCliente = cliente.codigo;
  relacion.nombreCliente = cliente.nombCliente;
}

RoundedRectangleBorder _shapeModal() {
  return const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)));
}
