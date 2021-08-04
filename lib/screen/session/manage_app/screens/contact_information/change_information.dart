import 'package:flutter/material.dart';

class ChangeInformation extends StatelessWidget {
  const ChangeInformation({
    Key? key,
    required this.prefixText,
    required this.initialValue,
    required this.buttonText,
    this.keyboardType,
  }) : super(key: key);

  final String prefixText;
  final String initialValue;
  final TextInputType? keyboardType;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
