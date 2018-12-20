import 'package:flutter/material.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';
import 'dart:math' as math;

class CarouselCard extends TweenContainer {
  TweenData data;
  List<TweenMe> tweens = [];

  int posId;
  int index;

  final double duration; // in seconds
  final double delay;
  final bool autoplay;
  final int repeat;
  final Curve ease;
  final Widget child;
  final VoidCallback onComplete;
  final OnUpdateCallback onUpdate;

  CarouselCard({
    Key key, 
    this.posId,
    this.index,
    this.data,
    this.duration,
    this.delay,
    this.autoplay = true,
    this.repeat = 0,
    this.ease,
    this.child,
    this.onComplete,
    this.onUpdate,
  });
}

class DepthCarousel extends StatefulWidget {
  final String title = "Depth Carousel";
  @override
    DepthCarouselState createState(){
      DepthCarouselState state = DepthCarouselState();
      return state;
  }
}

class DepthCarouselState extends State<DepthCarousel> {

  int currentIndex = 0;
  List<CarouselCard> cards = [];

  double cardHeight = 320;
  double cardWidth = 320;
  double initTop = 200;
  double spacing = 20;

  int totalDisplayedItem = 3;
  int totalItem = 10;
    
  TweenContainer buildCard(int index, int posId){
    double scale = 1 - 0.15 * posId;
    double opacity = 1 - 1/totalDisplayedItem * posId;
    double top = initTop - (spacing * posId);

    if(scale < 0) scale = 0;
    if(opacity > 1) opacity = 0;
    if(opacity < 0) opacity = 0;
    
    if(posId < 0){
      top = initTop + spacing;
    }

    if(posId >= totalDisplayedItem){
      top = initTop + spacing * totalDisplayedItem;
    }

    int randInt = math.Random().nextInt(100000);

    return CarouselCard(
      posId: posId,
      index: index,
      data: TweenData(
        width: cardWidth,
        height: cardHeight,
        color: Colors.black,
        // border: Border.all(color: Colors.white),
        transformOrigin: Offset(0.5, 0.0),
        scale: Offset(scale, scale),
        top: top,
        opacity: opacity,
      ),
      child: Stack(
        children: <Widget>[
          Image(
            fit: BoxFit.cover,
            image: NetworkImage("https://loremflickr.com/320/320?random=$randInt"),
          ),
          Center(
            child: Text(
              "${index+1}", 
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold
              )
            )
          )
        ],
      )
    );
  }

  @override
    void initState() {
      // print("INIT");
      init();
      
      super.initState();
    }

  @override
    void dispose() {
      super.dispose();
    }

  @override
    void didUpdateWidget(DepthCarousel oldWidget) {
      init();  

      super.didUpdateWidget(oldWidget);
    }

  void init(){
    currentIndex = 0;
    cards = [];

    for(int i=0; i < totalItem; i++){
      cards.add(
        buildCard(i, i)
      );
    }
    cards = cards.reversed.toList();
  }

  void next(){
    slideTo(currentIndex+1);
  }

  void prev(){
    slideTo(currentIndex-1);
  }

  void slideTo(int index){
    int newIndex = index;
    if(index > totalItem - 1) newIndex = totalItem - 1;
    if(index < 0) newIndex = 0;

    int diffIndex = newIndex - currentIndex;
    currentIndex = newIndex;

    cards.forEach((CarouselCard card){
      card.posId -= diffIndex;
      
      double scale = 1 - 0.15 * card.posId;
      double opacity = 1 - 1/totalDisplayedItem * card.posId;
      double top = initTop - (spacing * card.posId);

      if(opacity > 1) opacity = 0;
      if(opacity < 0) opacity = 0;
      
      TweenMe.to(
        card,
        duration: 0.5,
        ease: Curves.ease,
        data: TweenData(
          top: top,
          opacity: opacity,
          scale: Offset(scale, scale),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget content = Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: cards,
            )
          ),

          // controller buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: Text("FIRST"),
                color: Colors.blue,
                onPressed: (){
                  slideTo(0);
                },
              ),
              
              // spacing
              SizedBox(width: 5),

              FlatButton(
                child: Icon(Icons.arrow_back, color: Colors.white),
                color: Colors.blue,
                onPressed: prev,
              ),
              
              // spacing
              SizedBox(width: 5),

              FlatButton(
                child: Icon(Icons.arrow_forward, color: Colors.white),
                color: Colors.blue,
                onPressed: next,
              ),

              // spacing
              SizedBox(width: 5),

              FlatButton(
                child: Text("LAST"),
                color: Colors.blue,
                onPressed: (){
                  slideTo(totalItem-1);
                },
              ),
            ],
          ),
          SizedBox(height: 30,)
        ],
      )
      
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: content,
      // backgroundColor: Colors.black,
    );
  }
}
