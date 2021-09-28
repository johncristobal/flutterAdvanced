import 'package:flutter/material.dart';
import 'package:s4_realtimechat/global/environments.dart';
import 'package:s4_realtimechat/models/mensajes_response.dart';
import 'package:s4_realtimechat/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:s4_realtimechat/services/auth_service.dart';

class ChatService with ChangeNotifier{

  late Usuario usuarioPara;
  
  Future<List<Mensaje>> getChat(String usuarioDe) async {
    final resp = await http.get(Uri.parse("${Env.apiUrl}/mensajes/$usuarioDe"),headers: {
      'x-token': await AuthService.getToken()
    });

    final mesResp = mensajesResponseFromJson(resp.body);
    return mesResp.mensajes;
  }
}