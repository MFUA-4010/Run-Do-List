import 'package:flutter/material.dart';
import 'package:rundolist/src/presentation/widgets/app_snack_bar.dart';

class NegativeDurationErrorSnackBar extends AppSnackBar {
  static const String message = 'Duration must be positive';

  NegativeDurationErrorSnackBar(
    BuildContext context,
  ) : super(
          context,
          message,
        );
}
