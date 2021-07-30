import 'package:device_preview/device_preview.dart';
import 'package:digital_identity/screen/auth/create/create.dart';
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import './providers/app_settings/app_settings.dart';
import 'providers/app_state/app_state.dart';

import "generated/l10n.dart";
import 'screen/auth/introduction/introduction.dart';
import 'theme.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferencesInit();
  runApp(
    /* DevicePreview(
      plugins: const [FileExplorerPlugin(), ScreenshotPlugin()],
      builder: (context) =>  */
    MyApp(),
    /* enabled: !kReleaseMode,
    ), */
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => SessionRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppSettingsBloc>(
            create: (context) => AppSettingsBloc(
              language: getLanguage(),
              theme: getTheme(),
              useTouchID: getUseTouchID(),
            ),
          ),
          BlocProvider<SessionBloc>(
            create: (context) => SessionBloc(
              repo: context.read<SessionRepo>(),
              appSettingsState: context.read<AppSettingsBloc>().state,
            )..add(
                AttemptGettingSavedState(),
              ),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              context.read<SessionBloc>(),
            ),
          ),
        ],
        child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, state) {
            return MaterialApp(
              title: "Flutter Demo",
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              theme: appTheme[state.themeData],
              localizationsDelegates: const [
                L.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: L.delegate.supportedLocales,
              locale: Locale(state.language),
              home: AppNavigator(),
              routes: {
                "/introduction": (context) => const Introduction(),
                "/create": (context) => Create(),
              },
            );
          },
        ),
      ),
    );
  }
}
