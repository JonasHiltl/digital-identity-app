import 'package:digital_identity/data/countries.dart';
import 'package:digital_identity/models/personal_data/credential_subject.dart';
import 'package:digital_identity/screen/session/manage_app/components/grouped_tile.dart';
import 'package:digital_identity/screen/session/manage_app/screens/change_country.dart';
import 'package:digital_identity/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../generated/l10n.dart';
import 'change_date_of_birth.dart';
import 'change_sex.dart';
import 'change_single_item.dart';

class PersonalDataField {
  PersonalDataField({
    required this.initialValue,
    required this.onTap,
    required this.prefixText,
    this.keyboardType,
  });

  final String initialValue;
  final Function()? onTap;
  final String prefixText;
  final TextInputType? keyboardType;
}

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  List<PersonalDataField> _addressItems(
          CredentialSubject personalData, BuildContext context) =>
      [
        PersonalDataField(
          initialValue: personalData.address.street,
          prefixText: L.of(context).streetNumber,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.easeInOut,
                child: ChangeSingleItem(
                  prefixText: L.of(context).streetNumber,
                  initialValue: personalData.address.street,
                  buttonText: L.of(context).updateAddress,
                ),
              ),
            );
            setState(() {});
          },
        ),
        PersonalDataField(
          initialValue: personalData.address.postalCode,
          prefixText: L.of(context).postalCode,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.easeInOut,
                child: ChangeSingleItem(
                  keyboardType: TextInputType.number,
                  prefixText: L.of(context).postalCode,
                  initialValue: personalData.address.postalCode,
                  buttonText: L.of(context).updatePostalCode,
                ),
              ),
            );
            setState(() {});
          },
        ),
        PersonalDataField(
          initialValue: personalData.address.city,
          prefixText: L.of(context).city,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.easeInOut,
                child: ChangeSingleItem(
                  prefixText: L.of(context).city,
                  initialValue: personalData.address.city,
                  buttonText: L.of(context).updateCity,
                ),
              ),
            );
            setState(() {});
          },
        ),
        PersonalDataField(
          initialValue: personalData.address.state,
          prefixText: L.of(context).state,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.easeInOut,
                child: ChangeSingleItem(
                  prefixText: L.of(context).state,
                  initialValue: personalData.address.state,
                  buttonText: L.of(context).updateState,
                ),
              ),
            );
            setState(() {});
          },
        ),
        PersonalDataField(
          initialValue: getCountryByCode(personalData.address.country).name,
          prefixText: L.of(context).country,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                curve: Curves.easeInOut,
                type: PageTransitionType.bottomToTop,
                child: ChangeCountry(),
              ),
            );
            setState(() {});
          },
        )
      ];

  List<PersonalDataField> _personalDataItems(
          CredentialSubject personalData, BuildContext context) =>
      [
        PersonalDataField(
          initialValue: personalData.firstName,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.easeInOut,
                child: ChangeSingleItem(
                  prefixText: L.of(context).firstName,
                  initialValue: personalData.firstName,
                  buttonText: L.of(context).updateFirstName,
                ),
              ),
            );
            setState(() {});
          },
          prefixText: L.of(context).firstName,
        ),
        PersonalDataField(
          initialValue: personalData.lastName,
          prefixText: L.of(context).lastName,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.easeInOut,
                child: ChangeSingleItem(
                  prefixText: L.of(context).lastName,
                  initialValue: personalData.lastName,
                  buttonText: L.of(context).updateLastName,
                ),
              ),
            );
            setState(() {});
          },
        ),
        PersonalDataField(
          initialValue: personalData.sex == "male"
              ? L.of(context).male
              : L.of(context).female,
          prefixText: L.of(context).sex,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.easeInOut,
                child: ChangeSex(),
              ),
            );
            setState(() {});
          },
        ),
        PersonalDataField(
          initialValue:
              DateFormat.yMMMd().format(personalData.dateOfBirth.toLocal()),
          prefixText: L.of(context).dateOfBirth,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.easeInOut,
                child: ChangeDateOfBirth(
                  initialValue: DateFormat.yMMMd()
                      .format(personalData.dateOfBirth.toLocal()),
                ),
              ),
            );
            setState(() {});
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final personalData =
        context.read<SessionState>().personalDataVc!.credentialSubject;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: Text(
                L.of(context).personalData,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SliverToBoxAdapter(
              child: GroupedTile(
                title: L.of(context).personalData,
                children: _personalDataItems(personalData, context)
                    .map((e) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                kMediumPadding,
                                4,
                                0,
                                4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.prefixText,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        e.initialValue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.6),
                                            ),
                                      ),
                                      SizedBox(
                                        width: kSmallPadding,
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.fromLTRB(
                                              20,
                                              kSmallPadding,
                                              20,
                                              kSmallPadding,
                                            ),
                                          ),
                                        ),
                                        onPressed: e.onTap,
                                        child: Text(
                                          L.of(context).edit,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            e.initialValue !=
                                    DateFormat.yMMMd().format(
                                        personalData.dateOfBirth.toLocal())
                                ? Divider(
                                    height: 0,
                                  )
                                : Container()
                          ],
                        ))
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: kSmallPadding),
            ),
            SliverToBoxAdapter(
              child: GroupedTile(
                title: L.of(context).residence,
                children: _addressItems(personalData, context)
                    .map((e) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                kMediumPadding,
                                4,
                                0,
                                4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.prefixText,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        e.initialValue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.6),
                                            ),
                                      ),
                                      SizedBox(
                                        width: kSmallPadding,
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.fromLTRB(
                                              20,
                                              kSmallPadding,
                                              20,
                                              kSmallPadding,
                                            ),
                                          ),
                                        ),
                                        onPressed: e.onTap,
                                        child: Text(
                                          L.of(context).edit,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            e.initialValue != personalData.address.country
                                ? Divider(
                                    height: 0,
                                  )
                                : Container()
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
