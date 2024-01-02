// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/enterprise_service.dart';
import 'package:solgis/core/data/services/job_service.dart';
import 'package:solgis/core/data/services/personal_service.dart';
import 'package:solgis/core/domain/entities/job.dart';
import 'package:solgis/core/domain/entities/person_type.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/models/enterprise_model.dart';
import 'package:solgis/core/domain/models/register_person_model.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
//import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/global/constants.dart';
import 'package:solgis/core/presentation/widgets/dropdown_button_sheet.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/projects/cargo/core/helpers/show_dialog_photo.dart';
import 'package:solgis/projects/cargo/core/styles/style.dart';
import 'package:solgis/projects/cargo/presentation/pages/driver/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/custom_input_field.dart';
import 'package:solgis/projects/cargo/presentation/providers/create_driver_provider.dart';

class CreateDriverCargoPage extends StatelessWidget {
  const CreateDriverCargoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => CreateDriverProvider())),
      ],
      child: _CreateDriverCargoStatePage(),
    );

  }
}

class _CreateDriverCargoStatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 20,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: AutoSizeText(
          'Crear Conductor', 
          style:styleCrearPersonalTitulo().copyWith(
            fontWeight:FontWeight.bold
          )
        ),
      ),
      body: _CreateDriverPageBody(),
    );
  }
}

