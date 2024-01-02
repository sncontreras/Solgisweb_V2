import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/utils/dropdown_decoration.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';
import 'package:solgis/projects/cargo/presentation/widgets/dropdown_custom.dart';

class ParkingFieldWidget extends StatelessWidget {

  const ParkingFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    return Container(
      width: size.width,
      height: size.height * .1,
      margin: EdgeInsets.symmetric(vertical: size.height * .01),
      alignment: Alignment.center,

      child: Row(

        children: [

          DropDownCustom(
            text: "Parqueo: ",
            child: DropdownButtonFormField<String>(
              items: const [],
              onChanged: ( value ) {},
              hint: const Text("Parqueo", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
              style:const TextStyle(color:Colors.black, fontSize: 13),
              decoration: inputDecorationDropDown(),
              isExpanded: true,
              value: "hola",
            ),
          ),

        ],
      ),
    );
  }
}