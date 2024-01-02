// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/enterprise_service.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/models/enterprise_model.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/core/presentation/widgets/widgets.dart';
import 'package:solgis/projects/cargo/core/helpers/show_dialog_photo.dart';
import 'package:solgis/projects/cargo/core/styles/style.dart';
import 'package:solgis/projects/cargo/data/models/create_vehicle_body.dart';
import 'package:solgis/projects/cargo/data/models/tipos_carga_model.dart';
import 'package:solgis/projects/cargo/data/services/carga_type__services.dart';
import 'package:solgis/projects/cargo/data/services/photo_vehicle_service.dart';
import 'package:solgis/projects/cargo/data/services/vehicle_service.dart';
import 'package:solgis/projects/cargo/domain/entities/vehicle_type.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/custom_input_field.dart';
import 'package:solgis/projects/cargo/presentation/pages/vehicle/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/create_vehicle_provider.dart';

class CreateVehicleCargoPage extends StatelessWidget {
  const CreateVehicleCargoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Map argument = ModalRoute.of(context)!.settings.arguments as Map;
    String placa =  argument['placa'];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => CreateVehicleProvider())),
      ],
      child: _CreateVehicleCargoStatePage(placa: placa),
    );

  }
}

class _CreateVehicleCargoStatePage extends StatelessWidget {

  final String placa;

  const _CreateVehicleCargoStatePage({Key? key, required this.placa}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 20,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: AutoSizeText(
          'Crear Vehiculo', 
          style:styleCrearPersonalTitulo().copyWith(
            fontWeight:FontWeight.bold
          )
        ),
      ),
      body:  _CreateVehicleCargoBody(placa: placa),
    );
  }
}

class _CreateVehicleCargoBody extends StatelessWidget {

  final String placa;

  const _CreateVehicleCargoBody({Key? key, required this.placa}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final cvehProvider = Provider.of<CreateVehicleProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);
    cvehProvider.placaController.text = placa;
    initializeDateFormatting('es');

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              //imagen
              const CardImageVehicle(),
              SizedBox(height: size.height*0.05),

              //placa
              CustomInputField(
                textcap: TextCapitalization.characters,
                textinputController: cvehProvider.placaController,
                hinttext: "Ingrese la Placa",
                keyboardType: TextInputType.text,
                labelText: 'Placa',
                maxlength: 6,
              ),
              SizedBox(height: size.height*0.01), 

