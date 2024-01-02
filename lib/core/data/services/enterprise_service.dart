import 'dart:convert';

import 'package:solgis/core/domain/models/enterprise_model.dart';
import 'package:solgis/core/global/environment.dart';
import 'package:http/http.dart' as http;

class EnterpriseService{

  static Future<List<EnterpriseModel>> getEnterpriseByCustomer( String? enterpriseName, String ruc, String codeCustomer ) async{

    const String uncodePath = 'api/enterprise/';
    
    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,
      {
        'enterpriseName': enterpriseName,
        'ruc': ruc,
        'codeCustomer': codeCustomer,
      }
    );

    final response = await http.get(
      url,
      headers:{
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      }
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final resp = EnterprisesModel.fromJsonList(decodedData);
      return resp.items;
    }else{
      return[];
    }

  }

}