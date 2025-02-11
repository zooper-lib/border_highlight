import 'package:flutter/material.dart';

class GlobalPointerData extends InheritedWidget {
  final Offset? pointer;

  const GlobalPointerData({
    super.key,
    required this.pointer,
    required super.child,
  });

  static GlobalPointerData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GlobalPointerData>();

  @override
  bool updateShouldNotify(covariant GlobalPointerData oldWidget) =>
      oldWidget.pointer != pointer;
}
