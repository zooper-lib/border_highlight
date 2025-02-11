import 'package:flutter/material.dart';

import 'global_pointer.dart';

class GlobalPointerTracker extends StatefulWidget {
  final Widget child;

  const GlobalPointerTracker({super.key, required this.child});

  @override
  State<GlobalPointerTracker> createState() => _GlobalPointerTrackerState();
}

class _GlobalPointerTrackerState extends State<GlobalPointerTracker> {
  Offset? _pointer;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (event) => setState(() => _pointer = event.position),
      onPointerDown: (event) => setState(() => _pointer = event.position),
      onPointerMove: (event) => setState(() => _pointer = event.position),
      child: GlobalPointerData(
        pointer: _pointer,
        child: widget.child,
      ),
    );
  }
}
