import 'package:digital_identity/global_components/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_identity/providers/update_personal_data/update_personal_data.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:digital_identity/data/countries.dart';
import 'package:digital_identity/global_components/universal_text_field.dart';

import '../../../../generated/l10n.dart';
import '../../../../theme.dart';

class ChangeCountry extends StatefulWidget {
  const ChangeCountry({Key? key}) : super(key: key);

  @override
  _ChangeCountryState createState() => _ChangeCountryState();
}

class _ChangeCountryState extends State<ChangeCountry> {
  List<CustomCountry> suggestion = countries;

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "All Countries (${countries.length})",
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: RepositoryProvider(
          create: (context) => UpdatePersonalDataRepo(),
          child: BlocProvider<UpdatePersonalBloc>(
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
                      message: L.of(context).updateSuccessCountry,
                      context: context);
                  Navigator.pop(context);
                } else if (state.formStatus is SubmissionFailed) {
                  showErrorNoti(
                      message: L.of(context).updateErrorMessage,
                      context: context);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kMediumPadding,
                        vertical: kSmallPadding,
                      ),
                      child: UniversalTextField(
                        prefixText: "Search",
                        onChanged: (value) => setState(
                          () {
                            suggestion = getCountrySuggestion(value);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: suggestion
                          .map(
                            (country) => InkWell(
                              onTap: () {
                                context.read<UpdatePersonalBloc>().add(
                                      UpdateCountryChanged(
                                          country: country.code),
                                    );
                                context
                                    .read<UpdatePersonalBloc>()
                                    .add(UpdateSubmitted());
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kMediumPadding,
                                  vertical: kSmallPadding / 2,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(
                                            country.flagUrl,
                                          ),
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: kSmallPadding,
                                    ),
                                    Text(
                                      country.name,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
