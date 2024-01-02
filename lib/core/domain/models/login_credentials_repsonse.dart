import 'dart:convert';

LoginCredentialsResponse loginCredentialsResponseFromJson(String str) => LoginCredentialsResponse.fromJson(json.decode(str));

class LoginCredentialsResponse {

    LoginCredentialsResponse({

      this.codigoUsuario,
      this.documento,
      this.nombres,
      this.apellidos,
      this.usuario,
      this.codigoCliente,
      this.codigoTipoUsuario,

    });

    int? codigoUsuario;
    String? documento;
    String? nombres;
    String? apellidos;
    String? usuario;
    String? codigoCliente;
    int? codigoTipoUsuario;

    LoginCredentialsResponse.fromJson(Map<String, dynamic> json) {

      codigoUsuario       = json["codigo_usuario"];
      documento           = json["documento"];
      nombres             = json["nombres"];
      apellidos           = json["apellidos"];
      usuario             = json["usuario"];
      codigoCliente       = json["codigo_cliente"];
      codigoTipoUsuario   = json["codigo_tipo_usuario"];

    }


}
