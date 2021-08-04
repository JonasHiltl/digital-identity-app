import 'package:digital_identity/providers/app_settings/app_settings.dart';
import 'package:digital_identity/providers/create_did/create_did.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../theme.dart';
import '../../../../generated/l10n.dart';

class Step2 extends StatefulWidget {
  const Step2({Key? key, required this.formKeys, required this.dateController})
      : super(key: key);
  final List<GlobalKey<FormState>> formKeys;
  final TextEditingController dateController;

  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  void setSex(String? value) {
    setState(() {
      context.read<CreateDidBloc>().add(
            SexChanged(
              sex: value.toString(),
            ),
          );
    });
  }

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
                            L.of(context).createHeader2,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: kSmallPadding,
                          ),
                          Text(
                            L.of(context).createSubheader2,
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CreateDidBloc, CreateDidState>(
                      builder: (context, state) {
                        return Form(
                          key: widget.formKeys[1],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                onTap: () => DatePicker.showDatePicker(
                                  context,
                                  locale: context
                                              .read<AppSettingsBloc>()
                                              .state
                                              .language ==
                                          "en"
                                      ? LocaleType.en
                                      : LocaleType.de,
                                  onConfirm: (date) {
                                    context.read<CreateDidBloc>().add(
                                          DateOfBirthChanged(dateOfBirth: date),
                                        );
                                    widget.dateController.text =
                                        DateFormat.yMMMd().format(
                                      date.toLocal(),
                                    );
                                  },
                                  currentTime: state.dateOfBirth != null
                                      ? state.dateOfBirth
                                      : DateTime.now(),
                                  theme: DatePickerTheme(
                                    itemStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 16,
                                    ),
                                    doneStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                    ),
                                    cancelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 16,
                                        height: 1.5),
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                  ),
                                ),
                                controller: widget.dateController,
                                cursorWidth: 1,
                                readOnly: true,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: kSmallPadding,
                                    ),
                                    child: Text(
                                      L.of(context).dateOfBirth,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.6),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: kSmallPadding),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? kTextFieldLightBorder
                                          : kTextFieldDarkBorder,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? kTextFieldLightBorder
                                          : kTextFieldDarkBorder,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? kLightAccentBG
                                      : kDarkAccentBG,
                                ),
                              ),
                              const SizedBox(
                                height: kMediumPadding,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? kLightAccentBG
                                                    : kDarkAccentBG,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? kTextFieldLightBorder
                                                  : kTextFieldDarkBorder,
                                            ),
                                          ),
                                          child: Row(children: [
                                            Radio(
                                              value: "female",
                                              groupValue: context
                                                  .read<CreateDidBloc>()
                                                  .state
                                                  .sex,
                                              onChanged: setSex,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(L.of(context).female),
                                          ]),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: kSmallPadding,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? kLightAccentBG
                                                    : kDarkAccentBG,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? kTextFieldLightBorder
                                                  : kTextFieldDarkBorder,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: "male",
                                                groupValue: context
                                                    .read<CreateDidBloc>()
                                                    .state
                                                    .sex,
                                                onChanged: setSex,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Text(L.of(context).male),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: kMediumPadding,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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
