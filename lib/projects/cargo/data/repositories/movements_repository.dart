import 'package:dartz/dartz.dart';
import 'package:solgis/core/errors/exceptions.dart';
import 'package:solgis/core/errors/failure.dart';
import 'package:solgis/projects/cargo/data/datasource/remote/remote_data_source.dart';
import 'package:solgis/projects/cargo/domain/entities/movement.dart';
import 'package:solgis/projects/cargo/domain/repositories/imovements_repository.dart';



class MovementsRepository implements IMovementsRepository{

  MovementsRepository({
    required IRemoteDataSource? remoteDataSource,

  }) : assert( remoteDataSource != null ),
        _remoteDataSource = remoteDataSource!;

  final IRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Movement>>> getMovements(String codTipoCarga, String codServicio, String tipoConsulta) async {

    try {

      final movements =  await _remoteDataSource.getMovements(codTipoCarga, codServicio, tipoConsulta);
      return Right(movements);

    } on ServerException{
      return const Left(ServerFailure(message: "No se pudo obtener la informacion por fallas en el servidor"));
    }catch ( e ) {
      return Left(ServerFailure(message: "$e"));
    }

  }

}