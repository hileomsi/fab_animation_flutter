import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedFab extends StatefulWidget {
  final Function onPressed;

  const AnimatedFab({Key key, this.onPressed}) : super(key: key);

  @override
  _AnimatedFabState createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Color> colorAnimation;

  final double expandedSize = 180.0;
  final double hiddenSize = 20.0;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    colorAnimation = ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: expandedSize,
      width: expandedSize,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildExpandedBackground(),
              buildOption(Icons.check_circle, 0.0),
              buildOption(Icons.flash_on, -math.pi / 3),
              buildOption(Icons.access_time, -2 * math.pi / 3),
              buildOption(Icons.error_outline, math.pi),
              buildFab(),
            ],
          );
        },
      ),
    );
  }

  Widget buildFab() {
    double scaleFactor = 2 * (animationController.value - 0.5).abs();

    return FloatingActionButton(
      onPressed: onFabPressed,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(1.0, scaleFactor),
        child: Icon(
          animationController.value > 0.5 ? Icons.close : Icons.filter_list,
          color: Colors.white,
          size: 26.0,
        ),
      ),
      backgroundColor: colorAnimation.value,
    );
  }

  Widget buildExpandedBackground() {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * animationController.value;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  Widget buildOption(IconData icon, double angle) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: animationController,
        child: Transform.rotate(
          angle: angle,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: IconButton(
                onPressed: widget.onPressed,
                icon: Transform.rotate(
                  angle: -angle,
                  child: Icon(
                    icon,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                iconSize: 26.0,
                alignment: Alignment.center,
                padding: EdgeInsets.all(0.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  open() {
    if (animationController.isDismissed) {
      animationController.forward();
    }
  }

  close() {
    if (animationController.isCompleted) {
      animationController.reverse();
    }
  }

  onFabPressed() {
    if (animationController.isDismissed) {
      open();
    } else {
      close();
    }
  }
}
