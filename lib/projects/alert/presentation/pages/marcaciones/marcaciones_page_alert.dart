import 'package:flutter/material.dart';

class MarcacionesPageAlert extends StatelessWidget {
  const MarcacionesPageAlert({super.key});

  @override
  Widget build(BuildContext context) {

    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final viewBotton  = MediaQuery.of(context).viewInsets.bottom;

    return const Scaffold(
      body: Center(
        child: Text("MarcacionesPage"),
      ) ,
    );

  }
}