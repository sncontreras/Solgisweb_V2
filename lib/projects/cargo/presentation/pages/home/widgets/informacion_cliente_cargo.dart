import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/core/theme/theme_cargo.dart';

class InformacionClienteCargo extends StatelessWidget {
  const InformacionClienteCargo({super.key});


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final loginGlobal = Provider.of<GlobalProvider>(context).relationModel;

    return Container(

      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),

      child: SafeArea(

        child: Column(

          children: [

            Text('Cargo v2.1', style: AppThemeCargo.lighThemeCargo.textTheme.displayLarge ),

            SizedBox(height: size.height*0.05),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Bienvenido a:', style: AppThemeCargo.lighThemeCargo.textTheme.displaySmall?.copyWith(color: Colors.amber)),
            ),

            FadeInImage(
              width: size.width*0.48,
              height: size.width*0.48,
              placeholder:  const AssetImage('assets/gifs/loading.gif'), 
              image: AssetImage("assets/pngs/${loginGlobal.nombreCliente}.png")
            ),

            SizedBox(height: size.height*0.015),

            Text(
              (loginGlobal.codigoTipoServicio == 1000)? 'Planta' : 'Flota',
              style: AppThemeCargo.lighThemeCargo.textTheme.displayLarge
            ),

            SizedBox(height: size.height*0.015),

            Text(
                loginGlobal.nombreSubArea!.split(' ')
                  .map((word) {
                    if (word == '') return '';
                    return word[0] + word.substring(1).toLowerCase();
                  })
                  .join(' '),
              style: AppThemeCargo.lighThemeCargo.textTheme.displaySmall?.copyWith(  
                color: Colors.amber
              )
            ),

            SizedBox(height: size.height*0.015),

            Text(
              loginGlobal.codigoServicio.toString(),
              style: AppThemeCargo.lighThemeCargo.textTheme.displayLarge 
            ),//CODIGO DEL SERVICIO - dinamico

          ],

        ),

      ),

    );

  }

}