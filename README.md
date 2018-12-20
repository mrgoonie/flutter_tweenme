# TweenMe for Flutter

A tween library framework for Flutter project, inspired from TweenMax (https://greensock.com/).

https://www.youtube.com/watch?v=5bfqgPPCdjA

![alt text](https://raw.githubusercontent.com/mrgoonie/flutter_tweenme/master/logo.jpg "TweenMe for Flutter")

## Introduction

If you're a Javascript or Actionscript developer, you probably know **TweenMax** - this is an awesome tween library developed by GreenSock team, which have a huge support for doing animation. 

Animated Widgets in Flutter are great, but I find them not very familiar and customizable. Since TweenMax hasn't been available for Flutter, so I tried to write an alternative version - I named it **TweenMe**!

## Installation
1. Depend on it
Add this to your package's pubspec.yaml file:
```
dependencies:
  tweenme: ^0.1.4
```
2. Install it
You can install packages from the command line:

with Flutter:

`$ flutter packages get`

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.

3. Import it
Now in your Dart code, you can use:

`import 'package:tweenme/tweenme.dart';`

## Important notes:
Firstly, you need to be aware of **TweenContainer**, this is an universal widget.
**TweenMe** can only apply to **TweenContainer**.

**TweenContainer** can be placed within any widgets in the widget tree of your app. 
But if put it inside a **FlexRenderContainer** (such as Row, Column), then you tween the value of positions (such as "top", "left",..), it won't work! 

## How to use:

```
TweenContainer tweenableContainer = TweenContainer(
  // initial data:
  data: TweenData(
    width: 100,
    height: 100,
    color: Colors.red
  ),
  // child: Text("Hello")
);

// plug this container into your widget tree:
// ...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          tweenableContainer,

          Align(
                  alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: Icon(Icons.arrow_back, color: Colors.white),
              color: Colors.blue,
              onPressed: (){
                // then apply a TweenMe when you want to animate it:
                TweenMe.to(
                  tweenableContainer, 
                  duration: 1, // in seconds
                  ease: Curves.ease, // ease type
                  // animate "tweenableContainer" to this data:
                  data: TweenData(
                    top: 300,
                    width: 250,
                    height: 250,
                    color: Colors.yellow
                  ),
                );
              },
            )
          ), // Align
        ]
      )
    );
  }
// ...

```

Looks familiar, eh?

## More examples can be found here: 
https://github.com/mrgoonie/flutter_tweenme/tree/master/lib/screens

## Which data of TweenContainer that you can animate?

For now, it supports:
- left *(double)*
- right *(double)*
- top *(double)*
- bottom *(double)*
- width *(double)*
- height *(double)*
- opacity *(double)*
- color *(Color)*
- rotation *(double) -> in degrees* 
- scale *(Offset)*
- margin *(EdgeInsetsGeometry)*
- padding *(EdgeInsetsGeometry)*
- border *(Border)*
- borderRadius *(BorderRadius)*

## TweenMe properties & methods:

### Properties ###

- duration *(double) -> duration of tween in seconds*
- data *(TweenData) -> destination tween data*
- ease *(Curve) -> animation ease type*
- delay *(double) -> in seconds*
- repeat *(int) -> number of tween repeat*
- yoyo *(bool) -> default is false, if it's "true", the animation will be reversed once it completed*

### Callback ###

- onUpdate(progress) *(void)*
- onComplete(target) *(void)*

#### Example: ####
```
TweenMe.to(
  tweenableContainer, 
  duration: 1, 
  ease: Curves.ease,
  data: TweenData(
    top: 300,
    width: 250,
    height: 250,
    color: Colors.yellow
  ),
  onUpdate: (progress){
    print("My progress is $progress");
  },
  onComplete: (target){
    print("I'm done!");
  }
);
```

### TweenMe Methods ###

- play()
- stop()
- seek(timeScalePosition)
- dispose()

#### Example of controlling the tween: ####

To control the tween, you can do this:

```

TweenMe myTween = TweenMe.to(
  myTweenableContainer,
  duration: 1,
  autoplay: false, // make this tween stopped at the beginning
  data: TweenData(
    rotation: 180
  )
);

// when you want "myTween" to start, just do this:
myTween.play();

// if you want to stop "myTween":
myTween.stop();

// if you want to seek "myTween" at some time scale position:
myTween.seek(0.5);

// dispose the tween:
myTween.dispose();

```

## TweenContainer

You want to update the color, opacity, transformation or position of **TweenContainer** instantly? Here you go:

```
TweenContainer myContainer = TweenContainer(
  data: TweenData(
    width: 200,
    height: 200,
    color: Colors.red
  )
);

// Let update the color of this container after 2 seconds:
Future.delayed(Duration(milliseconds: 2000), (){
  tweenContainer.set(TweenData(color: Colors.blue));
});

```
Easy, right?

The **TweenContainer** can kill all the applied tweens itself, with:
```
myContainer.dispose();
```

## Extra Eases:

(Yes, TweenMe has more eases than Flutter)

Beside the default curves of Flutter: 

- Ease.linear *(same with Curves.linear)*
- Ease.decelerate *(same with Curves.decelerate)*
- Ease.ease *(same with Curves.ease)*
- Ease.easeOut *(same with Curves.easeOut)*
- Ease.easeIn *(same with Curves.easeIn)*
- Ease.easeInOut *(same with Curves.easeInOut)*
- Ease.fastOutSlowIn *(same with Curves.fastOutSlowIn)*
- Ease.bounceIn *(same with Curves.bounceIn)*
- Ease.bounceOut *(same with Curves.bounceOut)*
- Ease.bounceInOut *(same with Curves.bounceInOut)*
- Ease.elasticOut *(same with Curves.elasticOut)*
- Ease.elasticIn *(same with Curves.elasticIn)*
- Ease.elasticInOut *(same with Curves.elasticInOut)*

You also can use:
- Ease.backIn
- Ease.backOut
- Ease.backInOut
- Ease.slowMo
- Ease.sineIn
- Ease.sineOut
- Ease.sineInOut

Check this example to understand more about eases: https://github.com/mrgoonie/flutter_tweenme/tree/master/lib/screens/easing_example.dart

## Error report:
**This plugin hasn't been fully tested. Use as your own risk!**
Please report issues for further improvement.