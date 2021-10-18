import 'package:calculadora/controllers/calculator_controller.dart';
import 'package:calculadora/widgets/line_separator.dart';
import 'package:calculadora/widgets/main_result.dart';
import 'package:calculadora/widgets/sub_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MathResults extends StatelessWidget {

  final calculatorController = Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SubResult( text: '${calculatorController.firstNumber}' ),
          SubResult( text: '${calculatorController.operation}' ),
          SubResult( text: '${calculatorController.secondNumber}' ),
          LineSeparator(),
          MainResultText( text: '${calculatorController.mathResult}' ),
        ],
      )
    );
  }
}