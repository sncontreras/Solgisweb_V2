import 'package:flutter/material.dart';

class MarcarServicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('SERVICIOS SOLGOD')),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  List<List<bool>> cellStates = List.generate(3, (_) => List.filled(4, false));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTable(
            columns: [
              DataColumn(label: Text('')),
              DataColumn(label: Text('liv')),
              DataColumn(label: Text('plat')),
              DataColumn(label: Text('pesa')),
              DataColumn(label: Text('conte')),
            ],
            rows: List.generate(
              3,
              (index) => DataRow(cells: [
                DataCell(Text(_getColumnName(index))), // Cambio en esta línea
                for (int i = 0; i < 4; i++)
                  DataCell(
                    Checkbox(
                      value: cellStates[index][i],
                      onChanged: (bool? value) {
                        setState(() {
                          cellStates[index][i] = value ?? false;
                        });
                      },
                    ),
                  ),
              ]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para guardar aquí
            },
            child: const Text('Guardar'),
          ),
          const SizedBox(
              height: 20), // Espacio entre el botón "Guardar" y la imagen
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/pngs/operador.png', // Ruta de la imagen en tu proyecto
                width: 200, // Ancho de la imagen
                height: 200, // Alto de la imagen
                // Puedes ajustar el ancho y alto según tus necesidades
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getColumnName(int index) {
    switch (index) {
      case 0:
        return 'km';
      case 1:
        return 'Liv';
      case 2:
        return 'PLATA';
      default:
        return 'CHE';
    }
  }
}
