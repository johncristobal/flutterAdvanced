import 'package:flutter/material.dart';

class MarkerInicioPainter extends CustomPainter{

  final int minutos;

  MarkerInicioPainter(this.minutos);

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

    final path = new Path();
    path.moveTo(40, 20);
    path.lineTo( size.width - 10 , 20);
    path.lineTo( size.width - 10 , 100);
    path.lineTo( 40 , 100);

    canvas.drawShadow(
      path,
      Colors.black87, 
      10, 
      false
    );

    paint.color = Colors.white;
    final cajaBlanca = Rect.fromLTWH(40,20, size.width - 55, 80);
    canvas.drawRect(cajaBlanca, paint);

    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40,20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //textos
    TextSpan span = new TextSpan(
      style: TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400
      ),
      text: '$minutos'
    );

    final painter = new TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    painter.paint(canvas, Offset(40,35));

    //minits
    span = new TextSpan(
      style: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400
      ),
      text: 'Min'
    );

    final painterM = new TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    painterM.paint(canvas, Offset(40,65));

    //mi ubicacino
     span = new TextSpan(
      style: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400
      ),
      text: 'Mi ubicacion'
    );

    final painterU = new TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: size.width - 130,
    );

    painterU.paint(canvas, Offset(160, 50));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return false;
  }

}