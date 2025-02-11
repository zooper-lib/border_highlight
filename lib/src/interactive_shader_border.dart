import 'dart:ui';

import 'package:flutter/material.dart';

import 'global_pointer.dart';
import 'shader_border_painter.dart';

class InteractiveShaderBorder extends StatefulWidget {
  final Widget child;
  final double baseWidth;
  final double threshold;
  final double borderRadius;
  final Color highlightColor;

  const InteractiveShaderBorder({
    super.key,
    required this.child,
    this.baseWidth = 3.0,
    this.threshold = 100.0,
    this.borderRadius = 8.0,
    this.highlightColor = Colors.blue,
  });

  @override
  State<InteractiveShaderBorder> createState() =>
      _InteractiveShaderBorderState();
}

class _InteractiveShaderBorderState extends State<InteractiveShaderBorder> {
  FragmentProgram? program;

  @override
  void initState() {
    super.initState();
    FragmentProgram.fromAsset('shaders/border_highlight.frag').then((prog) {
      setState(() {
        program = prog;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalPointer = GlobalPointerData.of(context)?.pointer ?? Offset.zero;
    final renderBox = context.findRenderObject() as RenderBox?;
    final localPointer = renderBox != null
        ? renderBox.globalToLocal(globalPointer)
        : globalPointer;

    return CustomPaint(
      painter: program != null
          ? ShaderBorderPainter(
              pointer: localPointer,
              highlightWidth: widget.baseWidth,
              borderRadius: widget.borderRadius,
              threshold: widget.threshold,
              highlightColor: widget.highlightColor,
              program: program!,
            )
          : null,
      child: widget.child,
    );
  }
}
