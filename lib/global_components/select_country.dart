import 'package:digital_identity/data/countries.dart';
import 'package:digital_identity/global_components/universal_text_field.dart';
import 'package:digital_identity/theme.dart';
import 'package:flutter/material.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({Key? key, required this.onTap}) : super(key: key);
  final Function(String) onTap;

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  List<CustomCountry> suggestion = countries;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "All Countries (${countries.length})",
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kMediumPadding,
                vertical: kSmallPadding,
              ),
              child: UniversalTextField(
                prefixText: "Search",
                onChanged: (value) => setState(
                  () {
                    suggestion = getCountrySuggestion(value);
                  },
                ),
              ),
            ),
            Expanded(
                child: ListView(
              physics: BouncingScrollPhysics(),
              children: suggestion
                  .map(
                    (country) => InkWell(
                      onTap: () {
                        widget.onTap(country.code);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kMediumPadding,
                          vertical: kSmallPadding / 2,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: NetworkImage(
                                    country.flagUrl,
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: kSmallPadding,
                            ),
                            Text(
                              country.name,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ))
          ],
        ),
      ),
    );
  }
}