class _CreateDriverPageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final driverProvider = Provider.of<CreateDriverProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: driverProvider.formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children: [

              //imagen
              const CardImageDriver(),
              SizedBox(height: size.height*0.05),

              //Tipo de documento y numero de documento
              const DocumentRegisterDriver(),
              SizedBox(height: size.height*0.01),

              //Genero
              DropDownButtonSheet(
                textLabel: driverProvider.selectedGender.gender , 
                textTitle: 'Genero',
                widgets: genders.map(
                  (option) => ListTile(
                    title: Text( option.gender ),
                    onTap: (){
                      driverProvider.selectedGender = option;
                      Navigator.pop(context);
                    },
                  )
                ).toList(), 
              ),
              SizedBox(height: size.height*0.01),

              //Tipo de Persona
              FutureBuilder(
                future: Future.delayed(
                  const Duration(seconds: 2),
                  (){return typesPerson;}
                ),

                builder: ( _ , AsyncSnapshot<List<PersonType>> snapshot ) {

                  if( !snapshot.hasData ){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ShimmerWidget(
                        width:  size.width,
                        height: size.height * .08,
                      ),
                    );
                  }

                  final items = snapshot.data;
                  return DropDownButtonSheet(
                    textLabel: ( driverProvider.selectedPersonType.personType == null )
                      ? 'Seleccione el tipo de persona'
                      : driverProvider.selectedPersonType.personType! , 
                    textTitle: 'Tipo de Persona',
                    widgets: items!.map(
                      (option) => ListTile(
                        title: Text( option.personType! ),
                        onTap: (){
                          driverProvider.selectedPersonType = option;
                          Navigator.pop(context);
                        },
                      )
                    ).toList(), 
                  );

                },

              ),

              SizedBox(height: size.height*0.01), 

              //Primer Nombre
              CustomInputField(
                textinputController: driverProvider.fNameController,
                hinttext: "Ingrese el Primer Nombre",
                keyboardType: TextInputType.text,
                labelText: 'P. Nombre',
                oneditingcomplete: () => FocusScope.of(context).nextFocus(),
              ),

              SizedBox(height: size.height*0.02), 

              //Segundo Nombre
              CustomInputField(
                textinputController: driverProvider.sNameController,
                hinttext: "Ingrese el Segundo Nombre",
                keyboardType: TextInputType.text,
                labelText: 'S. Nombre',
                oneditingcomplete: () => FocusScope.of(context).nextFocus(),
              ),

              SizedBox(height: size.height*0.02), 

              //Primer Apellido
              CustomInputField(
                textinputController: driverProvider.fLastNameController,
                hinttext: "Ingrese el Primer Apellido",
                keyboardType: TextInputType.text,
                labelText: 'P. Apellido',
                oneditingcomplete: () => FocusScope.of(context).nextFocus(),
              ),

              SizedBox(height: size.height*0.02), 

              //Segundo Apellido
              CustomInputField(
                textinputController: driverProvider.sLastNameController,
                hinttext: "Ingrese el Segundo Apellido",
                keyboardType: TextInputType.text,
                labelText: 'S. Apellido',
                oneditingcomplete: () => FocusScope.of(context).nextFocus(),
              ),

              SizedBox(height: size.height*0.02), 

              //Empresa
              FutureBuilder(
                future: EnterpriseService.getEnterpriseByCustomer("", "-1",  gProvider.relationModel.codigoCliente.toString()),

                builder: ( _ , AsyncSnapshot<List<EnterpriseModel>> snapshot ) {

                  if( !snapshot.hasData ){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ShimmerWidget(
                        width:  size.width,
                        height: size.height * .08,
                      ),
                    );
                  }

                  final items = snapshot.data;
                  return DropDownButtonSheet(
                    textLabel: ( driverProvider.selectedEnterprise.codigo == null )
                      ? 'Seleccione la Empresa'
                      : driverProvider.selectedEnterprise.empresa!.toLowerCase() , 
                    textTitle: 'Empresa',
                    widgets: items!.map(
                      (option) => ListTile(
                        title: Text( option.empresa!.toLowerCase() ),
                        onTap: (){
                          driverProvider.selectedEnterprise = option;
                          Navigator.pop(context);
                        },
                      )
                    ).toList(), 
                  );

                },

              ),

              //Cargo
              FutureBuilder(
                future: JobService.getJobs('', gProvider.relationModel.codigoCliente! ),

                builder: ( _ , AsyncSnapshot<List<Job>> snapshot ) {

                  if( !snapshot.hasData ){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ShimmerWidget(
                        width:  size.width,
                        height: size.height * .08,
                      ),
                    );
                  }

                  final items = snapshot.data;
                  return DropDownButtonSheet(
                    textLabel: ( driverProvider.selectedJob.codigo == null )
                      ? 'Seleccione el Cargo'
                      : driverProvider.selectedJob.cargo!.toLowerCase() , 
                    textTitle: 'Cargo',
                    widgets: items!.map(
                      (option) => ListTile(
                        title: Text( option.cargo!.toLowerCase() ),
                        onTap: (){
                          driverProvider.selectedJob = option;
                          Navigator.pop(context);
                        },
                      )
                    ).toList(), 
                  );

                },

              ),

              SizedBox(height: size.height*0.02), 

              //Licencia
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
                      textinputController: driverProvider.licenseController,
                      hinttext: "Ingrese la licencia",
                      keyboardType: TextInputType.text, 
                      labelText: 'Licencia',
                    ),
                  ),
                  IconButton(
                    onPressed: ( driverProvider.photoLicense != null )
                      ? () => showDialogPhoto(
                        context, 
                        driverProvider.photoLicense!, 
                        'Foto de la licencia',
                        (){
                          driverProvider.photoLicense = null;
                          Navigator.pop(context);
                        }
                      )
                      : () async {
                        final ImagePicker picker = ImagePicker();
                        final  XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera,
                        );
                        if(pickedFile != null) driverProvider.photoLicense = pickedFile; 
                      }, 
                    icon: FaIcon( 
                      FontAwesomeIcons.camera, 
                      color: (driverProvider.photoLicense != null)
                      ? Colors.green
                      : Colors.black, 
                    ),
                  )
                ], 
              ),
              SizedBox(height: size.height*0.02), 

              //Boton
              Container(
                width: size.width,
                height: size.height * .07,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                  onPressed: ( driverProvider.isLoading )
                    ? null
                    : () async {

                      if( driverProvider.documentController.text  == "" ) return showSnackBarAwesome(context, "!Atencion¡", "Por favor, ingrese un documento valido", ContentType.failure);
                      if( driverProvider.selectedPersonType.codePersonType == null ) return showSnackBarAwesome(context, "!Atencion¡", "Por favor, seleccione el tipo de persona", ContentType.failure);
                      if( driverProvider.selectedEnterprise.codigo == null ) return showSnackBarAwesome(context, "!Atencion¡", "Por favor, seleccione una Empresa", ContentType.failure);
                      if( driverProvider.selectedJob.codigo == null ) return showSnackBarAwesome(context, "!Atencion¡", "Por favor, seleccione un cargo", ContentType.failure);

                      driverProvider.isLoading = true;

                      final body =  RegisterPersonModel(
                        codigoPersonal: 0,
                        docPersonal: driverProvider.documentController.text,
                        nombre1: driverProvider.fNameController.text,
                        nombre2: driverProvider.sNameController.text,
                        apellido1: driverProvider.fLastNameController.text,
                        apellido2: driverProvider.sLastNameController.text,
                        codigoCargo: int.parse(driverProvider.selectedJob.codigo!),
                        codigoClienteControl: int.parse(gProvider.relationModel.codigoCliente!),
                        codigoEmpresa: driverProvider.selectedEnterprise.codigo!,
                        codigoTipoDocumento: driverProvider.selectedDocumentType.codeDocumentType,
                        codigoTipoPersonal: driverProvider.selectedPersonType.codePersonType!,
                        creadoPor: 'CARGO_${gProvider.relationModel.codigoServicio} ',
                        nroLicense: driverProvider.licenseController.text,
                        esAutorizante: '0',
                        habilitado: true,
                        sexo: (driverProvider.selectedGender.genderCode == 1) ?'M' : 'F',
                        tieneFoto: false,
                      );

                      final resp = await PersonalService.personRegister(context, body);

                      if( resp.personalMaestro  == -1 ){
                        showSnackBarAwesome(context, "!Atencion¡", resp.message!, ContentType.warning);
                      }else{
                        if( driverProvider.foto != null )         await PersonalService.uploadPersonPhoto( driverProvider.foto!, driverProvider.documentController.text, gProvider.relationModel.codigoCliente! );
                        if( driverProvider.photoLicense != null ) await PersonalService.uploadLicensePhoto( driverProvider.photoLicense!.path,  "CARGO_${gProvider.relationModel.codigoServicio}",  driverProvider.documentController.text);
                        Navigator.pop(context);
                        showSnackBarAwesome(context, "!Atencion¡", resp.message!, ContentType.success);
                      }

                      driverProvider.isLoading = false;
                    }, 
                  child: ( driverProvider.isLoading )
                    ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                    : const Text(
                      "Registrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    )
                ),
              )

            ],

          ),
        ),
      ),
    );



  }

}