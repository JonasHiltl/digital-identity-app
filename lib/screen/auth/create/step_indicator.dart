import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: index >= 0
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.4),
            height: 3,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Container(
            color: index >= 1
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.4),
            height: 3,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Container(
            color: index >= 2
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.4),
            height: 3,
          ),
        ),
      ],
    );
  }
}
