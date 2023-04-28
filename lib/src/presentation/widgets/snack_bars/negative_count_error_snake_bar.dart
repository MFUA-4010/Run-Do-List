import 'package:flutter/material.dart';
import 'package:rundolist/src/presentation/widgets/app_snack_bar.dart';

class NegativeCountErrorSnackBar extends AppSnackBar {
  static const String message = 'Count must be positive';

  NegativeCountErrorSnackBar(
    BuildContext context,
  ) : super(
          context,
          message,
        );
}
