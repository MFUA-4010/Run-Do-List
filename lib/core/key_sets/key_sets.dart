import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeySets {
  const KeySets();
  // shortcuts: const <LogicalKeySet, Intent>
  static final peudoRandomShortcuts = <LogicalKeySet, Intent>{
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad1): const PseudoRandomIntent('1'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad2): const PseudoRandomIntent('2'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad3): const PseudoRandomIntent('3'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad4): const PseudoRandomIntent('4'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad5): const PseudoRandomIntent('5'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad6): const PseudoRandomIntent('6'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad7): const PseudoRandomIntent('7'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad8): const PseudoRandomIntent('8'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad9): const PseudoRandomIntent('9'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.numpad0): const PseudoRandomIntent('0'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.backspace): const PseudoClearIntent(),
  };

  static Map<Type, Action<Intent>> pseudoRandomActions(
    void Function(String) pseudoRandomCallback,
    void Function() pseudoClearCallback,
  ) {
    return <Type, Action<Intent>>{
      PseudoRandomIntent: CallbackAction<PseudoRandomIntent>(
        onInvoke: (intent) {
          return pseudoRandomCallback(intent.numStr);
        },
      ),
      PseudoClearIntent: CallbackAction<PseudoClearIntent>(
        onInvoke: (intent) {
          return pseudoClearCallback();
        },
      ),
    };
  }
}

class PseudoRandomIntent extends Intent {
  final String numStr;

  const PseudoRandomIntent(this.numStr);
}

class PseudoClearIntent extends Intent {
  const PseudoClearIntent();
}
