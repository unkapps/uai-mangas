import 'package:flutter/cupertino.dart';
import 'package:leitor_manga/changelog/changelog_dialog.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangelogService {
  static String SHARED_KEY = 'lastVersionOpen';

  static Future<void> openDialogFirstTime(
      BuildContext context, int currentVersionCode) async {
    var instance = await SharedPreferences.getInstance();
    var versionCodeOnPreferences = 0;

    if (instance.containsKey(SHARED_KEY)) {
      versionCodeOnPreferences = int.parse(instance.get(SHARED_KEY));
    }

    if (currentVersionCode > versionCodeOnPreferences) {
      await ChangelogDialog.open(context);
      unawaited(instance.setString(SHARED_KEY, '$currentVersionCode'));
    }
  }
}
