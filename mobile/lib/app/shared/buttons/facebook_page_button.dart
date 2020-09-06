import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FacebookPageButton extends StatelessWidget {
  const FacebookPageButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: FaIcon(FontAwesomeIcons.facebookSquare),
        onPressed: () async {
          var fbProtocolUrl = 'fb://page/100278801776406';
          var fallbackUrl = 'https://facebook.com/uaimangas';

          if (await canLaunch(fbProtocolUrl)) {
            await launch(fbProtocolUrl);
          } else {
            await launch(fallbackUrl);
          }
        },
      ),
    );
  }
}
