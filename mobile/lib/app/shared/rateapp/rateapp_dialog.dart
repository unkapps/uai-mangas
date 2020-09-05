import 'package:flutter/material.dart';

import 'rateapp_service.dart';

enum LikeState { NEW, LIKED, DISLIKED, DONE }

class RateappDialog extends StatefulWidget {
  @override
  _RateappDialogState createState() => _RateappDialogState();
}

class _RateappDialogState extends State<RateappDialog> {
  LikeState likeState = LikeState.NEW;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
        decoration: BoxDecoration(color: theme.accentColor),
        child: FutureBuilder<bool>(
            future: RateAppService.shouldDisplayRateDialog(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData || !snapshot.data) {
                return SizedBox.shrink();
              } else {
                return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      Text(getHeaderText(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text(getNotFavorableText()),
                            color: theme.accentColor,
                            onPressed: () {
                              if (likeState == LikeState.NEW) {
                                updateLikedState(LikeState.DISLIKED);
                              } else {
                                updateLikedState(LikeState.DONE);
                                RateAppService.setOpenLater();
                              }
                            },
                          ),
                          RaisedButton(
                            child: Text(
                              getFavorableText(),
                              style: TextStyle(
                                  color: theme.accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              if (likeState == LikeState.NEW) {
                                updateLikedState(LikeState.LIKED);
                              } else {
                                updateLikedState(LikeState.DONE);
                                RateAppService.setNeverOpen();
                                RateAppService.openPlayStore(context);
                              }
                            },
                          ),
                        ],
                      )
                    ]));
              }
            }));
  }

  void updateLikedState(LikeState newLikedState) {
    setState(() {
      likeState = newLikedState;
    });
  }

  String getHeaderText() {
    switch (likeState) {
      case LikeState.LIKED:
        return 'Que bom! Que tal nos avaliar na Play Store?';
      case LikeState.DISLIKED:
        return 'Poxa, que pena. Pode dizer como nós podemos melhorar?';
      default:
        return 'Você está gostando do Uai Mangás?';
    }
  }

  String getFavorableText() {
    switch (likeState) {
      case LikeState.LIKED:
        return 'Claro!';
      case LikeState.DISLIKED:
        return 'Vamos lá';
      default:
        return 'Estou adorando!';
    }
  }

  String getNotFavorableText() {
    switch (likeState) {
      case LikeState.LIKED:
      case LikeState.DISLIKED:
        return 'Não, obrigado';
      default:
        return 'Não muito';
    }
  }
}
