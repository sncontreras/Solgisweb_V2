import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/core/domain/helpers/sign_out.dart';
import 'package:solgis/core/domain/helpers/text_style_drawer.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/home_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/presentation/widgets/widgets.dart';
import 'package:solgis/core/theme/theme.dart';


class DrawerWidget extends StatelessWidget {
  
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size            = MediaQuery.of(context).size;
    final personAuth      = Provider.of<PersonAuthProvider>(context);
    final serviceProvider = Provider.of<GlobalProvider>(context).relationModel;
    final homeProvider    = Provider.of<HomeProvider>(context);

    final person = personAuth.personauth;

    return ClipRRect(

      borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),

      child: Drawer(
        width: size.width*0.6,
        backgroundColor: AppThemeGeneral.lighTheme.colorScheme.background,
        child: Stack(
          children: [

            const BackgroundDrawer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: size.height*0.03),

                // FOTO
                FutureBuilder(

                  future: 
                    (serviceProvider.codigoPerfil == 1 || serviceProvider.codigoPerfil == 2) 
                      ? getImage('http://190.116.178.163//Biblioteca_Grafica//Fotos//${personAuth.personauth.codigoPersonal}.jpg') 
                      : getImage('http://190.116.178.163//Biblioteca_Grafica//Fotos//${personAuth.personAuth.codigoPersonal}.jpg'),

                  builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){

                    if(!snapshot.hasData){
                      return Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: size.width*0.33,
                            height: size.width*0.33,
                            child: const Image(
                              image: AssetImage('assets/gifs/loader.gif'),
                            ),
                          ),
                        ),
                      );
                    }

                    return Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: size.width*0.33,
                          height: size.width*0.33,
                          child: snapshot.data,
                        ),
                      ),
                    );

                  }

                ),

                SizedBox(height: size.height*0.03),

                Center(
                  child: AutoSizeText(
                    ( serviceProvider.codigoPerfil == 1 || serviceProvider.codigoPerfil == 2 )
                      ? "${(person.pNombre != null && person.pNombre != '' ) ? '${person.pNombre![0].toUpperCase()}${person.pNombre!.substring(1).toLowerCase()}' :''} ${(person.pApellido != null && person.pApellido != '' ) ? person.pApellido :''} ${(person.sApellido != null && person.sApellido != '' ) ? '${person.sApellido![0].toUpperCase()}${person.sApellido!.substring(1).toLowerCase()}' :''}"

                      :personAuth.credentialauth.nombres != '' || personAuth.credentialauth.apellidos != ''
                        ?' ${personAuth.credentialauth.nombres![0].toUpperCase()}${personAuth.credentialauth.nombres!.substring(1).toLowerCase()} ${personAuth.credentialauth.apellidos} '
                        : '',
                    style: letrasEstilo(), 
                    maxLines: 1
                  )
                ),

                Center(
                  child: AutoSizeText(
                    (serviceProvider.codigoPerfil == 1 || serviceProvider.codigoPerfil == 2)
                    ? personAuth.personauth.dni!
                    : personAuth.credentialAuth.documento!,
                    style: letrasEstilo(), maxLines: 1
                  )
                ),

                SizedBox(height: size.height*0.03),

                Center(
                  child: AutoSizeText(
                    serviceProvider.nombreCliente != ''
                      ? '${serviceProvider.nombreCliente![0].toUpperCase()}${serviceProvider.nombreCliente!.substring(1).toLowerCase()}'
                      : '',
                    // '${serviceProvider.nombreCliente[0].toUpperCase()}${serviceProvider.nombreCliente.substring(1).toLowerCase()}', 
                    style: letrasEstilo().copyWith(
                      fontWeight: FontWeight.bold
                    ), 
                    maxLines: 1
                  )
                ),

                Center(
                  child: AutoSizeText(
                    serviceProvider.nombreSucursal != ''
                      ? '${serviceProvider.nombreSucursal![0].toUpperCase()}${serviceProvider.nombreSucursal!.substring(1).toLowerCase()}'
                      :  '',
                    // '${serviceProvider.nombreSucursal[0].toUpperCase()}${serviceProvider.nombreSucursal.substring(1).toLowerCase()}', 
                    style: letrasEstilo().copyWith(
                      fontWeight: FontWeight.bold
                    ), 
                    maxLines: 1
                  )
                ),

                Center(
                  child: AutoSizeText(
                    (serviceProvider.codigoPerfil == 1)
                      ? 'Perfil: Agente'
                      : (serviceProvider.codigoPerfil == 2)
                        ? 'Perfil: Supervisor'
                        : (serviceProvider.codigoPerfil == 3)
                          ? 'Perfil: Cliente'
                          : 'Perfil: Admin',
                    style: letrasEstilo().copyWith(
                      fontWeight: FontWeight.bold
                    ), 
                    maxLines: 1
                  )
                ),

                Center(
                  child: AutoSizeText(
                    serviceProvider.nombrePuesto != ''
                      ? 'Puesto: ${serviceProvider.nombrePuesto![0].toUpperCase()}${serviceProvider.nombrePuesto!.substring(1).toLowerCase()}'
                      : '',
                    style: letrasEstilo().copyWith(
                      fontWeight: FontWeight.bold
                    ), 
                    maxLines: 1
                  )
                ),

                SizedBox(height: size.height*0.06),

                Container(
                  width:size.width*0.55,
                  height: size.height*0.045,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: const ItemWidget(
                    text: 'Apps',
                    icon: FaIcon(FontAwesomeIcons.googlePlay, color: Colors.lightBlueAccent,),
                    color: Colors.lightBlueAccent,
                  ),
                ),

                SizedBox(height: size.height*0.4),  

                GestureDetector(
                  onTap: ()async{

                    await signOut(context);

                  },
                  child: Center(
                    child: Container(
                      width:size.width*0.4,
                      height: size.height*0.05,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: (homeProvider.isLoading)
                        ?  const SizedBox(height: 20, width: 20,  child: CircularProgressIndicator())
                        :  const ItemWidget(
                          text: 'Cerrar Sesion',
                          icon: FaIcon(
                            FontAwesomeIcons.rightFromBracket, 
                            color: Colors.lightBlueAccent, size: 15
                          ),
                          color: Colors.lightBlueAccent,
                        ),
                    ),
                  ),
                ),

              ],
            )
          ],
        )
      ),
    );
  }

}

class BackgroundDrawer extends StatelessWidget {
  const BackgroundDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff1A4A7A),
            Color.fromARGB(255, 29, 56, 82),
          ]
        )
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }
}
