import 'package:flutter/material.dart';

import 'rateapp_service.dart';

enum LikeState { NEW, LIKED, DISLIKED, DONE }

class RateApp extends StatefulWidget {
  @override
  _RateAppState createState() => _RateAppState();
}

class _RateAppState extends State<RateApp> {
  static final int _animationDuration = 600;
  LikeState _likeState = LikeState.NEW;
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
        decoration: BoxDecoration(color: theme.accentColor),
        child: FutureBuilder<bool>(
            future: RateAppService.shouldDisplayRateDialog(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData || !snapshot.data) {
                return SizedBox();
              } else {
                return AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: _animationDuration),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => _handeClose(),
                            child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('X')),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Column(children: [
                              Text(_getHeaderText(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _getNegativeButton(theme),
                                  _getPositiveButton(theme),
                                ],
                              )
                            ])),
                      ],
                    ));
              }
            }));
  }

  void _updateLikedState(LikeState newLikedState) {
    setState(() {
      _likeState = newLikedState;
    });
  }

  Widget _getNegativeButton(ThemeData theme) {
    return RaisedButton(
      child: Text(_getNegativeText()),
      color: theme.accentColor,
      onPressed: () async {
        _handleButtonClick(false);
      },
    );
  }

  Widget _getPositiveButton(ThemeData theme) {
    return RaisedButton(
      child: Text(
        _getPositiveText(),
        style: TextStyle(color: theme.accentColor, fontWeight: FontWeight.bold),
      ),
      color: Colors.white,
      onPressed: () async {
        _handleButtonClick(true);
      },
    );
  }

  void _handleButtonClick(bool positiveClick) async {
    switch (_likeState) {
      case LikeState.NEW:
        await _changeOpacity();
        Future.delayed(Duration(milliseconds: _animationDuration), () {
          _updateLikedState(
              positiveClick ? LikeState.LIKED : LikeState.DISLIKED);
        });
        break;
      case LikeState.LIKED:
      case LikeState.DISLIKED:
        _updateLikedState(LikeState.DONE);
        _handleNextOpenTime();
        if (positiveClick) {
          RateAppService.openPlayStore(context);
        }
        break;
      default:
        break;
    }
  }

  void _handeClose() {
    RateAppService.setOpenLater();
    _updateLikedState(LikeState.DONE);
  }

  void _handleNextOpenTime() {
    if (_likeState == LikeState.LIKED) {
      // if user is liking the app, let's ask the same question in some time (default 2 weeks)
      RateAppService.setOpenLater();
    } else {
      // if user is not liking the app, let's not ask ever again :)
      RateAppService.setNeverOpen();
    }
  }

  void _changeOpacity() async {
    await setState(() {
      _opacity = 0;
    });
    Future.delayed(Duration(milliseconds: _animationDuration), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  String _getHeaderText() {
    switch (_likeState) {
      case LikeState.LIKED:
        return 'Que bom! Que tal nos avaliar na Play Store?';
      case LikeState.DISLIKED:
        return 'Poxa, que pena. Pode dizer como nós podemos melhorar?';
      default:
        return 'Você está gostando do Uai Mangás?';
    }
  }

  String _getPositiveText() {
    switch (_likeState) {
      case LikeState.LIKED:
        return 'Claro!';
      case LikeState.DISLIKED:
        return 'Vamos lá';
      default:
        return 'Estou adorando!';
    }
  }

  String _getNegativeText() {
    switch (_likeState) {
      case LikeState.LIKED:
      case LikeState.DISLIKED:
        return 'Não, obrigado';
      default:
        return 'Não muito';
    }
  }
}
