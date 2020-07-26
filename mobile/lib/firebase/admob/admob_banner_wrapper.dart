import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';

class AdmobBannerWrapper extends StatefulWidget {
  final String adUnitId;
  final AdmobBannerSize adSize;
  final Function(AdmobAdEvent, Map<String, dynamic>) listener;

  AdmobBannerWrapper(
      {Key key, @required this.adUnitId, @required this.adSize, this.listener})
      : super(key: key);

  @override
  AdmobBannerWrapperState createState() => AdmobBannerWrapperState();
}

class AdmobBannerWrapperState extends State<AdmobBannerWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AdmobBanner(
      adUnitId: widget.adUnitId,
      adSize: widget.adSize,
      listener: widget.listener,
    );
  }
}
