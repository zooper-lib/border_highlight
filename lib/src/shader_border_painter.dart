import 'dart:ui';

import 'package:flutter/material.dart';

class ShaderBorderPainter extends CustomPainter {
  final Offset? pointer;
  final double highlightWidth;
  final double borderRadius;
  final double threshold;
  final Color highlightColor;
  final FragmentProgram program;

  ShaderBorderPainter({
    required this.pointer,
    required this.highlightWidth,
    required this.borderRadius,
    required this.threshold,
    required this.highlightColor,
    required this.program,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (pointer == null) return;
    final shader = program.fragmentShader();

    // Uniform 0: u_resPointer (vec4)
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, pointer!.dx);
    shader.setFloat(3, pointer!.dy);

    // Uniform 1: u_borderParams (vec3): (highlightWidth, borderRadius, threshold)
    shader.setFloat(4, highlightWidth);
    shader.setFloat(5, borderRadius);
    shader.setFloat(6, threshold);

    // Uniform 2: u_highlightColor (vec4)
    shader.setFloat(7, highlightColor.r / 255.0);
    shader.setFloat(8, highlightColor.g / 255.0);
    shader.setFloat(9, highlightColor.b / 255.0);
    shader.setFloat(10, highlightColor.a / 255.0);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant ShaderBorderPainter oldDelegate) {
    return oldDelegate.pointer != pointer ||
        oldDelegate.highlightWidth != highlightWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.threshold != threshold ||
        oldDelegate.highlightColor != highlightColor;
  }
}
