# border_highlight

**Interactive border highlight for Flutter using custom shaders.**

---

## Overview

`border_highlight` provides an easy way to add interactive, pointer-based border highlighting effects to any widget.
Leveraging a custom fragment shader, this package renders smooth, high-performance border highlights that respond to
pointer position.

---

## Features

- **Interactive Highlights:** The border highlights react dynamically based on the pointer's position.
- **Customizable Appearance:** Adjust the border properties.
- **High Performance:** Utilizes Flutter’s fragment shaders for efficient rendering.

---

## Installation

Add `border_highlight` to your `pubspec.yaml`:

```yaml
dependencies:
  border_highlight: ^1.0.0
```

## Usage

Wrap your app within the `GlobalPointerTracker` widget to track the pointer globally:

```dart
void main() {
  runApp(
    GlobalPointerTracker(child: const MyApp()),
  );
}
```

Wrap your widget with the InteractiveShaderBorder widget. Configure the border properties as desired:

```dart
InteractiveShaderBorder(
  baseWidth: 3.0, // Border thickness.
  threshold: 100.0, // Distance for pointer highlight effect.
  borderRadius: 16,
  highlightColor: Colors.blue,
  child: YourWidget(),
)
```