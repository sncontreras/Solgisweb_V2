import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/access_area_service.dart';
import 'package:solgis/core/data/services/authority_service.dart';
import 'package:solgis/core/data/services/reason_service.dart';
import 'package:solgis/core/domain/entities/reason.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/core/domain/models/area_model.dart';
import 'package:solgis/core/domain/models/authority.dart';
import 'package:solgis/core/domain/models/reason_model.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/global/constants.dart';
import 'package:solgis/core/helpers/pattern_string.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/projects/cargo/core/utils/dropdown_decoration.dart';
import 'package:solgis/projects/cargo/data/models/parking_model.dart';
import 'package:solgis/projects/cargo/data/services/parking_service.dart';
import 'package:solgis/projects/cargo/domain/entities/access_area.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';
import 'package:solgis/projects/cargo/presentation/widgets/widgets.dart';

class DocumentInformation extends StatelessWidget {

  const DocumentInformation({
    Key? key, 
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size            = MediaQuery.of(context).size;
    final configProvider  = Provider.of<ConfigProvider>(context);
    final entryProvider   = Provider.of<IngresoAutorizadoProvider>(context);
    final gProvider       = Provider.of<GlobalProvider>(context);
    final driverProvider  = Provider.of<DriverProvider>(context);
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final driver          = driverProvider.driverResponse;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0),

      child: SingleChildScrollView(
        child: Column(

          children: [

            //FILA DE LOS DATOS DEL CONDUCTOR.
            Row(
              children: [

                //NOMBRE, CARGO, EMPRESA
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(StringHelper.patternString(driver!.persNombres), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 2),
                    AutoSizeText(StringHelper.patternString(driver.persCargo) ,style: const TextStyle( fontSize: 14), maxLines: 2),
                    AutoSizeText(StringHelper.patternString(driver.persEmpresa), style: const TextStyle(fontWeight: FontWeight.w900), maxLines: 2),
                  ],
                ),

                const Spacer(),

                //FOTO
                FutureBuilder(
                  future: getImage(driver.img),
                  builder: (context, AsyncSnapshot<Widget> snapshot) {

                    if(!snapshot.hasData){
                      return Container(
                        width: size.width * .27,
                        height: size.height * .12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/gifs/loader-gris.gif'),
                          ),
                        )
                      );
                    }

                    return Container(
                      width: size.width* .27,
                      height: size.height* .12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: snapshot.data,
                      ),
                    );

                  }
                ),

              ],
            ),

            SizedBox(height: size.height * .02),

            //Autorizante
            ( driver.codAutoriX != 0 && driver.codAutoriX != -1 && driver.codAutoriX != null )
              ? DropDownCustom(

                text: "AUTORIZANTE:",

                child: DropdownButtonFormField<Authority>(

                  items: [
                    DropdownMenuItem<Authority>(
                      value: Authority(
                        codPersonal: driver.codAutoriX.toString(),
                        nombrePersonal: driver.persAutoriPor,
                      ),
                      child: Text(StringHelper.patternString(driver.persAutoriPor))
                    ),
                  ],

                  // onChanged: ( value ) => entryProvider.selectedAutorizante = value!,
                  onChanged: null,
                  hint: const Text("Seleccione el autorizante", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                  style: const TextStyle(color:Colors.black, fontSize: 13),
                  decoration: inputDecorationDropDown(),
                  isExpanded: true,
                  value: Authority(codPersonal: driver.codAutoriX.toString(), nombrePersonal: driver.persAutoriPor )
                ),
              )
              : FutureBuilder(

                future: AuthorityService.getAutorizantes(gProvider.relationModel.codigoServicio.toString(), driver.codPersTipo.toString()),

                builder: ( _ , AsyncSnapshot<List<Authority>> snapshot ) {

                  if( !snapshot.hasData ){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ShimmerWidget(
                        width:  size.width,
                        height: size.height * .08,
                      ),
                    );
                  }

                  if(snapshot.data!.isEmpty) return Container();
                  final autorizantes = snapshot.data;

                  //Si llega solamente un autorizante
                  if( autorizantes!.length == 1){
                    entryProvider.selectedAutorizanteSinRefresh = autorizantes.first;

                    return DropDownCustom(
                      text: "AUTORIZANTE:",

                      child: DropdownButtonFormField<Authority>(

                        items: [

                          DropdownMenuItem<Authority>(
                            value: Authority(
                              codPersonal: autorizantes.first.codPersonal,
                              codigo: autorizantes.first.codigo,
                              dniPersonal: autorizantes.first.dniPersonal,
                              nombrePersonal: autorizantes.first.nombrePersonal
                            ),
                            child: Text(StringHelper.patternString(autorizantes.first.nombrePersonal))
                          )

                        ],

                        // onChanged: ( value ) => entryProvider.selectedAutorizante = value!,
                        onChanged: null,

                        hint: const Text("Seleccione el autorizante", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                        style:  const TextStyle(color:Colors.black, fontSize: 13),
                        decoration: inputDecorationDropDown(),
                        isExpanded: true,
                        value: Authority(
                          codPersonal: autorizantes.first.codPersonal,
                          codigo: autorizantes.first.codigo,
                          dniPersonal: autorizantes.first.dniPersonal,
                          nombrePersonal: autorizantes.first.nombrePersonal
                        ),
                      ),
                    );
                  }

                  return DropDownCustom(
                    text: "AUTORIZANTE:",
                    child: DropdownButtonFormField<Authority>(
                      items: autorizantes.map(
                        (auto) => DropdownMenuItem<Authority>(
                          value: auto,
                          child: Text(StringHelper.patternString(auto.nombrePersonal))
                        )
                      ).toList(),
                      onChanged: ( value ) => entryProvider.selectedAutorizante = value!,
                      hint: const Text("Seleccione el autorizante", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      style:  const TextStyle(color:Colors.black, fontSize: 13),
                      decoration: inputDecorationDropDown(),
                      isExpanded: true,
                      value: ( entryProvider.selectedAutorizante.codigo != null )
                        ? entryProvider.selectedAutorizante
                        : null
                    ),
                  );

                },

              ),
            SizedBox(height: size.height * .02),

            //Motivo
            ( driver.copMotivo != -1 && driver.copMotivo != null && driver.persMotivo == "LABORES" )
              ? DropDownCustom(
                text: "MOTIVO: ",
                child: DropdownButtonFormField<Reason>(
                  items: [

                    DropdownMenuItem<Reason>(
                      value: Reason(
                        codigo: driver.copMotivo.toString(),
                        tipo: driver.persMotivo
                      ),
                      child: Text(StringHelper.patternString(driver.persMotivo))
                    )

                  ],
                  // onChanged: ( value ) => entryProvider.selectedReason = value!,
                  onChanged: null,
                  hint: const Text("Seleccione el motivo", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                  style:  const TextStyle(color:Colors.black, fontSize: 13),
                  decoration: inputDecorationDropDown(),
                  isExpanded: true,
                  value: Reason(
                    codigo: driver.copMotivo.toString(),
                    tipo:  driver.persMotivo
                  )
                ),
              )

              : FutureBuilder(

                future: ReasonService.getReasons(gProvider.relationModel.codigoServicio.toString(),  gProvider.relationModel.codigoCliente.toString()),

                builder: ( _ , AsyncSnapshot<List<ReasonModel>> snapshot ) {

                  if( !snapshot.hasData ){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ShimmerWidget(
                        width:  size.width,
                        height: size.height * .08,
                      ),
                    );
                  }

                  if(snapshot.data!.isEmpty) return Container();
                  final motivos = snapshot.data;

                  //Si llega solamente un motivo
                  if( motivos!.length == 1){
                    entryProvider.selectedReasonSinRefresh = motivos.first;

                    return DropDownCustom(
                      text: "MOTIVO: ",

                      child: DropdownButtonFormField<Reason>(

                        items: [

                          DropdownMenuItem<Reason>(
                            value: Reason(
                              codigo: motivos.first.codigo,
                              tipo: motivos.first.tipo,
                            ),
                            child: Text(StringHelper.patternString(motivos.first.tipo))
                          )

                        ],

                        // onChanged: ( value ) => entryProvider.selectedReason = value!,
                        onChanged: null,
                        hint: const Text("Seleccione el motivo", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                        style:  const TextStyle(color:Colors.black, fontSize: 13),
                        decoration: inputDecorationDropDown(),
                        isExpanded: true,
                        value: Reason(
                          codigo: motivos.first.codigo,
                          tipo:  motivos.first.tipo,
                        ),
                      ),
                    );

                  }

                  return DropDownCustom(
                    text: "MOTIVO: ",
                    child: DropdownButtonFormField<Reason>(
                      items: motivos.map(
                        (reason) => DropdownMenuItem<Reason>(
                          value: reason,
                          child: Text(StringHelper.patternString(reason.tipo))
                        )
                      ).toList(),
                      onChanged: ( value ) => entryProvider.selectedReason = value!,
                      hint: const Text("Seleccione el motivo", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      style:  const TextStyle(color:Colors.black, fontSize: 13),
                      decoration: inputDecorationDropDown(),
                      isExpanded: true,
                      value: ( entryProvider.selectedReason.codigo != null )
                        ? entryProvider.selectedReason
                        : null
                    ),
                  );

                },

              ),

            SizedBox(height: size.height * .02),

            //Area
            ( driver.codArea != -1 && driver.codArea != null )
              ? DropDownCustom(
                  text: "AREA: ",
                  child: DropdownButtonFormField<AccessArea>(
                    items: [
                      DropdownMenuItem<AccessArea>(
                        value: AccessArea(
                          codigo: driver.codArea.toString(),
                          area: driver.persArea
                        ),
                        child: Text(StringHelper.patternString(driver.persArea))
                      )
                    ],
                    // onChanged: ( value ) => entryProvider.selectedAccessArea = value!,
                    onChanged: null,

                    hint: const Text("Seleccione el area", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    style:  const TextStyle(color:Colors.black, fontSize: 13),
                    decoration: inputDecorationDropDown(),
                    isExpanded: true,
                    value: AccessArea(
                      codigo: driver.codArea.toString(),
                      area: driver.persArea,
                    )
                  ),
                )

              : FutureBuilder(

                future: AccessAreaService.getAreas(gProvider.relationModel.codigoServicio.toString(),gProvider.relationModel.codigoCliente.toString() ),

                builder: ( _ , AsyncSnapshot<List<AreaModel>> snapshot ) {

                  if( !snapshot.hasData ){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ShimmerWidget(
                        width:  size.width,
                        height: size.height * .08,
                      ),
                    );
                  }

                  if(snapshot.data!.isEmpty) return Container();
                  final areas = snapshot.data;

                  //Si llega solamente un motivo
                  if( areas!.length == 1){
                    entryProvider.selectedAccessAreaSinRefresh = areas.first;

                    return DropDownCustom(
                      text: "AREA: ",

                      child: DropdownButtonFormField<AccessArea>(

                        items: [

                          DropdownMenuItem<AccessArea>(
                            value: AccessArea(
                              codigo: areas.first.codigo,
                              area: areas.first.area
                            ),
                            child: Text(StringHelper.patternString(areas.first.area))
                          )

                        ],

                        // onChanged: ( value ) => entryProvider.selectedAccessArea = value!,
                        onChanged: null,

                        hint: const Text("Seleccione el area", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                        style:  const TextStyle(color:Colors.black, fontSize: 13),
                        decoration: inputDecorationDropDown(),
                        isExpanded: true,
                        value: AccessArea(
                          codigo: areas.first.codigo,
                          area: areas.first.area
                        ),
                      ),
                    );
                  }

                  return DropDownCustom(
                    text: "AREA: ",
                    child: DropdownButtonFormField<AccessArea>(
                      items: areas.map(
                        (area) => DropdownMenuItem<AccessArea>(
                          value: area,
                          child: Text(StringHelper.patternString(area.area))
                        )
                      ).toList(),
                      onChanged: ( value ) => entryProvider.selectedAccessArea = value!,
                      hint: const Text("Seleccione el area", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      style:  const TextStyle(color:Colors.black, fontSize: 13),
                      decoration: inputDecorationDropDown(),
                      isExpanded: true,
                      value: ( entryProvider.selectedAccessArea.codigo != null )
                        ? entryProvider.selectedAccessArea
                        : null
                    ),
                  );

                },

              ),

            SizedBox( height: size.height * .05 ),

            if( configProvider.configuration?.alcoholimetro!.hasfoto  != null ) 
              AlcoholimetroWidget( alcoholimetro: configProvider.configuration!.alcoholimetro! ),


            if( configProvider.configuration!.epps!.isNotEmpty  ) 
              EppsWidget( epps: configProvider.configuration?.epps?? [] ),

            if( gProvider.relationModel.codigoCliente == customers['yobel'] )
              const SizedBox(height: 25),

            if( gProvider.relationModel.codigoCliente == customers['yobel'] )
              FutureBuilder(
                future: ParkingService.getParkingForYobel(vehicleProvider.vehicleResponse!.nroPlaca!, gProvider.relationModel.codigoServicio.toString(), gProvider.relationModel.codigoCliente!, driver.codPers.toString() ),
                builder: (BuildContext context, AsyncSnapshot<List<ParkingModel>> snapshot) {

                  if( !snapshot.hasData ){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ShimmerWidget(
                        width:  size.width,
                        height: size.height * .08,
                      ),
                    );
                  }

                  if(snapshot.data!.isEmpty) return Container();

                  final parqueos = snapshot.data;

                  if(parqueos == null ) return Container();

                  if( parqueos.length == 1){
                    entryProvider.parkingsinRefresh = parqueos[0].codParqueo!;
                    entryProvider.parkingModelSinRefresh = parqueos[0];
                    
                    return DropDownCustom(
                      text: "PARQUEO:",
                      child: DropdownButtonFormField<int>(
                        items: [
                          DropdownMenuItem<int>(
                            value: parqueos.first.codParqueo,
                            child: Text("${parqueos.first.nameParqueo}"),
                          )
                        ],
                        onChanged: null,
                        hint: const Text("Seleccione el parqueo", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                        style:  const TextStyle(color:Colors.black, fontSize: 13),
                        decoration: inputDecorationDropDown(),
                        isExpanded: true,
                        value: parqueos.first.codParqueo
                      ),
                    );
                  }

                  List<DropdownMenuItem<int>> dropdownparking = [];

                  for(final parking in parqueos){
                    final DropdownMenuItem<int> parkingTemp = DropdownMenuItem(
                      value: parking.codParqueo , 
                      child: Text("${parking.nameParqueo}")
                    );
                    dropdownparking.add(parkingTemp);
                  } 

                  return DropDownCustom(
                    text: "Parqueos:",
                    child: DropdownButtonFormField<int>(
                      items: dropdownparking,
                      onChanged: ( value ) {
                        entryProvider.parking = value!;
                        ParkingModel parqueoSelected = parqueos.firstWhere(( parqueo ) => parqueo.codParqueo == value);
                        entryProvider.parkingModel = parqueoSelected;
                      },
                      hint: const Text("Seleccione el parqueo", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      style:  const TextStyle(color:Colors.black, fontSize: 13),
                      decoration: inputDecorationDropDown(),
                      isExpanded: true,
                    ),
                  );

                },

              )

          ],
        ),
      ),
    );

  }
}