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
import 'package:solgis/core/domain/models/authority_model.dart';
import 'package:solgis/core/domain/models/reason_model.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/global/constants.dart';
import 'package:solgis/core/helpers/pattern_string.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/projects/cargo/core/styles/style.dart';
import 'package:solgis/projects/cargo/core/utils/dropdown_decoration.dart';
import 'package:solgis/projects/cargo/data/models/asigned_parking_model.dart';
import 'package:solgis/projects/cargo/data/services/parking_service.dart';
import 'package:solgis/projects/cargo/domain/entities/access_area.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';
import 'package:solgis/projects/cargo/presentation/widgets/widgets.dart';

class DocumentoInformacion extends StatelessWidget {

  const DocumentoInformacion({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final driverProvider = Provider.of<DriverProvider>(context);
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);
    final driver = driverProvider.driverResponse;
    final vehicleProvider = Provider.of<VehicleProvider>(context); 
    final vehicle = vehicleProvider.vehicleResponse;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0),

      child: SingleChildScrollView(

        child: Column(

          children: [

            //Fila de los datos del conductor.
            Row(
              children: [

                //NOMBRE, CARGO, EMPRESA
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringHelper.patternString(driver!.persNombres), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), overflow: TextOverflow.ellipsis, maxLines: 1),
                      Text(StringHelper.patternString(driver.persCargo), overflow: TextOverflow.ellipsis, maxLines: 2),
                      AutoSizeText( StringHelper.patternString(driver.persEmpresa), style: const TextStyle(fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis, maxLines: 2),
                    ],
                  ),
                ),

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
                          nombrePersonal:  driver.persAutoriPor,
                        ),
                        child: Text(StringHelper.patternString(driver.persAutoriPor) )
                      ),
                    ],

                    // onChanged: ( value ) => outProvider.selectedAutorizante = value!,
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

              builder: ( _ , AsyncSnapshot<List<AuthorityModel>> snapshot ) {

                if( !snapshot.hasData ){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ShimmerWidget(
                      width: size.width,
                      height: size.height * .08,
                    ),
                  );
                }

                if(snapshot.data!.isEmpty) return Container();
                final autorizantes = snapshot.data;

                  //Si llega solamente un autorizante
                  if( autorizantes!.length == 1){
                    outProvider.selectedAutorizanteSinRefresh = autorizantes.first;

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
                            child: Text( StringHelper.patternString(autorizantes.first.nombrePersonal) )
                          )
                        ],

                        // onChanged: ( value ) => outProvider.selectedAutorizante = value!,
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

                final items = snapshot.data;

                return DropDownCustom(
                  text: "AUTORIZANTE:",

                  child: DropdownButtonFormField<Authority>(

                    items: items!.map(
                      (auto) => DropdownMenuItem<Authority>(
                        value: auto,
                        child: Text( StringHelper.patternString(auto.nombrePersonal) ) 
                      )
                    ).toList(),

                    onChanged: ( value ) => outProvider.selectedAutorizante = value!,
                    hint: const Text("Seleccione el autorizante", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    style:  const TextStyle(color:Colors.black, fontSize: 13),
                    decoration: inputDecorationDropDown(),
                    isExpanded: true,
                    value: ( outProvider.selectedAutorizante.codigo != null )
                      ? outProvider.selectedAutorizante
                      : null
                  ),
                );

              },

            ),

            SizedBox(height: size.height * .02),

            //Motivo
            ( driver.copMotivo != -1 && driver.copMotivo != null )
            ? DropDownCustom(
              text: "MOTIVO:",
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
                // onChanged: ( value ) => outProvider.selectedReason = value!,
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
                    outProvider.selectedReasonSinRefresh = motivos.first;

                    return DropDownCustom(
                      text: "MOTIVO:",

                      child: DropdownButtonFormField<Reason>(

                        items: [

                          DropdownMenuItem<Reason>(
                            value: Reason(
                              codigo: motivos.first.codigo,
                              tipo: motivos.first.tipo,
                            ),
                            child: Text( StringHelper.patternString( motivos.first.tipo ))
                          )

                        ],

                        // onChanged: ( value ) => outProvider.selectedReason = value!,
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
                  text: "MOTIVO:",
                  child: DropdownButtonFormField<Reason>(
                    items: motivos.map(
                      (reason) => DropdownMenuItem<Reason>(
                        value: reason,
                        child: Text(StringHelper.patternString(reason.tipo))
                      )
                    ).toList(),
                    onChanged: ( value ) => outProvider.selectedReason = value!,
                    hint: const Text("Seleccione el motivo", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    style:  const TextStyle(color:Colors.black, fontSize: 13),
                    decoration: inputDecorationDropDown(),
                    isExpanded: true,
                    value: ( outProvider.selectedReason.codigo != null )
                      ? outProvider.selectedReason
                      : null
                  ),
                );

              },

            ),

            SizedBox(height: size.height * .02),

           //Area
            ( driver.codArea != -1 && driver.codArea != null )
            ? DropDownCustom(
                text: "AREA:",
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
                  // onChanged: ( value ) => outProvider.selectedAccessArea = value!,
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
                    outProvider.selectedAccessAreaSinRefresh = areas.first;

                    return DropDownCustom(
                      text: "AREA:",

                      child: DropdownButtonFormField<AccessArea>(

                        items: [

                          DropdownMenuItem<AccessArea>(
                            value: AccessArea(
                              codigo: areas.first.codigo,
                              area: areas.first.area
                            ),
                            child: Text( StringHelper.patternString(areas.first.area) )
                          )

                        ],

                        // onChanged: ( value ) => outProvider.selectedAccessArea = value!,
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
                  text: "AREA:",
                  child: DropdownButtonFormField<AccessArea>(
                    items: areas.map(
                      (area) => DropdownMenuItem<AccessArea>(
                        value: area,
                        child: Text( StringHelper.patternString(area.area) )
                      )
                    ).toList(),
                    onChanged: ( value ) => outProvider.selectedAccessArea = value!,
                    hint: const Text("Seleccione el area", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    style:  const TextStyle(color:Colors.black, fontSize: 13),
                    decoration: inputDecorationDropDown(),
                    isExpanded: true,
                    value: ( outProvider.selectedAccessArea.codigo != null )
                      ? outProvider.selectedAccessArea
                      : null

                  ),
                );

              },

            ),

            if(gProvider.relationModel.codigoCliente == customers['yobel'] &&  driver.codPersTipo != 3 )
              SizedBox(height: size.height * .05),

            if(gProvider.relationModel.codigoCliente == customers['yobel'] && driver.codPersTipo != 3 )
              FutureBuilder(
                future: ParkingService.getAsignedParkingFromEntry( context, vehicle!.codigoVehiculo.toString(), gProvider.relationModel.codigoServicio.toString()  ),
                builder: (BuildContext context, AsyncSnapshot<AsignedParkingModel?> snapshot) {

                  if( !snapshot.hasData ){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ShimmerWidget(
                        width:  size.width,
                        height: size.height * .08,
                      ),
                    );
                  }

                  if( snapshot.data == null) return Container();

                  AsignedParkingModel parking = snapshot.data!;

                  return Row(
                    children: [
                      Text("PARQUEO: ", style: styleCrearPersonaltextForm()),
                      SizedBox(width: size.width * .1),
                      Text(parking.nameParqueo!, style: const  TextStyle(  fontWeight: FontWeight.bold)),
                    ],
                  );

                },

              )

          ],
        ),
      ),
    );

  }
}