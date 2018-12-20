import 'package:flutter/material.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';

/// An image widget that can be targeted by a [TweenMe] class.
/// This is an universal widget that can be placed inside any other widgets.
/// Can be used to load "asset" image and network image.
/// It also contains animate in & out effects.
/// 
class TweenImage extends TweenContainer {
  /// Creates a new tween-able image container widget that can apply `TweenMe`.
  ///
  /// The [data] argument must not be null.
  /// 
  TweenImage({
    Key key, 
    Widget child,
    TweenData data,
  }) : super(
    key: key,
    data: data,
    child: child
  );

  
}
