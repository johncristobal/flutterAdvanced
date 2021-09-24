import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:s4_realtimechat/global/environments.dart';
import 'package:s4_realtimechat/models/login_response.dart';
import 'package:s4_realtimechat/models/usuario.dart';

class AuthService with ChangeNotifier {

  late Usuario usuario;
  
  bool _loading = false;
  bool get loading => this._loading;
  set loading(bool v){
    this._loading = v;
    notifyListeners();
  }

  final _storage = new FlutterSecureStorage();

  //getters token
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token ?? "";
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "token");
  }

  Future<bool> login( String email, String pass) async {

   this.loading = true;

   final data = {
     "email": email,
     "password": pass
   };

   final resp = await http.post( Uri.parse("${Env.apiUrl}/login"), 
    body: jsonEncode(data),
    headers: {
      "Content-Type": "application/json"
    }
   );

    this.loading = false;

   if(resp.statusCode == 200){
     LoginResponse loginR = loginResponseFromJson(resp.body);
     this.usuario = loginR.user;

     await this._guardarToken(loginR.token);

     return true;
   }else{
     return false;
   }
 } 

  Future<bool> register( String name, String email, String pass) async {

   this.loading = true;

   final data = {
     "nombre": name,
     "email": email,
     "password": pass
   };

   final resp = await http.post( Uri.parse("${Env.apiUrl}/login/new"), 
    body: jsonEncode(data),
    headers: {
      "Content-Type": "application/json"
    }
   );

    this.loading = false;
   if(resp.statusCode == 200){
     LoginResponse loginR = loginResponseFromJson(resp.body);
     this.usuario = loginR.user;

     await this._guardarToken(loginR.token);

     return true;
   }else{
     return false;
   }
 } 

  Future _guardarToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future<bool> isLogged() async{
    final token = await this._storage.read(key: "token");
    final resp = await http.get( Uri.parse("${Env.apiUrl}/login/renew"), 
    headers: {
      "Content-Type": "application/json",
      "x-token": token ?? ""
    }
   );

   if(resp.statusCode == 200){
     LoginResponse loginR = loginResponseFromJson(resp.body);
     this.usuario = loginR.user;

     await this._guardarToken(loginR.token);

     return true;
   }else{
     this._logout( token ?? "" );
     return false;
   }
  }

  Future _logout(String token) async {
    return await _storage.delete(key: "token");
  }
}