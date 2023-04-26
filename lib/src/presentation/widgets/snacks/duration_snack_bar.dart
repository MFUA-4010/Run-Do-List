import 'package:flutter/material.dart';

enum DuraionSnackBarOption {
  empty,
  negative,
}

class DuraionSnackBar extends SnackBar {
  static String getErrOptionText(DuraionSnackBarOption option) {
    switch (option) {
      case DuraionSnackBarOption.empty:
        return 'Duration can`t be empty';

      case DuraionSnackBarOption.negative:
        return 'Duration must be positive';
    }
  }

  DuraionSnackBar(BuildContext context, DuraionSnackBarOption option)
      : super(
          content: Text(
            getErrOptionText(option),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).cardColor,
                ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(milliseconds: 800),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
        );
}
