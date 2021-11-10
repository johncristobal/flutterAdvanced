import 'package:flutter/material.dart';

///Tipos de animaciones
enum AnimationType { normal, fadeIn }

//Main Class
class RouteTransitions {
  final BuildContext context;
  final Widget child;
  final AnimationType animtation;
  final Duration duration;
  final bool replacement;

  RouteTransitions(
      {required this.context,
      required this.child,
      this.animtation = AnimationType.normal,
      this.duration = const Duration(milliseconds: 300),
      this.replacement = false}) {
    switch (animtation) {
      case AnimationType.normal:
        _normalTransition();
        break;
      case AnimationType.fadeIn:
        _fadeInTransition();
        break;
      default:
    }
  }

  void _pushPage(Route route) => Navigator.push(context, route);

  void _pushReplacementPage(Route route) =>
      Navigator.pushReplacement(context, route);

  void _normalTransition() {
    final route = MaterialPageRoute(builder: (_) => child);
    (this.replacement)
        ? this._pushReplacementPage(route)
        : this._pushPage(route);
  }

  void _fadeInTransition() {
    final route = PageRouteBuilder(
        pageBuilder: (_, __, ___) => this.child,
        transitionDuration: duration,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
              child: child,
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut)));
        });

    (this.replacement)
        ? this._pushReplacementPage(route)
        : this._pushPage(route);
  }
}
