import 'package:digital_identity/data/countries.dart';
import 'package:digital_identity/global_components/universal_text_field.dart';
import 'package:digital_identity/global_components/select_country.dart';
import 'package:digital_identity/providers/create_did/create_did.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../theme.dart';
import '../../../../generated/l10n.dart';

class Step3 extends StatefulWidget {
  const Step3({Key? key, required this.formKeys}) : super(key: key);
  final List<GlobalKey<FormState>> formKeys;

  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  final TextEditingController controller = TextEditingController();

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
                  minHeight: viewportConstraints.maxHeight,
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
                            L.of(context).createHeader3,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: kSmallPadding,
                          ),
                          Text(
                            L.of(context).createSubheader3,
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: widget.formKeys[2],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UniversalTextField(
                            keyboardType: TextInputType.streetAddress,
                            prefixText: L.of(context).streetNumber,
                            onChanged: (value) => context
                                .read<CreateDidBloc>()
                                .add(AddressChanged(address: value)),
                          ),
                          const SizedBox(
                            height: kMediumPadding,
                          ),
                          UniversalTextField(
                            keyboardType: TextInputType.number,
                            prefixText: L.of(context).postalCode,
                            onChanged: (value) => context
                                .read<CreateDidBloc>()
                                .add(PostalCodeChanged(postalCode: value)),
                          ),
                          const SizedBox(
                            height: kMediumPadding,
                          ),
                          UniversalTextField(
                            prefixText: L.of(context).city,
                            onChanged: (value) => context
                                .read<CreateDidBloc>()
                                .add(CityChanged(city: value)),
                          ),
                          const SizedBox(
                            height: kMediumPadding,
                          ),
                          UniversalTextField(
                            prefixText: L.of(context).state,
                            onChanged: (value) => context
                                .read<CreateDidBloc>()
                                .add(StateChanged(state: value)),
                          ),
                          const SizedBox(
                            height: kMediumPadding,
                          ),
                          UniversalTextField(
                            readOnly: true,
                            prefixText: L.of(context).country,
                            controller: controller,
                            onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                child: SelectCountry(
                                  onTap: (value) {
                                    context
                                        .read<CreateDidBloc>()
                                        .add(CountryChanged(country: value));

                                    controller.text =
                                        getCountryByCode(value).name;
                                    WidgetsBinding
                                        .instance?.focusManager.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                                curve: Curves.easeInOut,
                                type: PageTransitionType.bottomToTop,
                              ),
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
