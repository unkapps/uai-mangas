import 'package:flutter/cupertino.dart';
import 'package:leitor_manga/app/shared/util/url_helper.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateAppService {
  static final String _SHARED_KEY = 'nextTimeToOpen';
  static final int _MIN_DAYS_APP_USAGE = 7;
  static Future<bool> _shouldDisplayDialog = initialize();

  static Future<bool> initialize() async {
    var instance = await SharedPreferences.getInstance();

    // uncomment for dev purposes so that it always open
    // await _setOpenAt(DateTime.now().subtract(Duration(days: 1)));

    if (!instance.containsKey(_SHARED_KEY)) {
      // first time reaching here, let's ask for review in some days
      _setOpenAt(DateTime.now().add(Duration(days: _MIN_DAYS_APP_USAGE)));
    } else {
      var nextTimeToOpen = DateTime.parse(instance.get(_SHARED_KEY));
      if (DateTime.now().difference(nextTimeToOpen).inDays >= 0) {
        return true;
      }
    }
    return false;
  }

  static void setNeverOpen() async {
    _setOpenAt(DateTime.utc(9999, DateTime.december, 31));
    _shouldDisplayDialog = Future.value(false);
  }

  static void setOpenLater() async {
    _setOpenAt(DateTime.now().add(Duration(days: _MIN_DAYS_APP_USAGE * 2)));
    _shouldDisplayDialog = Future.value(false);
  }

  static void _setOpenAt(DateTime datetime) async {
    var instance = await SharedPreferences.getInstance();
    unawaited(instance.setString(_SHARED_KEY, datetime.toIso8601String()));
  }

  static void openPlayStore(BuildContext context) async {
    var protocolUrl = 'market://details?id=com.unkapps.uai_mangas';
    var fallbackUrl =
        'https://play.google.com/store/apps/details?id=com.unkapps.uai_mangas';
    await UrlHelper.launchUrl(protocolUrl, fallbackUrl);
  }

  static Future<bool> shouldDisplayRateDialog() async {
    return await _shouldDisplayDialog;
  }
}
