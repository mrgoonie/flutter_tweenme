import 'package:flutter/material.dart';

class TweenData {
  bool visible;
  double top, left, right, bottom, width, height, opacity, rotation;
  Offset transformOrigin, scale;
  EdgeInsetsGeometry margin, padding;
  Color color;
  BorderRadius borderRadius;
  Border border;
  DecorationImage backgroundImage;

  TweenData({
    this.visible,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.rotation,
    this.margin,
    this.padding,
    this.border,
    this.borderRadius,
    this.transformOrigin,
    this.scale,
    this.backgroundImage
  });

  TweenData clone(){
    return TweenData(
      visible: visible,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      rotation: rotation,
      margin: margin,
      padding: padding,
      border: border,
      borderRadius: borderRadius,
      transformOrigin: transformOrigin,
      scale: scale,
      backgroundImage: backgroundImage
    );
  }
}