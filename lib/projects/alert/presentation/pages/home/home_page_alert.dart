import 'package:flutter/material.dart';
import 'package:solgis/projects/alert/presentation/widgets/widgets.dart';

class HomePageAlert extends StatelessWidget {

  const HomePageAlert({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children:[
            const HomePageBackGroundAlert(),
            const InformacionClienteAlert(),
            Positioned(
              bottom: 0,
              child: BottomMenuAlert(
                padding: EdgeInsets.symmetric(vertical: size.height * .035),
                child: const MenuAlert(), 
              ),
            ),
          ],
        ),
      ),
    );

  }
}
