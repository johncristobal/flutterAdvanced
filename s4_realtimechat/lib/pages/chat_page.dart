import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s4_realtimechat/services/chat_service.dart';
import 'package:s4_realtimechat/widgets/chat.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focus= new FocusNode();
  bool _escribiendo = false;
  
  final List<ChatMessage> _messages = [
  ];

  @override
  Widget build(BuildContext context) {

    final service = Provider.of<ChatService>(context, listen: false); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(service.usuarioPara.nombre.substring(0,2), style: TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue[100],
              maxRadius: 12,
            ),
            SizedBox(height: 2,),
            Text(service.usuarioPara.nombre, style: TextStyle(color: Colors.black87, fontSize: 11),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              )
            ),
            
            Divider(height: 1,),

            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
   );
  }

  Widget  _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (e){
                  setState(() {
                    _escribiendo = (e.trim().length > 0) ? true : false;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Enviar mensaje"
                ),
                focusNode: _focus,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS 
              ? CupertinoButton(
                child: Text("Enviar"), 
                onPressed: _escribiendo
                    ? () => _handleSubmit(_textController.text)
                    : null,
              )
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.blue
                  ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send, color: Colors.blue[400],),
                    onPressed: _escribiendo
                    ? () => _handleSubmit(_textController.text)
                    : null,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  _handleSubmit(String texto){
    if(texto.length == 0) return;

    _textController.clear();
    _focus.requestFocus();

    final msg = new ChatMessage(
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 500)),
      texto: texto, 
      uid: '123');

    setState(() {
      _escribiendo = false;
      _messages.insert(0, msg);
      msg.animationController.forward();
    });
  }

  @override
  void dispose() {
    //TODO  off socket
    for( ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}