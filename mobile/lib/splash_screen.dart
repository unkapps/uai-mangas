import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage(
                'assets/images/splashscreen.png',
              ),
              fit: BoxFit.fill,
              alignment: Alignment.bottomRight,
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: SizedBox(
                width: 20,
                height: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(46, 46, 46, 1)),
                    strokeWidth: 7,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
