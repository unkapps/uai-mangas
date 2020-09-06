import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscordButton extends StatelessWidget {
  const DiscordButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: FaIcon(FontAwesomeIcons.discord),
        onPressed: () async {
          var url = 'https://discord.gg/Kz9NYF';

          await launch(url);
        },
      ),
    );
  }
}
