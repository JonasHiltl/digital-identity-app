import 'package:digital_identity/screen/startup_screen.dart';

import 'session_flow/session_state.dart';
import 'session_flow/session_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'auth_flow/auth_cubit.dart';
import 'auth_flow/auth_navigator.dart';
import 'session_flow/session_navigator.dart';
import 'session_flow/session_status.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        return state.sessionStatus is Unverified
            ? BlocProvider(
                create: (context) => AuthCubit(
                  context.read<SessionBloc>(),
                ),
                child: AuthNavigator(),
              )
            : state.sessionStatus is Verified
                ? Provider.value(
                    value: state,
                    child: SessionNavigator(),
                  )
                : StartupScreen();
        //show auth flow

        //show session flow

        //onPopPage: (route, result) => route.didPop(result),
      },
    );
  }
}
