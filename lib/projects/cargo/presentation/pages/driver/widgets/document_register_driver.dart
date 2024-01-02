import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/global/constants.dart';
import 'package:solgis/core/presentation/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/custom_input_field.dart';
import 'package:solgis/projects/cargo/presentation/providers/create_driver_provider.dart';


class DocumentRegisterDriver extends StatelessWidget {
  const DocumentRegisterDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final driverProvider = Provider.of<CreateDriverProvider>(context);  

    return Column(
      children: [

        // Campo para el tipo de documento 
        DropDownButtonSheet(
          textLabel: driverProvider.selectedDocumentType.description , 
          textTitle: 'Tipo de Documento',
          widgets: typesDocument.map(
            (option) => ListTile(
              title: Text( option.description ),
              onTap: (){
                driverProvider.selectedDocumentType = option;
                driverProvider.documentController.text  = '';
                Navigator.pop(context);
              },
            )
          ).toList(), 
        ),

        SizedBox(height: size.height*0.01),

        //Campo para el numero de documento
        CustomInputField(
          textinputController: driverProvider.documentController,
          hinttext: "Ingrese el Documento",
          keyboardType: ( driverProvider.selectedDocumentType.codeDocumentType == 1 )
            ? TextInputType.number
            : TextInputType.text, 
          labelText: 'Documento',
          maxlength: (driverProvider.selectedDocumentType.codeDocumentType == 1 ) ? 8 : 12,
        ),

      ],

    );

  }
}