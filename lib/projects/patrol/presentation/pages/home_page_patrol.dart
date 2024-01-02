import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solgis/projects/bravopapa/presentation/pages/home/panic_button.dart';
import 'package:solgis/projects/bravopapa/presentation/widgets/button_menu_bravopapa.dart';
import 'package:solgis/projects/bravopapa/theme/theme_bravo_papa.dart';
import 'package:solgis/projects/people/presentation/widgets/widgets.dart';

class HomePagePatrol extends StatelessWidget {
  const HomePagePatrol({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //47269389

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const HomePageBackGroundPeople(),
            const _HomeHeaderPatrol(),
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

class _HomeHeaderPatrol extends StatelessWidget {
  const _HomeHeaderPatrol({
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
            Text('Patrol v2.0',
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

class _IconMenuPeople extends StatefulWidget {
  const _IconMenuPeople({
    Key? key,
  }) : super(key: key);

  @override
  _IconMenuPeopleState createState() => _IconMenuPeopleState();
}

class _IconMenuPeopleState extends State<_IconMenuPeople> {
  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero).then((_) {
        final bienProvider = Provider.of<BienProvider>(context, listen: false);
        final registroProvider =
            Provider.of<RegistroProvider>(context, listen: false);
        bienProvider.initBienes(/*gProvider.relationmodel.codigoCliente!*/ '1');
        registroProvider.bienTemp = bienProvider.itemsBien[0].codigoBien!;
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //REGISTRAR
        ButtonMenuBravoPapa(
          icon: FontAwesomeIcons.photoFilm,
          text: 'Registrar',
          onpressed: () => Navigator.pushNamed(context, '/registrar'),
        ),
      ],
    );
  }
}
/*
class _IconMenuPeople extends StatelessWidget {
  const _IconMenuPeople({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //REGISTRAR
        ButtonMenuBravoPapa(
          icon: FontAwesomeIcons.photoFilm,
          text: 'Registrar',
          onpressed: () => Navigator.pushNamed(context, '/registrar'),
        ),
      ],
    );
  }
}
*/