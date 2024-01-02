import 'package:flutter/material.dart';

class HomePageBackGroundPeople extends StatelessWidget {
  
  const HomePageBackGroundPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const Stack(

      children: [

        _ImageBackground(),
        _OpacityBackground(),

      ],

    );
    
  }

}

class _OpacityBackground extends StatelessWidget {
  const _OpacityBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Opacity(
      opacity: 0.7,
      child: Container(
        width: double.infinity,
        height: size.height*0.9,
        color: Colors.black,
      ),
    );
  }
  
}

class _ImageBackground extends StatelessWidget {
  const _ImageBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height*0.9,
      child: const Image(
        image: AssetImage('assets/jpgs/torre.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}
