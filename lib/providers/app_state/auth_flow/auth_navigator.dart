import 'package:digital_identity/screen/auth/create/create.dart';
import 'package:digital_identity/screen/auth/introduction/introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            //display introduction page
            if (state == AuthState.introduction)
              const MaterialPage(
                child: Introduction(),
              ),
            //allow push Animation and display creation
            if (state == AuthState.creation) ...[
              MaterialPage(
                child: Create(),
              ),
            ]
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
