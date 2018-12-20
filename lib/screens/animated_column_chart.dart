import 'package:flutter/material.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';
import 'dart:math' as math;

class AnimatedColumnChart extends StatelessWidget {

  final String title = "Animated Column Chart";

  @override
  Widget build(BuildContext context) {
    
    TweenContainer redBar = TweenContainer(
      data: TweenData(
        width: 100,
        height: 50,
        color: Colors.red
      ),
      child: Icon(Icons.star, color: Colors.white)
    );

    TweenContainer blueBar = TweenContainer(
      data: TweenData(
        width: 100,
        height: 50,
        color: Colors.blue
      ),
      child: Icon(Icons.local_airport, color: Colors.white)
    );

    Widget content = Container(
      padding: EdgeInsets.only(bottom: 50),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    // color: Colors.red,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        redBar
                      ],
                    ),
                  )
                ),
                Expanded(
                  child: Container(
                    // color: Colors.blue,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        blueBar
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),

          SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "Animate the bar randomly!", 
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                color: Colors.blue,
                onPressed: (){
                  TweenMe.killTweensOf(redBar);
                  TweenMe.to(
                    redBar,
                    duration: 0.8,
                    ease: Curves.ease,
                    data: TweenData(
                      height: 50 + 400 * math.Random().nextDouble()
                    )
                  );

                  TweenMe.killTweensOf(blueBar);
                  TweenMe.to(
                    blueBar,
                    duration: 0.8,
                    ease: Curves.ease,
                    data: TweenData(
                      height: 50 + 400 * math.Random().nextDouble()
                    )
                  );
                },
              ),
            ],
          )
        ],
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
