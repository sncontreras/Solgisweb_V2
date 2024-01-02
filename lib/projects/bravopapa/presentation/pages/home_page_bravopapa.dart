import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solgis/projects/bravopapa/presentation/pages/home/panic_button.dart';
import 'package:solgis/projects/bravopapa/presentation/widgets/button_menu_bravopapa.dart';
import 'package:solgis/projects/bravopapa/theme/theme_bravo_papa.dart';
import 'package:solgis/projects/people/presentation/widgets/widgets.dart';

class HomePageBravoPapa extends StatelessWidget {
  const HomePageBravoPapa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //47269389

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const HomePageBackGroundPeople(),
            const _HomeHeaderPeople(),
            const InformacionClientePeopleWidget(),
            const PanicButtonWidget(),
            Positioned(
                bottom: 0,
                //aqui debe tener el container que se expande con sus hijos.
                child: FondoMenuPeople(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.035),
                  child: const _IconMenuPeople(),
                )),
          ],
        ),
      ),
    );
  }
}

class _HomeHeaderPeople extends StatelessWidget {
  const _HomeHeaderPeople({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 200,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bravo Papa v2.0',
                style: AppThemeBravoPapa
                    .lighThemeBravoPapa.textTheme.displayLarge),
            SizedBox(height: size.height * 0.05),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Bienvenido a:',
                  style: AppThemeBravoPapa
                      .lighThemeBravoPapa.textTheme.displaySmall
                      ?.copyWith(color: Colors.amber)),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class _IconMenuPeople extends StatelessWidget {
  const _IconMenuPeople({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //REGISTRAR
        ButtonMenuBravoPapa(
          icon: FontAwesomeIcons.house,
          text: 'Home',
          onpressed: () =>
              Navigator.pushNamed(context, '/home'),
        ),

      /* SizedBox(width: size.width * 0.08),

        //REGISTRAR POR DISPOSITIVO SCANNER
        ButtonMenuPeople(
          icon: Icons.qr_code_scanner_outlined,
          text: 'Fotocontrol',
          onpressed: () =>
              Navigator.pushNamed(context, 'register_movimiento_gun_people'),
        ),

        SizedBox(width: size.width * 0.08),*/
 /*
        //MOVIMIENTOS
        ButtonMenuPeople(
          icon: FontAwesomeIcons.peopleGroup,
          text: 'Movimientos',
          onpressed: () =>
              Navigator.pushNamed(context, 'movimientos_page_people'),
        ),

        SizedBox(width: size.width * 0.08),

        //CONSULTAR
        ButtonMenuPeople(
          icon: FontAwesomeIcons.magnifyingGlass,
          text: 'Consultar',
          onpressed: () =>
              Navigator.pushNamed(context, 'consulta_home_page_people'),
        ),*/
      ],
    );
  }
}
