library tweenme;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tweenme/tweenme/tween_data.dart';
import 'package:flutter_tweenme/tweenme/tween_container.dart';
import 'package:flutter_tweenme/tweenme/tween_easing.dart';

// Exports:
export 'package:flutter_tweenme/tweenme/tween_data.dart';
export 'package:flutter_tweenme/tweenme/tween_container.dart';
export 'package:flutter_tweenme/tweenme/tween_easing.dart';

typedef void OnUpdateCallback(double progress);
typedef void OnCompleteCallback(TweenContainer target);

class TweenMe implements TickerProvider {
  /// Creates a tween that apply on a targeted TweenContainer.
  ///
  /// The [target] argument must not be null.
  /// 
  TweenMe(
    this.target, {
    this.data,
    this.duration = 1,
    this.delay = 0,
    this.yoyo = false,
    this.autoplay = true,
    this.repeat = 0,
    this.ease,
    this.onComplete,
    this.onUpdate,
  }){
    _init();
  }

  final TweenContainer target;
  final TweenData data;
  final double duration; // in seconds
  final double delay;
  final bool autoplay;
  final bool yoyo;
  final int repeat;
  final Curve ease;
  final OnCompleteCallback onComplete;
  final OnUpdateCallback onUpdate;

  Ticker _ticker;

  TweenData _oldData;

  AnimationController _controller;
  Animation<double> _animation;
  Animation<Color> _animationColor;
  Animation<BorderRadius> _animationBorderRadius;
  Animation<EdgeInsets> _animationPadding;
  Animation<EdgeInsets> _animationMargin;
  Animation<Border> _animationBorder;
  
  @override
    Ticker createTicker(onTick) {
      _ticker = Ticker(onTick);
      return _ticker;
    }
  
  /// Create a new tween animation on a specific `TweenContainer target` with many options.
  static TweenMe to(
    TweenContainer target,
    {
      TweenData data,
      double duration,
      double delay,
      int repeat = 0,
      bool autoplay = true,
      bool yoyo = false,
      Curve ease,
      OnCompleteCallback onComplete,
      OnUpdateCallback onUpdate,
    }
  ){
    TweenMe tween = TweenMe(
      target,
      data: data,
      duration: duration,
      delay: delay,
      repeat: repeat,
      yoyo: yoyo,
      autoplay: autoplay,
      ease: ease,
      onComplete: onComplete,
      onUpdate: onUpdate
    );

    target.add(tween);

    return tween;
  }

  /// Disposed (kill) all the current tweens of a specific `TweenContainer target`.
  static killTweensOf(TweenContainer target){
    target.dispose();
  }

  void _init() {
    _oldData = (target.data == null) ? TweenData() : target.data.clone();

    if(data.transformOrigin != null) target.data.transformOrigin = data.transformOrigin;

    int speed = (duration != null) ? (duration * 1000).toInt() : 1000;
    
    _controller = AnimationController(
      duration: Duration(milliseconds: speed), 
      vsync: this
    );

    Curve tweenEase = (ease == null) ? Ease.ease : ease;
    CurvedAnimation curve = CurvedAnimation(parent: _controller, curve: tweenEase);

    // Animations

    if(data.color != null){
      _animationColor = ColorTween(begin: target.data.color, end: data.color).animate(curve);
      _animationColor.addListener(_onColorAnimating);
    }

    if(data.border != null){
      _animationBorder = BorderTween(begin: target.data.border, end: data.border).animate(curve);
      _animationBorder.addListener(_onBorderAnimating);
    }

    if(data.borderRadius != null){
      _animationBorderRadius = BorderRadiusTween(begin: target.data.borderRadius, end: data.borderRadius).animate(curve);
      _animationBorderRadius.addListener(_onBorderRadiusAnimating);
    }

    if(data.padding != null){
      _animationPadding = EdgeInsetsTween(begin: target.data.padding, end: data.padding).animate(curve);
      _animationPadding.addListener(_onPaddingAnimating);
    }

    if(data.margin != null){
      _animationMargin = EdgeInsetsTween(begin: target.data.margin, end: data.margin).animate(curve);
      _animationMargin.addListener(_onMarginAnimating);
    }

    _animation = Tween(begin: 0.0, end: 1.0).animate(curve);
    _animation.addStatusListener(_onAnimationStatus);
    _animation.addListener(_onAnimating);

    // 

    if(autoplay){
      if(delay != null){
        Future.delayed(Duration(milliseconds: (delay * 1000).toInt() ), play);
      } else {
        play();
      }
    }
  }

