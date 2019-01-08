import 'dart:math' as math;
import 'package:flutter/animation.dart';

/// A collection of common animation easing.
class Ease {
  static const Curve linear = Curves.linear;
  static const Curve decelerate = Curves.decelerate;
  static const Curve ease = Curves.ease;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve bounceInOut = Curves.bounceInOut;
  static const Curve elasticIn = Curves.elasticIn;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve elasticInOut = Curves.elasticInOut;
  // new easing:
  static const Curve backOut = BackOutCurve();
  static const Curve backIn = BackInCurve();
  static const Curve backInOut = BackInOutCurve();
  static const Curve slowMo = SlowMoCurve();
  static const Curve sineOut = SineOutCurve();
  static const Curve sineIn = SineInCurve();
  static const Curve sineInOut = SineInOutCurve();
}

/// An oscillating curve that shrinks in magnitude while overshooting its bounds.
///
/// An instance of this class using the default period of 0.4 is available as
/// [Ease.backOut].
///
class BackOutCurve extends Curve {
  /// Creates an back-out curve.
  ///
  /// Rather than creating a new instance, consider using [Ease.backOut].
  const BackOutCurve([this.period = 0.4]);

  /// The duration of the oscillation.
  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    // final double s = period / 4.0;
    final double _p1 = 1.70158;
    // final double _p2 = _p1 * 1.525;
    final double result = ((t = t - 1) * t * ((_p1 + 1) * t + _p1) + 1);
    return result;
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}

/// An oscillating curve that shrinks in magnitude while overshooting its bounds.
///
/// An instance of this class using the default period of 0.4 is available as
/// [Ease.backIn].
///
class BackInCurve extends Curve {
  /// Creates an back-in curve.
  ///
  /// Rather than creating a new instance, consider using [Ease.backIn].
  const BackInCurve([this.period = 0.4]);

  /// The duration of the oscillation.
  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    // final double s = period / 4.0;
    final double _p1 = 1.70158;
    // final double _p2 = _p1 * 1.525;
    final double result = t * t * ((_p1 + 1) * t - _p1);
    return result;
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}

/// An oscillating curve that shrinks in magnitude while overshooting its bounds.
///
/// An instance of this class using the default period of 0.4 is available as
/// [Ease.backInOut].
///
class BackInOutCurve extends Curve {
  /// Creates an back-in curve.
  ///
  /// Rather than creating a new instance, consider using [Ease.backInOut].
  const BackInOutCurve([this.period = 0.4]);

  /// The duration of the oscillation.
  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    // final double s = period / 4.0;
    final double _p1 = 1.70158;
    final double _p2 = _p1 * 1.525;
    final double result = ((t *= 2) < 1) ? 0.5 * t * t * ((_p2 + 1) * t - _p2) : 0.5 * ((t -= 2) * t * ((_p2 + 1) * t + _p2) + 2);
    return result;
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}

/// An oscillating curve that shrinks in magnitude while overshooting its bounds.
///
/// An instance of this class using the default period of 0.4 is available as
/// [Ease.slowMo].
///
class SlowMoCurve extends Curve {
  /// Creates an slow-mo curve.
  ///
  /// Rather than creating a new instance, consider using [Ease.slowMo].
  const SlowMoCurve([this.power = 0.7]);

  /// The duration of the oscillation.
  final double power;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    final double linearRatio = 0.7;
    final double _p = power;
    final double _p1 = (1 - linearRatio) / 2;
    final double _p2 = linearRatio;
    final double _p3 = _p1 + _p2;
    final double r = t + (0.5 - t) * _p;
    double result = r;
    if (t < _p1) {
      result = r - ((t = 1 - (t / _p1)) * t * t * t * r);
    } else if (t > _p3) {
      result = r + ((t - r) * (t = (t - _p3) / _p1) * t * t * t); 
    }
    return result;
  }

  @override
  String toString() {
    return '$runtimeType($power)';
  }
}

/// An oscillating curve that shrinks in magnitude while overshooting its bounds.
///
/// An instance of this class using the default period of 0.4 is available as
/// [Ease.sineOut].
///
class SineOutCurve extends Curve {
  /// Creates an sine-out curve.
  ///
  /// Rather than creating a new instance, consider using [Ease.sineOut].
  const SineOutCurve();

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    final double haftPi = math.pi / 2;
    final double result = math.sin(t * haftPi);
    return result;
  }

  @override
  String toString() {
    return '$runtimeType()';
  }
}

/// An oscillating curve that shrinks in magnitude while overshooting its bounds.
///
/// An instance of this class using the default period of 0.4 is available as
/// [Ease.sineIn].
///
class SineInCurve extends Curve {
  /// Creates an sine-in curve.
  ///
  /// Rather than creating a new instance, consider using [Ease.sineIn].
  const SineInCurve();

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    final double haftPi = math.pi / 2;
    final double result = -math.cos(t * haftPi) + 1;
    return result;
  }

  @override
  String toString() {
    return '$runtimeType()';
  }
}

/// An oscillating curve that shrinks in magnitude while overshooting its bounds.
///
/// An instance of this class using the default period of 0.4 is available as
/// [Ease.sineInOut].
///
class SineInOutCurve extends Curve {
  /// Creates an sine-in-out curve.
  ///
  /// Rather than creating a new instance, consider using [Ease.sineInOut].
  const SineInOutCurve();

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    final double result = -0.5 * (math.cos(math.pi * t) - 1);
    return result;
  }

  @override
  String toString() {
    return '$runtimeType()';
  }
}