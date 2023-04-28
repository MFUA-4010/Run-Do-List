import 'package:flutter/material.dart';
import 'package:rundolist/utils/global_context_mixin.dart';

class AppSnackBar extends SnackBar with GlobalContextUtil {
  AppSnackBar(
    BuildContext context,
    String title,
  ) : super(
          content: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(milliseconds: 1400),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
        );
}
