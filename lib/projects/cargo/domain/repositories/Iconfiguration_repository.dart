
// ignore_for_file: file_names

import '../entities/field.dart';

abstract class IConfigurationRepository{

  Future<Field> getConfiguration(String codeCustomer, String codeService);

}