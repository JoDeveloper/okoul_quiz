import 'package:flutter/material.dart';

/// context extensions
extension ContextExtensions on BuildContext {
  /// get the current screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// get the current screen width
  double get width => screenSize.width;

  /// get the current screen height
  double get height => screenSize.height;
}
