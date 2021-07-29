import 'package:digital_identity/global_components/minimal_change_language.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:digital_identity/providers/create_did/create_did.dart';
import 'package:digital_identity/screen/auth/create/steps/step2.dart';
import 'package:digital_identity/screen/auth/create/steps/step3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme.dart';
import 'step_indicator.dart';
import 'steps/step1.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final TextEditingController dateController = TextEditingController();
  final PageController _pageController = PageController();
  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  Future next() async {
    setState(() {
      index = index + 1;
    });
  }

  void back() {
    if (index > 0) {
      setState(() {
        index = index - 1;
      });
    } else {
      context.read<AuthCubit>().showIntroduction();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CreateDidRepository(),
      child: BlocProvider<CreateDidBloc>(
        create: (context) => CreateDidBloc(
          repo: context.read<CreateDidRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kSmallPadding,
                horizontal: kMediumPadding,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: back,
                        icon: Icon(Icons.arrow_back),
                      ),
                      MinimalChangeLanguage(),
                    ],
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: index,
                      children: [
                        Step1(formKeys: formKeys),
                        Step2(
                            formKeys: formKeys, dateController: dateController),
                        Step3(formKeys: formKeys),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: kSmallPadding),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              kSmallPadding * 2,
                          child: BlocBuilder<CreateDidBloc, CreateDidState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state.formStatus is FormSubmitting ||
                                        index == 0 &&
                                            (!state.isValidFirstName ||
                                                !state.isValidlastName) ||
                                        index == 1 &&
                                            (!state.isValidDateOfBirth ||
                                                !state.isValidSex) ||
                                        index == 2 &&
                                            (!state.isValidAddress ||
                                                !state.isValidCity ||
                                                !state.isValidState ||
                                                !state.isValidPostalCode ||
                                                !state.isValidPostalCode ||
                                                !state.isValidCountry)
                                    ? null
                                    : index == 2
                                        ? () => context
                                            .read<CreateDidBloc>()
                                            .add(Submitted())
                                        : next,
                                child: Text("Create"),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: kSmallPadding + 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: StepIndicator(index: index),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
