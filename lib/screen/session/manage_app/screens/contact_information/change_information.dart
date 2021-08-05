import 'package:digital_identity/global_components/loading_indicator.dart';
import 'package:digital_identity/global_components/noti.dart';
import 'package:digital_identity/global_components/universal_text_field.dart';
import 'package:digital_identity/providers/update_contact_information/repo/update_contact_information_repo.dart';
import 'package:digital_identity/providers/update_contact_information/update_contact_information.dart';
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
          child: RepositoryProvider(
            create: (context) => UpdateContactInformationRepo(),
            child: BlocProvider(
              create: (context) => UpdateContactInformationBloc(
                repo: context.read<UpdateContactInformationRepo>(),
                sessionBloc: context.read<SessionBloc>(),
                email: sessionState.contactInformation!.credentialSubject.email,
                phoneNumber: sessionState
                    .contactInformation!.credentialSubject.phoneNumber,
              ),
              child: BlocConsumer<UpdateContactInformationBloc,
                  UpdateContactInformationState>(
                listener: (context, state) {
                  if (state.formStatus is SubmissionSuccess) {
                    showSuccessNoti(
                      message: "Contact Information updated",
                      context: context,
                    );
                    Navigator.pop(context);
                  } else if (state.formStatus is SubmissionFailed) {
                    showErrorNoti(
                        message: "Failed to update Contact Information",
                        context: context);
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UniversalTextField(
                        keyboardType: keyboardType,
                        autofocus: true,
                        prefixText: prefixText,
                        initialValue: initialValue,
                        errorText: prefixText == L.of(context).email
                            ? state.isValidEmail
                                ? null
                                : L.of(context).invalidEmail
                            : state.isValidPhoneNumber
                                ? null
                                : L.of(context).missingPhoneNumber,
                        onChanged: (value) =>
                            context.read<UpdateContactInformationBloc>().add(
                                  prefixText == L.of(context).email
                                      ? ChangeEmail(email: value)
                                      : ChangePhoneNumber(phoneNumber: value),
                                ),
                      ),
                      SizedBox(
                        width: size.width - kMediumPadding,
                        child: ElevatedButton(
                          onPressed: state.oneIsInvalid ||
                                  state.formStatus is Submitting
                              ? null
                              : () {
                                  final FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  context
                                      .read<UpdateContactInformationBloc>()
                                      .add(
                                        Submit(),
                                      );
                                },
                          child: state.formStatus is Submitting
                              ? Container(
                                  height: 19,
                                  width: 19,
                                  margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                  child: LoadingIndicator(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color(0xFFD9D9D9)
                                        : kTextFieldDarkBorder,
                                  ),
                                )
                              : Text(buttonText),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
