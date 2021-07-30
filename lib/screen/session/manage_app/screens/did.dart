import 'package:digital_identity/global_components/own_qr_image.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:digital_identity/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class Did extends StatelessWidget {
  const Did({Key? key}) : super(key: key);

  void _launchURL(url) async => await launch(url);

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "DID",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding,
            vertical: kSmallPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Your Decentralized Identifier",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: kMediumPadding,
                  ),
                  Text(
                    "Scan this QR code to share your ",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    "Decentralized Identifier.",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: when did is shariable change qr code data bac kto only the did id
                  OwnQrImage(
                      data:
                          "https://explorer.iota.org/mainnet/message/${sessionState.did!.messageId}"),
                  SizedBox(
                    height: kSmallPadding,
                  ),
                  GestureDetector(
                      onTap: () => _launchURL(
                          "https://explorer.iota.org/mainnet/message/${sessionState.did!.messageId}"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "View DID on Ledger",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 16,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    icon: Icon(
                      Icons.copy,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      sessionState.did!.id,
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
