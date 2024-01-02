// import 'dart:async';
// import 'package:dartz/dartz.dart';

// import 'package:solgis/core/errors/exceptions.dart';
// import 'package:solgis/core/errors/failure.dart';
// import 'package:solgis/projects/cargo/data/datasource/movements/movements.dart';
// import 'package:solgis/projects/cargo/domain/entities/movimiento.dart';
// import 'package:solgis/projects/cargo/domain/repositories/abstract_movimientos.dart';


// class HttpMovementsRepository extends IMovementsRepository{

//   final MovementsHttpDataSource httpMovements;

//   HttpMovementsRepository(this.httpMovements);

//   @override
//   Future<Either<Failure, List<Movimiento>>> getMovements(String codTipoCarga, String codServicio, String tipoConsulta) async {

//     //TODO: implementacion de getMovements
//     try {
//       final movements = await httpMovements.requestMovements(codTipoCarga, codServicio, tipoConsulta);
//       return Right(movements);
//     } on ServerException {
//       return Left(
//         ServerFailure(
//         message: 'Ha ocurrido un error al obtener los datos del servidor'
//         ));
//     }

//   }

// }

