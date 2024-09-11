import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_small_shop/services/dio.dart';
import 'package:flutter_small_shop/utils/Constants.dart';
import '../models/User.dart';

import 'package:http/http.dart' as http ;


class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;

  User? _user;

  String? _token;

  bool get authenticated => _isLoggedIn;

  User? get user => _user;

  final storage = new FlutterSecureStorage();

  void login({required Map creds}) async {
    print(creds);
    try {
      Dio.Response response = await dio().post(Constants.LOGIN_ROUTE, data: creds);
      print(response.data);
      String token = response.data.toString();
      this.tryToken(token: token);
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      print('Login Error:$e ${Constants.BASE_URL}${Constants.LOGIN_ROUTE}');
    }
  }
  void tryToken({required String token}) async {
    if(token == null){
      return;
    }
    else{
      try{
        Dio.Response response = await dio().get(
          '/user', options: Dio.Options(headers:{'Authorization' : 'Bearer $token'})
        );
        _isLoggedIn = true;
        this._user = User.fromJson(response.data);
        this._token=token;
        this.storeToken(token: token);
        notifyListeners();
        print(this._user);
      } catch (e){
    }

    }
  }
  void storeToken({required String token}) async{
    this.storage.write(key: 'token', value:token);
  }
void  logout() async{
    dynamic token = await this. storage.read(key: 'token');
    try{
      print('logout started');
      Dio.Response response = await dio().get(
        Constants.LOGOUT_ROUTE, options: Dio.Options(headers:{'Authorization' : 'Bearer $token'})
      );
      print(response.data);
      cleanUp();
      notifyListeners();
      print('logout ended');
    }
    catch(e){
      print(e);
    }
    notifyListeners();
}
void cleanUp() async{
    this._user = null;
    this._isLoggedIn = false;
    this._token = null;
    await storage.delete(key: 'token');
}
Future<void> registerUser({
    required Map creds
}) async{
    try{
      final response = await http.post(
        Uri.parse(Constants.BASE_URL + Constants.USER_REGISTER_ROUTE),
        body: creds,
      );
      if(response.statusCode ==201){
        Map<String, dynamic> responseData = json.decode(response.body);
        print('User registred successfully: ${responseData['user'] ['name']}');
      }
      else{
        print(response.statusCode);
        print('registration failed:${Constants.BASE_URL}${Constants.USER_REGISTER_ROUTE} ${response.toString()} ${response.body}');
      }
    } catch(e)
    {
      print('error during registration: $e');

    }
  await Future.delayed(Duration(seconds: 2));
    notifyListeners();
}
}