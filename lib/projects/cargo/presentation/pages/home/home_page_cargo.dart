import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/presentation/pages/home/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/widgets/widgets.dart';

class HomePageCargo extends StatelessWidget {

  const HomePageCargo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(

      body: SizedBox.expand(
        child: Stack(

          children:  [

            const HomePageBackGroundCargo(),

            const InformacionClienteCargo(),

            Positioned(
              bottom: 0,
              child: BottomMenuCargo(
                padding: EdgeInsets.symmetric(vertical:size.height*0.035),
                child: const MenuCargo(),
              )
            ),

          ],
        ),
      ),
    );
  }
}