import 'package:solgis/projects/cargo/domain/entities/movement.dart';

abstract class ILocalDataSource{

  Future<List<Movement>> getMovements( String codTipoCArga, String codServicio, String tipoConsulta );

}