import 'package:s4_realtimechat/global/environments.dart';
import 'package:s4_realtimechat/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:s4_realtimechat/models/usuario_response.dart';
import 'package:s4_realtimechat/services/auth_service.dart';

class UsuarioService {

  Future<List<Usuario>> getUsuarios() async {

      try{
        final resp = await http.get(
          Uri.parse("${Env.apiUrl}/usuarios"),
          headers: {
            "Content-Type":"application/json",
            "x-token" : await AuthService.getToken()
          }
        );
        final usuariosResponse = usuarioResponseFromJson(resp.body);
        return usuariosResponse.usuarios;

      }catch(e){
        return [];
      }
  }
}