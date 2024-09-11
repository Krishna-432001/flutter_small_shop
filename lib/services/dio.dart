import 'package:dio/dio.dart';

import '../utils/Constants.dart';

Dio dio(){
  Dio dio = new Dio();
  // dio.options.baseUrl="http://192.168.1.73.8000/api";
  dio.options.baseUrl=Constants.BASE_URL;
  dio.options.headers['accept']="application/json";
  return dio;
}