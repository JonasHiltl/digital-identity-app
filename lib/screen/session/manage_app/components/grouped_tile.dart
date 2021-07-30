import 'package:digital_identity/theme.dart';
import 'package:flutter/material.dart';

class GroupedTile extends StatelessWidget {
  const GroupedTile({Key? key, required this.children, required this.title})
      : super(key: key);
  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding,
            vertical: 8,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 13,
                  letterSpacing: 0.2,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
