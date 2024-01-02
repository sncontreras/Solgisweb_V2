import 'package:flutter/material.dart';

class AppThemeCargo{

  static final ThemeData lighThemeCargo = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // textTheme: GoogleFonts.montserratTextTheme(),
    useMaterial3:true,

    primaryColor: const Color(0xff031C36),

    //TIENE COLOR
    appBarTheme:  const AppBarTheme(
      backgroundColor: Color.fromARGB(249, 0, 2, 124),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
      centerTitle: true,
    ),

    //TIENE COLOR
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(Colors.white)
    ),

    // ESTILOS DE LOS TEXTOS
    textTheme: const TextTheme(
      
      displayLarge: TextStyle( 
        color: Colors.white,
        fontSize: 25
      ),

      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 22
      ),

      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 17
      ),

      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 14
      )
    
    ),
    
    //ESTILOS DE LOS ICONOS
    primaryIconTheme: const  IconThemeData(
      color: Colors.white,
      size: 30
    ),

    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 30
    ),

  );

}
