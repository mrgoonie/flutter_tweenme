import 'package:flutter/material.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';

class CountingNumber extends StatefulWidget {
  _CountingNumberState _state;
  @override
    _CountingNumberState createState(){
      _state = new _CountingNumberState();
      return _state;
  }
}

class _CountingNumberState extends State<CountingNumber> {

  final String title = "Counting Number with eases";

  final int countTo = 100;
  int count = 0;

  TweenContainer numberHolder;
  TweenContainer emptyContainer;

  @override
    void initState() {
      super.initState();
    }

  @override
    void dispose() {
      if(numberHolder != null) numberHolder.dispose();
      if(emptyContainer != null) emptyContainer.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {

    numberHolder = TweenContainer(
      data: TweenData(
        top: 100, 
        left: 100,
        width: 200,
        height: 200,
        color: Colors.red,
        borderRadius: BorderRadius.circular(100)
      ),
      child: Center(child: Text("$count", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold)))
    );

    emptyContainer = TweenContainer(
      data: TweenData(top: 0),
    );

    Widget content = Container(
      child: Stack(
        children: [
          // container
          Align(
            alignment: Alignment.center,
            child: numberHolder
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
                    TweenMe.killTweensOf(emptyContainer);
                    TweenMe.to(
                      emptyContainer,
                      duration: 3,
                      ease: Ease.easeOut,
                      data: TweenData(
                        top: 100,
                      ),
                      onUpdate: (progress){
                        setState(() {
                          count = countTo - (countTo * progress).toInt();
                        });
                      }
                    );
                  },
                ),

                FlatButton(
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                  color: Colors.blue,
                  onPressed: (){
                    TweenMe.killTweensOf(emptyContainer);
                    TweenMe.to(
                      emptyContainer,
                      duration: 3,
                      ease: Ease.easeOut,
                      data: TweenData(
                        top: 100,
                      ),
                      onUpdate: (progress){
                        setState(() {
                          count = (countTo * progress).toInt();
                        });
                      }
                    );
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
