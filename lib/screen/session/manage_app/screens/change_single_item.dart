import 'package:digital_identity/global_components/loading_indicator.dart';
import 'package:digital_identity/global_components/noti.dart';
import 'package:digital_identity/global_components/universal_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:digital_identity/providers/update_personal_data/update_personal_data.dart';

import '../../../../generated/l10n.dart';
import '../../../../theme.dart';

class ChangeSingleItem extends StatelessWidget {
  const ChangeSingleItem({
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
            L.of(context).personalData,
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
        ),
        body: RepositoryProvider(
          create: (context) => UpdatePersonalDataRepo(),
          child: BlocProvider(
            create: (context) => UpdatePersonalBloc(
              sessionBloc: context.read<SessionBloc>(),
              repo: context.read<UpdatePersonalDataRepo>(),
              firstName:
                  sessionState.personalDataVc!.credentialSubject.firstName,
              lastName: sessionState.personalDataVc!.credentialSubject.lastName,
              dateOfBirth:
                  sessionState.personalDataVc!.credentialSubject.dateOfBirth,
              sex: sessionState.personalDataVc!.credentialSubject.sex,
              address:
                  sessionState.personalDataVc!.credentialSubject.address.street,
              city: sessionState.personalDataVc!.credentialSubject.address.city,
              locationState:
                  sessionState.personalDataVc!.credentialSubject.address.state,
              postalCode: sessionState
                  .personalDataVc!.credentialSubject.address.postalCode,
              country: sessionState
                  .personalDataVc!.credentialSubject.address.country,
            ),
            child: BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
              listener: (context, state) {
                if (state.formStatus is SubmissionSuccess) {
                  showSuccessNoti(
                    message: prefixText == L.of(context).firstName
                        ? L.of(context).updateSuccessFirstName
                        : prefixText == L.of(context).lastName
                            ? L.of(context).updateSuccessLastName
                            : L.of(context).updateSuccessAddress,
                    context: context,
                  );
                  Navigator.pop(context);
                } else if (state.formStatus is SubmissionFailed) {
                  showErrorNoti(
                      message: L.of(context).updateErrorMessage,
                      context: context);
                }
              },
              builder: (context, state) {
                return Padding(
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
                        onChanged: (value) => context
                            .read<UpdatePersonalBloc>()
                            .add(prefixText == L.of(context).firstName
                                ? UpdateFirstNameChanged(firstName: value)
                                : prefixText == L.of(context).lastName
                                    ? UpdateLastNameChanged(lastName: value)
                                    : prefixText == L.of(context).streetNumber
                                        ? UpdateAddressChanged(address: value)
                                        : prefixText == L.of(context).postalCode
                                            ? UpdatePostalCodeChanged(
                                                postalCode: value)
                                            : prefixText == L.of(context).city
                                                ? UpdateCityChanged(city: value)
                                                : UpdateCityChanged(
                                                    city: value)),
                        initialValue: initialValue,
                      ),
                      SizedBox(
                        width: size.width - kMediumPadding,
                        child: ElevatedButton(
                          onPressed: state.oneIsInvalid ||
                                  state.formStatus is FormSubmitting
                              ? null
                              : () {
                                  final FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  context
                                      .read<UpdatePersonalBloc>()
                                      .add(UpdateSubmitted());
                                },
                          child: state.formStatus is FormSubmitting
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
                              : Text(L.of(context).updateFirstName),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
