
class EntryLazyResponse {
  EntryLazyResponse({
    this.codTipoCarga,
    this.tipoCarga,
  });

  int? codTipoCarga;
  String? tipoCarga;

  EntryLazyResponse.fromJson(Map<String, dynamic> json) {
    codTipoCarga = json["cod_tipo_carga"];
    tipoCarga    = json["tipo_carga"];
  }

}