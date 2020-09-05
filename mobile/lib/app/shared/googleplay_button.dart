import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'rateapp/rateapp_service.dart';

class GooglePlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: FaIcon(FontAwesomeIcons.googlePlay),
        onPressed: () async {
          RateAppService.openPlayStore(context);
        },
      ),
    );
  }
}
