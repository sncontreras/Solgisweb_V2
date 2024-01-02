import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/patrol/presentation/pages/registrar/registrar_fotos_page_patrol.dart';
import 'package:solgis/projects/patrol/presentation/pages/registrar/widgets/bien_selector_widget.dart';
import 'package:solgis/projects/patrol/presentation/pages/registrar/widgets/subbien_selector_widget.dart';
import 'package:solgis/projects/patrol/presentation/pages/registrar/widgets/tomar_fotos_widget.dart';
import 'package:solgis/projects/patrol/presentation/providers/tipo_fotos_provider.dart';

class RegistrarPageRaizPatrol extends StatefulWidget {
  const RegistrarPageRaizPatrol({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegistrarPageRaizPatrolState createState() =>
      _RegistrarPageRaizPatrolState();
}

class _RegistrarPageRaizPatrolState extends State<RegistrarPageRaizPatrol> {
  @override
  Widget build(BuildContext context) {
    return RegistrarFotosPagePatrol(
      titleIngreso: 'REGISTRAR FOTOS',
      colorAppBar: Colors.green,
      body: const _RegistrarFotosPagePatrolBody(),
    );
  }
}

class _RegistrarFotosPagePatrolBody extends StatefulWidget {
  const _RegistrarFotosPagePatrolBody({Key? key}) : super(key: key);

  @override
  __RegistrarFotosPagePatrolBodyState createState() =>
      __RegistrarFotosPagePatrolBodyState();
}

class __RegistrarFotosPagePatrolBodyState
    extends State<_RegistrarFotosPagePatrolBody> {
  List<Map<String, int>> perfiles = [];
  List<Map<String, int>> perfilesaux = [];
  int actualizacionRealizada = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          Text('FOTOS',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.035)),
          SizedBox(height: size.height * 0.01),
          const BienSelectorWidget(),
          SizedBox(height: size.height * 0.01),
          const SubBienSelectorWidget(),
          Consumer<TipoFotosProvider>(
            builder: (context, tipoFotosProvider, child) {
              return const TomarFotosWidget();
            },
          )
        ],
      ),
    );
  }
}




class SelectedWidget extends StatelessWidget {
  const SelectedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TomarFotosWidget();
  }
}
