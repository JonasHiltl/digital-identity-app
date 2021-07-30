import 'package:flutter/material.dart';

import '../theme.dart';

class UniversalTextField extends StatefulWidget {
  final String? errorText;
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final String prefixText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final bool? readOnly;
  final Color? textColor;
  const UniversalTextField({
    this.errorText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.keyboardType,
    this.autofocus,
    this.readOnly,
    this.textColor,
    this.onTap,
    required this.prefixText,
  });

  @override
  _UniversalTextFieldState createState() => _UniversalTextFieldState();
}

class _UniversalTextFieldState extends State<UniversalTextField> {
  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: widget.textColor),
      cursorWidth: 1,
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: kSmallPadding,
          ),
          child: Text(
            widget.prefixText,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6),
                ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 100,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: kSmallPadding,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? kTextFieldLightBorder
                : kTextFieldDarkBorder,
          ),
        ),
        errorText: widget.errorText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
        ),
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.light
            ? kLightAccentBG
            : kDarkAccentBG,
      ),
      onTap: widget.onTap,
      onChanged: widget.onChanged,
    );
  }
}
