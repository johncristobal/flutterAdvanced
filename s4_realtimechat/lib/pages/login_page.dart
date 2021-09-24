import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s4_realtimechat/helpers/mostrarAlerta.dart';
import 'package:s4_realtimechat/services/auth_service.dart';
import 'package:s4_realtimechat/widgets/btn_azul.dart';
import 'package:s4_realtimechat/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {

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
                _Labels(ruta: 'register',),                  
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
            Text("Messenger", style: TextStyle(fontSize: 30))
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

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [          
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
              final loginoK = await provider.login(emailCtrl.text.trim(), passCtrl.text.trim());

              if(loginoK){  
                Navigator.pushReplacementNamed(context, "usuarios");
              }else{
                mostrarAlerta(context, "Login incorrecto", "Revise credenciales");
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
          Text("No tienes cuenta", style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
          SizedBox(height: 10),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            child: Text("Crea una ahora", style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}