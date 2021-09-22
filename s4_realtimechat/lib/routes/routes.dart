import 'package:flutter/material.dart';
import 'package:s4_realtimechat/pages/chat_page.dart';
import 'package:s4_realtimechat/pages/loading_page.dart';
import 'package:s4_realtimechat/pages/login_page.dart';
import 'package:s4_realtimechat/pages/register_page.dart';
import 'package:s4_realtimechat/pages/usuarios_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios': ( _ ) => UsuarioPage(),
  'chat': ( _ ) => ChatPage(),
  'login': ( _ ) => LoginPage(),
  'register': ( _ ) => RegisterPage(),
  'loading': ( _ ) => LoadingPage(),
};