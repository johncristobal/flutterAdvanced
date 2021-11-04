import 'package:flutter/material.dart';

class MarkerDestinoPainter extends CustomPainter{

  final String description;
  final double metros;

  MarkerDestinoPainter(this.description, this.metros);

  @override
  void paint(Canvas canvas, Size size) {

    final double circleNegro = 20;
    final double circleBlanco = 7;

    Paint paint = new Paint()
      ..color = Colors.black;

    canvas.drawCircle(
      Offset( circleNegro ,size.height - circleNegro),
      20,
      paint
    );

    paint.color = Colors.white;

    canvas.drawCircle(
      Offset( circleNegro ,size.height - circleNegro),
      circleBlanco,
      paint
    );

    //sombra
    final path = new Path();
    path.moveTo(0, 20);
    path.lineTo( size.width - 10 , 20);
    path.lineTo( size.width - 10 , 100);
    path.lineTo( 0 , 100);

    canvas.drawShadow(
      path,
      Colors.black87, 
      10, 
      false
    );

    paint.color = Colors.white;
    final cajaBlanca = Rect.fromLTWH(0,20, size.width - 10, 80);
    canvas.drawRect(cajaBlanca, paint);

    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(0,20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //textos
    double km = this.metros/1000;
    km = (km*100).floor().toDouble();
    km = km / 100;

    TextSpan span = new TextSpan(
      style: TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400
      ),
      text: '$km'
    );

    final painter = new TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    painter.paint(canvas, Offset(0,35));

    //minits
    span = new TextSpan(
      style: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400
      ),
      text: 'Km'
    );

    final painterM = new TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
    );

    painterM.paint(canvas, Offset(20,65));

    //mi ubicacino
     span = new TextSpan(
      style: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400
      ),
      text: '${this.description}'
    );

    final painterU = new TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...'
    )..layout(
      maxWidth: size.width - 100,
    );

    painterU.paint(canvas, Offset(90, 35));

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}