              //tipo de vehiculo
              FutureBuilder(
                future: VehicleService.getVehicleTypes( null, gProvider.relationModel.codigoCliente!),

                builder: ( _ , AsyncSnapshot<List<VehicleType>> snapshot ) {

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
                    textLabel: ( cvehProvider.selectedVehicleType.codeVehicleType == null )
                      ? 'Seleccione el Tipo de Vehiculo'
                      : cvehProvider.selectedVehicleType.vehicleType!.toLowerCase() , 
                    textTitle: 'Tipo de Vehiculo',
                    widgets: items!.map(
                      (option) => ListTile(
                        title: Text( option.vehicleType!.toLowerCase() ),
                        onTap: (){
                          cvehProvider.selectedVehicleType = option;
                          Navigator.pop(context);
                        },
                      )
                    ).toList(), 
                  );

                },

              ),

              //tipo de carga
              FutureBuilder(

                future: CargaTypeService.getCargaType( gProvider.relationModel.codigoCliente.toString()),

                builder: ( _ , AsyncSnapshot<List<TipoCargaModel>> snapshot ) {

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
                    textLabel: ( cvehProvider.selectedCargaType.codigo == null )
                      ? 'Seleccione el Tipo de Carga'
                      : cvehProvider.selectedCargaType.cargaType!.toLowerCase() , 
                    textTitle: 'Tipo de Carga',
                    widgets: items!.map(
                      (option) => ListTile(
                        title: Text( option.cargaType!.toLowerCase() ),
                        onTap: (){
                          cvehProvider.selectedCargaType = option;
                          Navigator.pop(context);
                        },
                      )
                    ).toList(), 
                  );

                },

              ),
              SizedBox(height: size.height*0.01), 

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
                    textLabel: ( cvehProvider.selectedEnterprise.codigo == null )
                      ? 'Seleccione la empresa'
                      : cvehProvider.selectedEnterprise.empresa!.toLowerCase() , 
                    textTitle: 'Empresa',
                    widgets: items!.map(
                      (option) => ListTile(
                        title: Text( option.empresa!.toLowerCase() ),
                        onTap: (){
                          cvehProvider.selectedEnterprise = option;
                          Navigator.pop(context);
                        },
                      )
                    ).toList(), 
                  );

                },

              ),
              SizedBox(height: size.height*0.01), 

              //tarjeta de propiedad
              Row(

                children: [

                  Expanded(
                    child: CustomInputField(
                      textinputController: cvehProvider.propertyCardControlller,
                      hinttext: "Ingrese la Tarjeta de Propiedad",
                      keyboardType: TextInputType.text, 
                      labelText: 'Tarjeta de Propiedad',
                    ),
                  ),

                  IconButton(
                    onPressed: ( cvehProvider.propertyCardphoto != null )
                      ? () => showDialogPhoto(
                        context, 
                        cvehProvider.propertyCardphoto!, 
                        'Foto de la tarjeta de propiedad',
                        (){
                          cvehProvider.propertyCardphoto = null;
                          Navigator.pop(context);
                        }
                      )
                      : () async {
    
                        final ImagePicker picker = ImagePicker();
    
                        final  XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera,
                        );
    
                        if(pickedFile != null) cvehProvider.propertyCardphoto = pickedFile; 
    
                      }, 
                    icon: FaIcon( 
                      FontAwesomeIcons.camera, 
                      color: (cvehProvider.propertyCardphoto != null)
                      ? Colors.green
                      : Colors.black, 
                    ),
                  )

                ],

              ),

              SizedBox(height: size.height*0.02), 

              //fecha vencimiento de soat
              Row(

                children: [

                  Stack(

                    children: [

                      GestureDetector(

                        onTap: () async {
                          cvehProvider.soatExpirationDate = await showCalendarDatePicker2Dialog(
                            context: context,
                            config: CalendarDatePicker2WithActionButtonsConfig(
                              cancelButton: const Text('Cancelar'),
                              okButton: const Text('Aceptar'),
                              calendarType: CalendarDatePicker2Type.single
                            ),
                            dialogSize: const Size(325, 400),
                            initialValue: [],
                            borderRadius: BorderRadius.circular(15),
                          );
                        },

                        child: Container(
                          width:  size.width * .75,
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
                          child:  ( cvehProvider.soatExpirationDate  == null)
                            ?const  Text('Seleccione la fecha Venc. Soat')
                            : Text(DateFormat('EEEE, d MMMM yyyy', 'es').format(cvehProvider.soatExpirationDate!.first!)),
                        ),

                      ),

                      Positioned(
                        left: 20,
                        top: 2,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          color: const Color(0xffFAFAFA),
                          child: const  Text(
                            'Fecha de Venc. Soat',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),

                    ],
                  ),

                  //boton para tomar una foto

                  IconButton(
                    onPressed: ( cvehProvider.soatExpirationphoto != null )
                      ? () => showDialogPhoto(
                        context, 
                        cvehProvider.soatExpirationphoto!, 
                        'Foto del Soat',
                        (){
                          cvehProvider.soatExpirationphoto = null;
                          Navigator.pop(context);
                        }
                      )
                      : () async {

                        final ImagePicker picker = ImagePicker();

                        final  XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera,
                        );

                        if(pickedFile != null) cvehProvider.soatExpirationphoto = pickedFile; 

                      }, 
                    icon: FaIcon( 
                      FontAwesomeIcons.camera, 
                      color: (cvehProvider.soatExpirationphoto != null)
                      ? Colors.green
                      : Colors.black, 
                    ),
                  )

                ],

              ),
              SizedBox(height: size.height*0.02), 

              //fecha vencimiento de revision tecnica.
              Row(

                children: [

                  Stack(
                    children: [

                      GestureDetector(

                        onTap: () async {
                          cvehProvider.technicalDate = await showCalendarDatePicker2Dialog(
                            context: context,
                            config: CalendarDatePicker2WithActionButtonsConfig(
                              cancelButton: const Text('Cancelar'),
                              okButton: const Text('Aceptar'),
                              calendarType: CalendarDatePicker2Type.single
                            ),
                            dialogSize: const Size(325, 400),
                            initialValue: [],
                            borderRadius: BorderRadius.circular(15),
                          );
                        },

                        child: Container(
                          width:  size.width * .75,
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
                          child:  ( cvehProvider.technicalDate  == null)
                            ?const  Text('Seleccione la fecha Venc. Soat')
                            : Text(DateFormat('EEEE, d MMMM yyyy', 'es').format(cvehProvider.technicalDate!.first!)),
                        ),

                      ),

                      Positioned(
                        left: 20,
                        top: 2,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          color: const Color(0xffFAFAFA),
                          child: const  Text(
                            'Revision Tecnica',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),

                    ],
                  ),

                  IconButton(
                    onPressed: ( cvehProvider.technicalDatephoto != null )
                      ? () => showDialogPhoto(
                        context, 
                        cvehProvider.technicalDatephoto!, 
                        'Foto de la Revision Tecnica',
                        (){
                          cvehProvider.technicalDatephoto = null;
                          Navigator.pop(context);
                        }
                      )
                      : () async {
                        final ImagePicker picker = ImagePicker();
                        final  XFile? pickedFile = await picker.pickImage( source: ImageSource.camera);
                        if(pickedFile != null) cvehProvider.technicalDatephoto = pickedFile; 
                      },

                    icon: FaIcon( 
                      FontAwesomeIcons.camera, 
                      color: (cvehProvider.technicalDatephoto != null)
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
                  onPressed: ( cvehProvider.isLoading == false )
                    ? () async {

                    final vehicleProvider  = Provider.of<CreateVehicleProvider>(context, listen: false);
                    final gProvider        = Provider.of<GlobalProvider>(context, listen: false);
                    final authProvider     = Provider.of<PersonAuthProvider>(context, listen: false);
                    cvehProvider.isLoading = true;

                    final CreateVehicleBody vehicleBody =  CreateVehicleBody(
                      placaVehiculoTracto: vehicleProvider.placaController.text,
                      codigoTipoCarga: int.parse(vehicleProvider.selectedCargaType.codigo!),
                      codigoClienteControl: gProvider.relationModel.codigoCliente,
                      codigoTipoVehiculo: vehicleProvider.selectedVehicleType.codeVehicleType,
                      tarjetaPropiedad: vehicleProvider.propertyCardControlller.text,
                      fSoat: vehicleProvider.soatExpirationDate?.first,
                      fRevision: vehicleProvider.technicalDate?.first,
                      creadoPor:  (authProvider.credentialAuth.documento == null) ? "CARGO_${authProvider.personauth.dni}"  :"CARGO_${authProvider.credentialAuth.documento}",
                      codigoEmpresa: vehicleProvider.selectedEnterprise.codigo
                    );

                    final resp = await VehicleService.createVehicle(vehicleBody);

                    cvehProvider.isLoading = false;

                    if( resp?.estado == 2) return showSnackBarAwesome(  context, 'Error', 'La placa ya se tiene registrado', ContentType.warning );
                    if( resp?.estado == 3) return showSnackBarAwesome(  context, 'Error', 'La placa ya esta registrada, pero esta deshabilitada', ContentType.warning );

                    if( resp?.estado == 1){

                      if( vehicleProvider.foto != null )  await PhotoVehicleService.uploadImageVehicle(context, vehicleProvider.foto!.path, 1, resp!.codigoVehiculo!);
                      if( vehicleProvider.propertyCardphoto != null ) await PhotoVehicleService.uploadImageVehicle(context, vehicleProvider.propertyCardphoto!.path, 2, resp!.codigoVehiculo!);
                      if( vehicleProvider.soatExpirationphoto != null )await PhotoVehicleService.uploadImageVehicle(context, vehicleProvider.soatExpirationphoto!.path, 3, resp!.codigoVehiculo!);
                      if( vehicleProvider.technicalDatephoto != null ) await PhotoVehicleService.uploadImageVehicle(context, vehicleProvider.technicalDatephoto!.path, 4, resp!.codigoVehiculo!);

                      showSnackBarAwesome( context, 'EXITO', 'Se registró el vehiculo de placa ${cvehProvider.placaController.text} con exito', ContentType.success );

                      Navigator.of(context).pop();

                    }

                  }
                  : null,
                  child: ( cvehProvider.isLoading == false)
                    ? const Text(
                        "Registrar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      )
                    : const Center(child: CircularProgressIndicator( color: Colors.white ))
                ),
              )

            ],
          ),
        ),
      ),
    );

  }
}