import 'package:dartz/dartz.dart';

import 'package:solgis/core/errors/failure.dart';
import 'package:solgis/projects/cargo/domain/entities/movement.dart';

//Repository Interface for Movements
abstract class IMovementsRepository{

  Future<Either<Failure, List<Movement>>> getMovements( String codTipoCarga, String codServicio, String tipoConsulta );

}