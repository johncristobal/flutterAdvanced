import 'dart:io';

class Env {

  static String apiUrl = Platform.isAndroid
  ? "http://10.0.2.2:3000/api"
  : "http://localhost:3000/api";

  static String apisocketUrlUrl = Platform.isAndroid
  ? "http://10.0.2.2:3000"
  : "http://localhost:3000";
}