import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/core/theme/theme_cargo.dart';

class HomeHeaderCargo extends StatelessWidget {

  const HomeHeaderCargo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: size.height * 0.25,
      // color: Colors.red,

      child: SafeArea(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            //ALL: VERSION DEL CARGO DEBE SER DINAMICO
            Text('Cargo v2.1', style: AppThemeCargo.lighThemeCargo.textTheme.displayLarge ),

            SizedBox(height: size.height*0.05),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Bienvenido a:', style: AppThemeCargo.lighThemeCargo.textTheme.displaySmall?.copyWith(color: Colors.amber)),
            ),

            SizedBox(height: size.height*0.02),

          ],
      
        ),

      ),

    );

  }

}