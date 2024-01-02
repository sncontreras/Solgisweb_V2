import 'package:solgis/projects/cargo/data/models/movement_model.dart';

class MovementsModel {

  List<MovementModel> items = [];
  MovementsModel();

  MovementsModel.fromJsonList( List<dynamic> jsonList ){
    for ( var item in jsonList ){
      final movimiento = MovementModel.fromJson(item);
      items.add(movimiento);
    }
  }

}