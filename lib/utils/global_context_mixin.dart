import 'dart:async';

import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

/// Global [SnackBar] and [Dialog] builder util
mixin GlobalContextUtil on Object {
  /// New [GlobalKey] for application
  /// Should be configured under global app widget
  BuildContext? get context => key.currentContext;

  /// Global showSnackBar method
  FutureOr<void> showGlobalSnackBar(SnackBar snack) {
    if (context == null) {
      throw UnimplementedError();
    }

    ScaffoldMessenger.of(context!).showSnackBar(snack);
  }

  /// Global showDialog method
  FutureOr<void> showGlobalDialog<T>(
    Widget dialog,
    void Function(T) callback,
  ) async {
    if (context == null) {
      throw UnimplementedError();
    }

    final T? result = await showDialog<T?>(
      context: context!,
      builder: (_) => dialog,
    );

    if (result != null) {
      callback(result);
    }
  }
}
