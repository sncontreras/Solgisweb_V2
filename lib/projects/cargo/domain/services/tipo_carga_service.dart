import 'package:solgis/projects/cargo/data/models/tipos_carga_model.dart';

abstract class ICargaTypeService{

  Future<List<TipoCargaModel>> getTipoCarga ( {String codCliente} );

} 