import 'package:flutter/material.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';

class EasingExample extends StatelessWidget {

  final String title = "All Eases of TweenMe";

  @override
  Widget build(BuildContext context) {

    TweenContainer tweenContainer = TweenContainer(
      data: TweenData(
        top: 200, 
        left: 20,
        width: 100,
        height: 100,
        borderRadius: BorderRadius.circular(15),
        color: Colors.red
      ),
      child: Icon(Icons.star, color: Colors.white, size: 50)
    );

    double deviceWidth = MediaQuery.of(context).size.width;
    double toLeft = deviceWidth - tweenContainer.data.width - 20;

    void reset(){
      TweenMe.killTweensOf(tweenContainer);
      tweenContainer.set(TweenData(
        left: 20
      ));
    }

    void startTween(Curve ease, {double duration = 1}){
      reset();
      TweenMe.to(tweenContainer, duration: duration, ease: ease, data: TweenData(left: toLeft));
    }

    Widget content = Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  runSpacing: 5,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("ease", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.ease);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("easeOut", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.easeOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("easeIn", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.easeIn);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("easeInOut", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.easeInOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("fastOutSlowIn", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.fastOutSlowIn);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("bounceIn", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.bounceIn);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("bounceOut", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.bounceOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("bounceInOut", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.bounceInOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("elasticIn", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.elasticIn);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("elasticOut", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.elasticOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("elasticInOut", style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: (){
                        startTween(Ease.elasticInOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("backOut", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: (){
                        startTween(Ease.backOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("backIn", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: (){
                        startTween(Ease.backIn);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("backInOut", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: (){
                        startTween(Ease.backInOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("slowMo", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: (){
                        startTween(Ease.slowMo, duration: 2);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("sineOut", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: (){
                        startTween(Ease.sineInOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("sineIn", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: (){
                        startTween(Ease.sineInOut);
                      },
                    ),

                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("sineInOut", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: (){
                        startTween(Ease.sineInOut);
                      },
                    ),

                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 10),
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: Stack(
                children: [
                  // tween container
                  tweenContainer,
                ],
              ),
            ),
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
