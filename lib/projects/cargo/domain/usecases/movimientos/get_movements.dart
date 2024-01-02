import 'package:dartz/dartz.dart';

import 'package:solgis/core/errors/failure.dart';
import 'package:solgis/projects/cargo/domain/repositories/imovements_repository.dart';


class GetMovements{

  GetMovements({
    IMovementsRepository? repository,
  }) : assert(repository != null ),

    _repository =  repository!;

  final IMovementsRepository _repository;

  Future<Either<Failure, Object>> call(codTipoCarga, codServicio, tipoConsulta) async => await _repository.getMovements(codTipoCarga, codServicio, tipoConsulta);

}

// class GetMovements{
//   final IMovementsRepository movementsRepository;
//   GetMovements(this.movementsRepository);
//   Future<Either<Failure, List<Movement>>> call( String codTipoCarga, String codServicio, String tipoConsulta ) async{
//     return movementsRepository.getMovements( codTipoCarga, codServicio, tipoConsulta );
//   }
// }
