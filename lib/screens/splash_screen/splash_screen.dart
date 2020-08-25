import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/screens/base/base_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  final sizeTween = Tween<double>(begin: 0, end: 400);
  final opacityTween = Tween<double>(begin: 0.5, end: 1);

//  String _anim = "carrinho";
  String _anim = "bonesSales";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: const [
                Color.fromARGB(255, 46, 92, 138),
                Color.fromARGB(255, 95, 168, 211),
                Color.fromARGB(255, 98, 182, 203),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Opacity(
            opacity: opacityTween.evaluate(animation),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Text(
                    "Boas compras",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                Container(
                  width: sizeTween.evaluate(animation),
                  height: sizeTween.evaluate(animation),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.greenAccent,

                    shape: BoxShape.circle,
                  ),
                  child: FlareActor(
                    "assets/bonesSales.flr",
                    animation: _anim,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 6)).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => BaseScreen(),
      ));
    });

    //valores da animação
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation =
        CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut)
          ..addListener(() {
            setState(() {});
          });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
