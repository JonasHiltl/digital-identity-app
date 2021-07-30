import 'dart:io' show Platform;

import 'package:digital_identity/screen/session/manage_app/screens/did.dart';
import 'package:digital_identity/screen/session/manage_app/screens/personal_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_identity/providers/app_settings/app_settings.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:page_transition/page_transition.dart';

import '../../../generated/l10n.dart';
import '../../../db/secure_storage.dart';
import '../../../theme.dart';
import 'components/delete_all_button.dart';
import 'components/grouped_tile.dart';
import 'screens/language.dart';

class ManageApp extends StatefulWidget {
  @override
  _ManageAppState createState() => _ManageAppState();
}

class _ManageAppState extends State<ManageApp> {
  final SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionState>();
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          // if floating is true the appbar becomes instantly visible if scrolled towards top
          // if it's false the appbar is only visible if completly scrolled back to top
          floating: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            "Manage App",
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        SliverToBoxAdapter(
          child: GroupedTile(
            title: L.of(context).digitalIdentity,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    curve: Curves.easeInOut,
                    child: const Did(),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kMediumPadding,
                    vertical: kSmallPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            size: 22,
                          ),
                          const SizedBox(
                            width: kSmallPadding,
                          ),
                          Text(
                            "DID",
                            style: Theme.of(context).textTheme.headline6,
                          )
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    curve: Curves.easeInOut,
                    child: PersonalDataScreen(),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kMediumPadding,
                    vertical: kSmallPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 22,
                          ),
                          const SizedBox(
                            width: kSmallPadding,
                          ),
                          Text(
                            L.of(context).personalData,
                            style: Theme.of(context).textTheme.headline6,
                          )
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kMediumPadding,
                    vertical: kSmallPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 22,
                          ),
                          const SizedBox(
                            width: kSmallPadding,
                          ),
                          Text(
                            L.of(context).contactInformation,
                            style: Theme.of(context).textTheme.headline6,
                          )
                        ],
                      ),
                      Icon(
                        sessionState.contactInformation == null
                            ? Icons.add
                            : Icons.chevron_right,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: kSmallPadding,
          ),
        ),
        SliverToBoxAdapter(
          child: GroupedTile(
            title: L.of(context).security,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kMediumPadding,
                  vertical: kSmallPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.fingerprint,
                          size: 22,
                        ),
                        const SizedBox(
                          width: kSmallPadding,
                        ),
                        Text(
                          Platform.isIOS
                              ? L.of(context).touchId
                              : L.of(context).fingerprint,
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                    BlocBuilder<AppSettingsBloc, AppSettingsState>(
                      builder: (context, state) {
                        return Platform.isIOS
                            ? Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: state.useTouchID,
                                  onChanged: (value) => showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: Text(
                                          state.useTouchID
                                              ? L.of(context).disableTouchID
                                              : L.of(context).activateTouchID,
                                        ),
                                        content: Text(
                                          state.useTouchID
                                              ? L.of(context).disableTouchIDText
                                              : L.of(context).touchIDText,
                                        ),
                                        actions: [
                                          CupertinoDialogAction(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(L.of(context).no),
                                          ),
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              context
                                                  .read<AppSettingsBloc>()
                                                  .add(
                                                    TouchIDChanged(
                                                      useTouchID:
                                                          !state.useTouchID,
                                                    ),
                                                  );
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              L.of(context).yes,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 15,
                                child: Switch(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: state.useTouchID,
                                  onChanged: (value) => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          state.useTouchID
                                              ? L.of(context).disableFingerprint
                                              : L
                                                  .of(context)
                                                  .activateFingerprint,
                                        ),
                                        content: Text(
                                          state.useTouchID
                                              ? L
                                                  .of(context)
                                                  .disableFingerprintText
                                              : L.of(context).fingerprintText,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              L.of(context).no,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<AppSettingsBloc>()
                                                  .add(
                                                    TouchIDChanged(
                                                      useTouchID:
                                                          !state.useTouchID,
                                                    ),
                                                  );
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              L.of(context).yes,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: GroupedTile(
            title: L.of(context).preferences,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    curve: Curves.easeInOut,
                    child: const LanguageScreen(),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kMediumPadding,
                    vertical: kSmallPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.language_outlined,
                            size: 22,
                          ),
                          const SizedBox(
                            width: kSmallPadding,
                          ),
                          Text(
                            L.of(context).language,
                            style: Theme.of(context).textTheme.headline6,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          BlocBuilder<AppSettingsBloc, AppSettingsState>(
                            builder: (context, state) {
                              return Text(
                                state.language == "en" ? "English" : "Deutsch",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                    ),
                              );
                            },
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kMediumPadding,
                  vertical: kSmallPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          size: 22,
                        ),
                        const SizedBox(
                          width: kSmallPadding,
                        ),
                        Text(
                          L.of(context).darkMode,
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                    BlocBuilder<AppSettingsBloc, AppSettingsState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 22,
                          child: Platform.isIOS
                              ? Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: state.themeData == AppTheme.dark,
                                    onChanged: (value) =>
                                        context.read<AppSettingsBloc>().add(
                                              ThemeChanged(
                                                theme: state.themeData ==
                                                        AppTheme.dark
                                                    ? AppTheme.light
                                                    : AppTheme.dark,
                                              ),
                                            ),
                                  ),
                                )
                              : Switch(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: state.themeData == AppTheme.dark,
                                  onChanged: (value) =>
                                      context.read<AppSettingsBloc>().add(
                                            ThemeChanged(
                                              theme: state.themeData ==
                                                      AppTheme.dark
                                                  ? AppTheme.light
                                                  : AppTheme.dark,
                                            ),
                                          ),
                                ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kMediumPadding, vertical: kSmallPadding),
            child: DeleteAllButton(),
          ),
        )
      ],
    );
  }
}
