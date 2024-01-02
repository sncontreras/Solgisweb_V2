class ProjectsModel{

  List<ProjectModel> items = [];
  ProjectsModel();

  ProjectsModel.fromJsonList( List<dynamic> jsonList ){
    for( var item in jsonList ){
      final permiso = ProjectModel.fromJson(item);
      items.add(permiso);
    }
  }

}

class ProjectModel{

  ProjectModel({
    required this.codApp,
    required this.title,
    required this.description,
    required this.pathImage,
    required this.route,
    required this.versionApp,
  });

  late int codApp;
  late String title;
  late String description;
  late String pathImage;
  late String route;
  late String versionApp;

  ProjectModel.fromJson(Map<String, dynamic> json) {
    codApp      = json["id_app"];
    title       = json["nombre"];
    description = json["descripcion"];
    pathImage   = json["imagen"];
    route       = json["ruta"];
    versionApp  = json["versionApp"];
  }

}
