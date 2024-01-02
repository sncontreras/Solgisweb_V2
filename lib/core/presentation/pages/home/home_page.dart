import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_sheet_custom.dart';
import 'package:solgis/core/domain/models/project_model_qa.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/project_provider.dart';
import 'package:solgis/core/presentation/pages/home/widgets/card_app.dart';
import 'package:solgis/core/presentation/widgets/drawer_widget.dart';
// import 'package:solgis/core/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ProjectProvider()))
      ],
      child: const HomePageState(),
    );
  }
}

class HomePageState extends StatelessWidget {
  const HomePageState({super.key});

  @override
  Widget build(BuildContext context) {
    final gProvider = Provider.of<GlobalProvider>(context);

    return Scaffold(
      //backgroundColor: AppThemeGeneral.lighTheme.colorScheme.background,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Solgis v2', style: TextStyle()),
        centerTitle: true,
        actions: [
          if (gProvider.relationModel.codigoPerfil == 4)
            IconButton(
              icon: const Icon(Icons.compare_arrows),
              onPressed: () {
                showSheetCustom(context, 'Seleccione el Cliente');
              },
            ),
        ],
      ),
      //body: const HomePageBody(),
      // bottomNavigationBar: const VolumeControlWidget(),
      body: const Stack(
        children: [
          HomePageBody(), // Mantiene el cuerpo principal
          /*Positioned(
            right: 0, // Ajusta la posición del control de volumen como desees
            bottom: 0,
            child: VolumeControlWidget(), // Agrega el widget de control de volumen
          ),*/
        ],
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gProvider = Provider.of<GlobalProvider>(context);
    final pProvider = Provider.of<ProjectProvider>(context);

    return FutureBuilder(
      future: pProvider.getAppsAllowed(gProvider.relationModel.grupoUsuarioId!),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final data = snapshot.data;

        return GridView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          itemCount: data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: size.width * 0.01,
              mainAxisSpacing: size.height * 0.01,
              crossAxisCount: 2,
              mainAxisExtent: size.height * 0.3),
          itemBuilder: (context, index) => CardApp(project: data[index]),
        );
      },
    );
  }
}
