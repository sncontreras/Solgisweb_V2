import 'dart:io';

class Environment {
  //static String apiUrl      = Platform.isAndroid  ? '190.116.178.163:96'  :'190.116.178.163:96';
  //static String apiCargoUrl = Platform.isAndroid  ? '190.116.178.163:93'  :'190.116.178.163:93';

  // static String apiUrl      = Platform.isAndroid  ? '110.238.69.69:96'     :'110.238.69.69:96';
  // static String apiCargoUrl = Platform.isAndroid  ? '110.238.69.69:93'     :'110.238.69.69:93';
  // static String apiCargoUrl = Platform.isAndroid  ? '119.8.149.63:93'      :'119.8.149.63:93';

  //static String apiUrl      = Platform.isAndroid  ? '192.168.10.103:7001'  :'192.168.10.103:7001';
  //static String apiCargoUrl = Platform.isAndroid  ? '192.168.10.103:7001'  :'192.168.10.103:7001';

  //boa
  static String apiUrl =
      Platform.isAndroid ? '190.116.178.163:96' : '190.116.178.163:96';
  static String apiCargoUrl =
      Platform.isAndroid ? '190.116.178.163:93' : '190.116.178.163:93';
}
