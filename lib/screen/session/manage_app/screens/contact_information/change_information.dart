import 'package:digital_identity/global_components/loading_indicator.dart';
import 'package:digital_identity/global_components/universal_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../providers/app_state/app_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../theme.dart';

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
    final Size size = MediaQuery.of(context).size;
    final sessionState = context.watch<SessionState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            L.of(context).contactInformation,
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding,
            vertical: kSmallPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UniversalTextField(
                keyboardType: keyboardType,
                autofocus: true,
                prefixText: prefixText,
                initialValue: initialValue,
              ),
              SizedBox(
                width: size.width - kMediumPadding,
                child: ElevatedButton(
                  onPressed: false
                      ? null
                      : () {
                          final FocusScopeNode currentFocus =
                              FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                  child: true
                      ? Container(
                          height: 19,
                          width: 19,
                          margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                          child: LoadingIndicator(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color(0xFFD9D9D9)
                                    : kTextFieldDarkBorder,
                          ),
                        )
                      : Text(L.of(context).updateFirstName),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
