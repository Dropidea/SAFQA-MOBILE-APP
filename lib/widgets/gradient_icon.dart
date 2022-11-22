import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.2,
      height: size * 1.2,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          final Rect rect = Rect.fromLTRB(0, 0, size, size);
          return gradient.createShader(rect);
        },
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
    );
  }
}
