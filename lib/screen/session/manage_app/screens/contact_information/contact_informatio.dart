import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:digital_identity/screen/session/manage_app/components/grouped_tile.dart';
import 'package:digital_identity/screen/session/manage_app/screens/contact_information/change_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../theme.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionState>();
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
                L.of(context).contactInformation,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SliverToBoxAdapter(
              child: GroupedTile(
                title: L.of(context).contactInformation,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          kMediumPadding,
                          4,
                          0,
                          4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              L.of(context).email,
                            ),
                            Row(
                              children: [
                                Text(
                                  sessionState.contactInformation!
                                      .credentialSubject.email,
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
                                  onPressed: () /* async */ {
                                    /* await */ Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        curve: Curves.easeInOut,
                                        child: ChangeInformation(
                                          prefixText: L.of(context).email,
                                          initialValue: sessionState
                                              .contactInformation!
                                              .credentialSubject
                                              .email,
                                          buttonText: L.of(context).updateEmail,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                    );
                                    /* setState(() {}); */
                                  },
                                  child: Text(
                                    L.of(context).edit,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      kMediumPadding,
                      4,
                      0,
                      4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          L.of(context).phoneNumber,
                        ),
                        Row(
                          children: [
                            Text(
                              sessionState.contactInformation!.credentialSubject
                                  .phoneNumber,
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
                              onPressed: () /* async */ {
                                /* await */ Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    curve: Curves.easeInOut,
                                    child: ChangeInformation(
                                      keyboardType: TextInputType.phone,
                                      prefixText: L.of(context).phoneNumber,
                                      initialValue: sessionState
                                          .contactInformation!
                                          .credentialSubject
                                          .phoneNumber,
                                      buttonText:
                                          L.of(context).updatePhoneNumber,
                                    ),
                                  ),
                                );
                                /* setState(() {}); */
                              },
                              child: Text(
                                L.of(context).edit,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
