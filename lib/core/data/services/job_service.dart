import 'dart:convert';
import 'dart:io';

import 'package:solgis/core/domain/models/job_model.dart';
import 'package:solgis/core/global/environment.dart';
import 'package:http/http.dart' as http;

class JobService{

  static Future<List<JobModel>> getJobs( String job, String codCliente ) async {

    const String uncodePath = 'api/job/';

    final url = Uri.http( Environment.apiCargoUrl, 
      uncodePath, {
        'cargo': job,
        'cod_cliente': codCliente,
      }
    );

    final resp = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
      }
    );

    if( resp.statusCode ==200 ){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final empresas = JobsModel.fromJsonList(decodedData);
      return empresas.items;
    }else{
      return[];
    }

  }


}