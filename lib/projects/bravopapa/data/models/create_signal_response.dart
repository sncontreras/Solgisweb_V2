class CreateSignalResponse {
  CreateSignalResponse({
    this.mensaje,
  });

  String? mensaje;

  CreateSignalResponse.fromJson(Map<String, dynamic> json) {
      mensaje = json["mensaje"];
  }

}