  void _onAnimating(){
    double progress = _animation.value;

    if(data.top != null) {
      if(_oldData.top == null) _oldData.top = 0;
      target.data.top = _oldData.top + progress * (data.top - _oldData.top);
    }
    if(data.left != null) {
      if(_oldData.left == null) _oldData.left = 0;
      target.data.left = _oldData.left + progress * (data.left - _oldData.left);
    }
    if(data.right != null) {
      if(_oldData.right == null) _oldData.right = 0;
      target.data.right = _oldData.right + progress * (data.right - _oldData.right);
    }
    if(data.bottom != null) {
      if(_oldData.bottom == null) _oldData.bottom = 0;
      target.data.bottom = _oldData.bottom + progress * (data.bottom - _oldData.bottom);
    }
    
    if(data.width != null) target.data.width = _oldData.width + progress * (data.width - _oldData.width);
    if(data.height != null) target.data.height = _oldData.height + progress * (data.height - _oldData.height);
    if(data.opacity != null) target.data.opacity = _oldData.opacity + progress * (data.opacity - _oldData.opacity);
    if(data.rotation != null) target.data.rotation = _oldData.rotation + progress * (data.rotation - _oldData.rotation);

    if(data.scale != null) {
      target.data.scale = Offset(
        _oldData.scale.dx + progress * (data.scale.dx - _oldData.scale.dx), 
        _oldData.scale.dy + progress * (data.scale.dy - _oldData.scale.dy)
      );
    }
    
    // print("Current size: $currentWidth x $currentHeight");
    
    target.update();

    if(onUpdate != null) onUpdate(progress);
  }

  void _onColorAnimating(){
    target.data.color = _animationColor.value;
  }

  void _onBorderAnimating(){
    target.data.border = _animationBorder.value;
  }

  void _onBorderRadiusAnimating(){
    target.data.borderRadius = _animationBorderRadius.value;
  }

  void _onPaddingAnimating(){
    target.data.padding = _animationPadding.value;
  }

  void _onMarginAnimating(){
    target.data.margin = _animationMargin.value;
  }

  void _onAnimationStatus(status){
    // print("a");
    if (status == AnimationStatus.completed) {
      if(onComplete != null){
        onComplete(target);
      }

      if(repeat == 0){
        target.killTween(this);
      } else {
        if(yoyo){
          _controller.reverse();
        } else {
          _controller.reset();
          target.data = _oldData.clone();
          target.update();
        }
      }
    } else if (status == AnimationStatus.dismissed) {
      // print("dismissed");
      if(repeat != 0) _controller.forward();
    }
  }

  /// Stop (paused) playing the tween animation.
  TweenMe stop(){
    if(_controller != null) _controller.stop();
    return this;
  }

  /// Start playing the tween animation.
  TweenMe play(){
    if(_controller != null) _controller.forward();
    return this;
  }

  /// Seek the the tween animation to the specific progress position.
  ///
  /// The `timeScalePosition` argument must not be null. It gives the animation progress from 0.0 to 1.0
  TweenMe seek(double timeScalePosition){
    if(_controller != null){
      if(timeScalePosition > 1) timeScalePosition = 1;
      if(timeScalePosition < 0) timeScalePosition = 0;
      _controller.value = timeScalePosition;
    }
    return this;
  }

  /// Disposed (kill) the tween animation.
  void dispose() {
    _controller.dispose();
    _ticker.dispose();
  }

}

