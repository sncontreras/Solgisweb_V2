import 'package:solgis/projects/cargo/domain/entities/movement.dart';

abstract class IRemoteDataSource{

  Future<List<Movement>> getMovements(String codTipoCarga, String codServicio, String tipoConsulta);

}