import 'package:digital_identity/global_components/loading_indicator.dart';
import 'package:digital_identity/global_components/noti.dart';
import 'package:digital_identity/global_components/universal_text_field.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:digital_identity/providers/create_contact_information/create_contact_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../theme.dart';

class CreateContactInformation extends StatelessWidget {
  const CreateContactInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => CreateContactInformationRepo(),
      child: BlocProvider(
        create: (context) => CreateContactInformationBloc(
          repo: context.read<CreateContactInformationRepo>(),
          sessionBloc: context.read<SessionBloc>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text(
              L.of(context).createContactInformation,
              style: Theme.of(context).textTheme.headline5,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kMediumPadding,
              vertical: kSmallPadding,
            ),
            child: BlocConsumer<CreateContactInformationBloc,
                CreateContactInformationState>(
              listener: (context, state) {
                if (state.formStatus is SubmissionFailed) {
                  showErrorNoti(
                    message: L.of(context).contactInformationError,
                    context: context,
                  );
                }
                if (state.formStatus is SubmissionSuccess) {
                  showSuccessNoti(
                    message: L.of(context).contactInformationSuccess,
                    context: context,
                  );
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        UniversalTextField(
                          errorText: state.showEmailError
                              ? L.of(context).invalidEmail
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          prefixText: L.of(context).email,
                          onChanged: (value) =>
                              context.read<CreateContactInformationBloc>().add(
                                    ChangeEmail(email: value),
                                  ),
                        ),
                        const SizedBox(
                          height: kSmallPadding,
                        ),
                        UniversalTextField(
                          keyboardType: TextInputType.phone,
                          prefixText: L.of(context).phoneNumber,
                          onChanged: (value) =>
                              context.read<CreateContactInformationBloc>().add(
                                    ChangePhoneNumer(phoneNumber: value),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width - kMediumPadding,
                      child: ElevatedButton(
                        onPressed: state.formStatus is Submitting ||
                                !state.isValidEmail ||
                                !state.isValidPhoneNumber
                            ? null
                            : () {
                                final FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                context
                                    .read<CreateContactInformationBloc>()
                                    .add(Submitted());
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
                            : Text("Add Contact Information"),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        )),
      ),
    );
  }
}
