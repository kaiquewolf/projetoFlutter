import 'package:flutter/material.dart';

final MaterialStateProperty<Color?> overlayColor =
    MaterialStateProperty.resolveWith<Color?>(
  (Set<MaterialState> states) {
    // Material color when switch is selected.
    if (states.contains(MaterialState.selected)) {
      return Colors.grey.shade400;
    }
    // Material color when switch is disabled.
    if (states.contains(MaterialState.disabled)) {
      return Colors.grey.shade400;
    }
    // Otherwise return null to set default material color
    // for remaining states such as when the switch is
    // hovered, or focused.
    return null;
  },
);

final MaterialStateProperty<Color?> trackColor =
    MaterialStateProperty.resolveWith<Color?>(
  (Set<MaterialState> states) {
    // Track color when the switch is selected.
    if (states.contains(MaterialState.selected)) {
      return Colors.black;
    }
    // Otherwise return null to set default track color
    // for remaining states such as when the switch is
    // hovered, focused, or disabled.
    return null;
  },
);
