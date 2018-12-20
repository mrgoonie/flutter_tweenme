import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spring Box",
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    TweenContainer redContainer = TweenContainer(
      data: TweenData(
        top: 40,
        width: 20.0,
        height: 20.0,
        color: Colors.red,
      ),
    );

    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: 100.0,
          height: 100.0,
          margin: EdgeInsets.only(top: 100, left: 100),
          color: Colors.yellow,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              redContainer
            ],
          )
        ),
        onTap: (){
          // click first time, animate "redContainer" to bottom:
          if(!isClicked){
            TweenMe.to(
              redContainer,
              duration: 0.3,
              ease: Curves.ease,
              data: TweenData(
                top: 80
              )
            );
          } else { // click second time, animate "redContainer" to top:
            TweenMe.to(
              redContainer,
              duration: 0.2,
              ease: Curves.easeIn,
              data: TweenData(
                top: 0
              ),
              onComplete: (redContainer){
                // animate it back to center position:
                TweenMe.to(
                  redContainer,
                  duration: 0.8,
                  ease: ElasticOutCurve(0.3),
                  data: TweenData(
                    top: 40
                  )
                );
              }
            );
          }
          isClicked = !isClicked;
        },
      )
    );
  }
}
