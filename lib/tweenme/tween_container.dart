import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_tweenme/tweenme/tweenme.dart';

/// A widget that can be targeted by a [TweenMe] class.
/// This is an universal widget that can be placed inside any other widgets.
class TweenContainer extends StatefulWidget {
  /// Creates a new tween-able container widget that can apply `TweenMe`.
  ///
  /// The [data] argument must not be null.
  /// 
  TweenContainer({
    Key key, 
    this.data,
    this.child,
  }) : super(
    key: key
  );

  /// Hold all transformation & position data of the container.
  TweenData data;

  TweenContainerState _state;
  List<TweenMe> _tweens = [];

  /// The child contained by this container.
  final Widget child;

  /// The state from the closest instance of this class that encloses the given context.
  static TweenContainerState of(BuildContext context){
    return context.ancestorStateOfType(TypeMatcher<TweenContainerState>());
  }

  /// Update the new values of `data` to this container.
  void update(){
    _state?.update();
  }

  /// Dispose a specific tween on this container.
  void killTween(TweenMe tween){
    int index = _tweens.indexOf(tween);
    tween.dispose();
    _tweens.removeAt(index);
  }

  /// Add a new tween to this container's list.
  void add(TweenMe tween){
    _tweens.add(tween);
  }

  /// Dispose this container and all of its tweens.
  void dispose(){
    if(_tweens.length > 0){
      for(int i=0; i<_tweens.length; i++){
        _tweens[i].dispose();
      }
      _tweens = [];
    }
    _state?.dispose();
  }

  @override
    TweenContainerState createState(){
      _state = new TweenContainerState();
      return _state;
  }
}

class TweenContainerState extends State<TweenContainer> {
  String parentRenderType;

  TweenData data;

  bool shouldSetPosition = false;
  
  @override
    void initState() {

      data = widget.data;

      // get parent widget type:
      parentRenderType = context.ancestorRenderObjectOfType(TypeMatcher<RenderObject>()).runtimeType.toString();
      // print("parentRenderType = $parentRenderType");

      shouldSetPosition = (parentRenderType == "RenderStack");
      // print("shouldSetPosition: $shouldSetPosition");

      if(data.opacity == null || data.opacity > 1) data.opacity = 1;
      if(data.opacity < 0) data.opacity = 0;
      if(data.rotation == null) data.rotation = 0;
      if(data.transformOrigin == null) data.transformOrigin = Offset(0.5, 0.5);
      if(data.scale == null) data.scale = Offset(1, 1);
      
      // check for exceptions:

      if(data.left != null && data.right != null && data.width != null){
        data.width = null;
        print('[TweenContainer] If you used "left" and "right", the value of "width" will have no effects.');
      }

      if(data.top != null && data.bottom != null && data.height != null){
        data.height = null;
        print('[TweenContainer] If you used "top" and "bottom", the value of "height" will have no effects.');
      }

      super.initState();
    }

  @override
    void dispose() {
      // print("disposed");
      super.dispose();
    }

  @override
    void didUpdateWidget(TweenContainer oldWidget) {
      widget._state = this;

      // get parent widget type:
      parentRenderType = context.ancestorRenderObjectOfType(TypeMatcher<RenderObject>()).runtimeType.toString();
      shouldSetPosition = (parentRenderType == "RenderStack");
      // print("parentRenderType = $parentRenderType");

      data = widget.data;
      if(data.opacity == null || data.opacity > 1) data.opacity = 1;
      if(data.opacity < 0) data.opacity = 0;
      if(data.rotation == null) data.rotation = 0;
      if(data.transformOrigin == null) data.transformOrigin = Offset(0.5, 0.5);
      if(data.scale == null) data.scale = Offset(1, 1);

      if(data.left != null && data.right != null && data.width != null){
        data.width = null;
        print('[TweenContainer] If you used "left" and "right", the value of "width" will have no effects.');
      }

      if(data.top != null && data.bottom != null && data.height != null){
        data.height = null;
        print('[TweenContainer] If you used "top" and "bottom", the value of "height" will have no effects.');
      }

      // print("[UPDATE] Current size: ${data.width} x ${data.height}");
      
      super.didUpdateWidget(oldWidget);
    }

  void update(){
    if(mounted){
      setState(() {
        data = widget.data;

        if(data.opacity == null || data.opacity > 1) data.opacity = 1;
        if(data.opacity < 0) data.opacity = 0;
        if(data.rotation == null) data.rotation = 0;
        if(data.scale == null) data.scale = Offset(1, 1);
        // if(data.transformOrigin == null) data.transformOrigin = Offset(0.5, 0.5);

        if(shouldSetPosition && data.left != null && data.right != null) data.width = null;
        if(shouldSetPosition && data.top != null && data.bottom != null) data.height = null;
        // print("[UPDATE] => Current size: ${data.width} x ${data.height}");
      });
    }
  }

  Widget build(BuildContext context) {
    
    Widget container;
    Widget myChild;

    Widget wrapper = Container(
      width: data.width,
      height: data.height,
      padding: data.padding,
      margin: data.margin,
      decoration: BoxDecoration(
        color: data.color,
        border: data.border,
        borderRadius: data.borderRadius,
        image: data.backgroundImage
      ),
      child: widget.child
    );

    myChild = Transform(
      alignment: FractionalOffset(data.transformOrigin.dx, data.transformOrigin.dy),
      transform: Matrix4.rotationZ(data.rotation * math.pi / 180)..scale(data.scale.dx, data.scale.dy),
      child: Opacity(
        opacity: data.opacity,
        child: wrapper
      )
    );

    if(parentRenderType == "RenderFlex" || parentRenderType == "RenderPositionedBox"){
      container = myChild;
    } else {
      container = Positioned(
        top: data.top,
        left: data.left,
        right: data.right,
        bottom: data.bottom,
        width: data.width,
        height: data.height,
        child: myChild
      );
    }

    return container;
  }
}
