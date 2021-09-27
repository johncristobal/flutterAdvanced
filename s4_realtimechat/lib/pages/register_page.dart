import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s4_realtimechat/helpers/mostrarAlerta.dart';
import 'package:s4_realtimechat/services/auth_service.dart';
import 'package:s4_realtimechat/services/socket_service.dart';
import 'package:s4_realtimechat/widgets/btn_azul.dart';
import 'package:s4_realtimechat/widgets/custom_input.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Logo(),
                _Form(),
                _Labels(ruta: 'login',),                  
                Text("Terminos y condicinoes", style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children:[
            Image( image: AssetImage("assets/tag-logo.png")),
            SizedBox(height: 20,),
            Text("Registro", style: TextStyle(fontSize: 30))
          ]
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();  
  final passCtrl = TextEditingController();  
  final nameCtrl = TextEditingController();  

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AuthService>(context);
    final providerSocket = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [       

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: "Nombre",
            type: TextInputType.text,
            textController: nameCtrl,
          ),

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: "Correo",
            type: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: "Contraseña",
            type: TextInputType.text,
            isPass: true,
            textController: passCtrl,
          ),

          BotonAzul(
            text: "Ingrese", 
            loading: provider.loading,
            onPressed: provider.loading ? null : () async {              
              FocusScope.of(context).unfocus();
              final regiseterOk = await provider.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());

              if(regiseterOk){  
                providerSocket.connect();
                Navigator.pushReplacementNamed(context, "usuarios");
              }else{
                mostrarAlerta(context, "Registro incorrecto", "Revise información");
              }
            }
          )
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {

  final String ruta;

  const _Labels({Key? key, required this.ruta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Ya tienes cuenta", style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
          SizedBox(height: 10),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            child: Text("Iniciar sesion", style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}