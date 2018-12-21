import 'package:flutter/material.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';
import 'package:flutter_tweenme/tweenme/tween_easing.dart';

class BasicExample extends StatelessWidget {

  final String title = "Basic Example";

  @override
  Widget build(BuildContext context) {
    
    TweenContainer tweenContainer = TweenContainer(
      data: TweenData(
        top: 100, 
        left: 100,
        width: 100,
        height: 100,
        color: Colors.red
      ),
      child: Center(child: Text("Hello Friends!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)))
    );

    Widget content = Container(
      // color: Colors.black,
      child: Stack(
        children: [
          // tween container
          Align(
            alignment: Alignment.center,
            child: tweenContainer
          ),
          
          // button
          Align(
            alignment: Alignment(0, 0.8),
            child: Wrap(
              spacing: 10,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.arrow_back, color: Colors.white),
                  color: Colors.blue,
                  onPressed: (){
                    TweenMe.killTweensOf(tweenContainer);
                    TweenMe.to(
                      tweenContainer,
                      duration: 1,
                      ease: Curves.fastOutSlowIn,
                      data: TweenData(
                        // width: 100,
                        // height: 100,
                        rotation: 0,
                        scale: Offset(1, 1),
                        opacity: 1,
                        color: Colors.red,
                        // border: Border.all(color: Colors.white, width: 1)
                      ),
                    );

                    tweenContainer.set(TweenData(color: Colors.red));
                  },
                ),

                FlatButton(
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                  color: Colors.blue,
                  onPressed: (){
                    TweenMe.killTweensOf(tweenContainer);
                    TweenMe.to(
                      tweenContainer,
                      duration: 0.5,
                      data: TweenData(
                        opacity: 0.5,
                        // width: 250,
                        // height: 250,
                        rotation: 180,
                        scale: Offset(3, 3),
                        // transformOrigin: Offset(0.5, 0.5),
                        color: Colors.blue
                      ),
                      ease: Curves.ease,
                      // repeat: -1,
                      // yoyo: true,
                    );
                  },
                ),

                FlatButton(
                  child: Text("HIDE/SHOW", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: (){
                    // show & hide container:
                    tweenContainer.set(TweenData(
                      visible: !tweenContainer.data.visible
                    ));
                  },
                ),

                
              ],
            )
            
          )
          
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
