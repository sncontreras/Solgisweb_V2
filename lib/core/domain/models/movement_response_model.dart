class MovementResponse {
  MovementResponse({
    this.transaccion,
    this.codMovCreado,
  });

  int? transaccion;
  int? codMovCreado;

  MovementResponse.fromJson(Map<String, dynamic> json) {
    transaccion = json["transaccion"];
    codMovCreado = json["cod_mov_creado"];
  }

}
