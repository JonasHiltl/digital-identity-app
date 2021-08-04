import 'package:digital_identity/global_components/loading_indicator.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:digital_identity/global_components/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_identity/providers/update_personal_data/update_personal_data.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../theme.dart';

class ChangeSex extends StatelessWidget {
  const ChangeSex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final SessionState sessionState = context.watch<SessionState>();
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
                      message: L.of(context).updateSuccessSex,
                      context: context);
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? kLightAccentBG
                                    : kDarkAccentBG,
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? kTextFieldLightBorder
                                      : kTextFieldDarkBorder,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: "female",
                                    groupValue: context
                                        .read<UpdatePersonalBloc>()
                                        .state
                                        .sex,
                                    onChanged: (value) =>
                                        context.read<UpdatePersonalBloc>().add(
                                              UpdateSexChanged(
                                                sex: value.toString(),
                                              ),
                                            ),
                                    activeColor: Theme.of(context).primaryColor,
                                  ),
                                  Text(L.of(context).female),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: kSmallPadding,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? kLightAccentBG
                                    : kDarkAccentBG,
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? kTextFieldLightBorder
                                      : kTextFieldDarkBorder,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: "male",
                                    groupValue: context
                                        .read<UpdatePersonalBloc>()
                                        .state
                                        .sex,
                                    onChanged: (value) =>
                                        context.read<UpdatePersonalBloc>().add(
                                              UpdateSexChanged(
                                                sex: value.toString(),
                                              ),
                                            ),
                                    activeColor: Theme.of(context).primaryColor,
                                  ),
                                  Text(L.of(context).male),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: size.width - 20,
                        child: ElevatedButton(
                          onPressed: !state.isValidSex ||
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
                              : Text(L.of(context).updateSex),
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
