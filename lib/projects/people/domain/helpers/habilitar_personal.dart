//import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/people/data/services/personal_service.dart';
import 'package:solgis/projects/people/domain/models/persona_model.dart';
import 'package:solgis/projects/people/domain/models/response_persona_model.dart';
import 'package:solgis/projects/people/theme/theme.dart';

  Future<void> habilitarPersonal(BuildContext context, PersonalModel personal)async{

  // ignore: unused_local_variable
  final globalProvider = Provider.of<GlobalProvider>(context, listen: false);

  await NDialog(

    dialogStyle: DialogStyle(titleDivider: true, backgroundColor: Colors.white),
    title:  const Text("INFORMACION",  style: TextStyle(color: Colors.black)),
    content:  const Text("¿Estas seguro que deseas actualizar al personal?", style: TextStyle(color: Colors.black)),  
    
    actions: <Widget>[

      TextButton(

        child: const Text("Si"),

        onPressed: ()async{

          CustomProgressDialog progressDialog = CustomProgressDialog(context,blur: 10);
          progressDialog.setLoadingWidget(CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppThemePeople.lighThemePeople.primaryColor)));
          progressDialog.show();

          ResponsePersonalModel response = await PersonalProvider().updatePersonal(context, personal);

            if(response.personal_maestro !=-1){

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);

              // ignore: use_build_context_synchronously
              showSnackBarAwesome(context, 'Exito', "${response.message} ", ContentType.success);

          }else{
            // ignore: use_build_context_synchronously
              Navigator.pop(context);
            // ignore: use_build_context_synchronously
            showSnackBarAwesome(context, 'Error', 'Hubo un problema al registrar el personal', ContentType.failure);
          }

          progressDialog.dismiss();

        }, 

      ),

      TextButton(
        child: const Text("No"),
        onPressed: ()=> Navigator.pop(context)
      ),

    ],
  
  ).show(context);


}