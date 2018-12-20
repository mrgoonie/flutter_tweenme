import 'package:flutter/material.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';

class YoyoExample extends StatelessWidget {

  final String title = "Yoyo Example";

  @override
  Widget build(BuildContext context) {
    
    List<TweenContainer> items = [];

    for(int i=0; i<4; i++){
      TweenContainer item = TweenContainer(
        data: TweenData(
          top: 100 + 110.0 * i, 
          left: 10,
          width: 100,
          height: 100,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(50)
        ),
        child: Icon(Icons.star, color: Colors.white)
      );

      items.add(item);

      TweenMe.to(
        item, 
        duration: 1, 
        ease: Curves.easeInOut,
        repeat: -1,
        yoyo: true,
        delay: 0.1 * i,
        data: TweenData(
          left: 300
        )
      );
    }

    Widget content = Container(
      child: Stack(
        children: items,
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
