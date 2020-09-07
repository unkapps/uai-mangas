import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<void> launchUrl(String protocolUrl, String fallbackUrl) async {
    if (await canLaunch(protocolUrl)) {
      await launch(protocolUrl);
    } else {
      await launch(fallbackUrl);
    }
  }
}
