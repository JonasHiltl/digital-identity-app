import 'package:digital_identity/global_components/universal_text_field.dart';
import 'package:digital_identity/providers/create_did/create_did.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme.dart';
import '../../../../generated/l10n.dart';

class Step1 extends StatelessWidget {
  const Step1({Key? key, required this.formKeys}) : super(key: key);
  final List<GlobalKey<FormState>> formKeys;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight - 70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: kMediumPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              L.of(context).createHeader,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: kSmallPadding,
                            ),
                            Text(
                              L.of(context).createSubheader1,
                            ),
                          ],
                        )),
                    Form(
                      key: formKeys[0],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UniversalTextField(
                            prefixText: L.of(context).firstName,
                            onChanged: (value) => context
                                .read<CreateDidBloc>()
                                .add(FirstNameChanged(firstName: value)),
                          ),
                          const SizedBox(
                            height: kMediumPadding,
                          ),
                          UniversalTextField(
                            prefixText: L.of(context).lastName,
                            onChanged: (value) =>
                                context.read<CreateDidBloc>().add(
                                      LastNameChanged(lastName: value),
                                    ),
                          ),
                          const SizedBox(
                            height: kMediumPadding,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
