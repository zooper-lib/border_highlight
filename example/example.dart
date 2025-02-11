import 'package:border_highlight/src/global_pointer_tracker.dart';
import 'package:border_highlight/src/interactive_shader_border.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GlobalPointerTracker(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Pointer Tracker Example',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Pointer Tracker Example'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: InteractiveShaderBorder(
              borderRadius: 16,
              highlightColor: Colors.red,
              child: SizedBox(
                height: 200,
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
