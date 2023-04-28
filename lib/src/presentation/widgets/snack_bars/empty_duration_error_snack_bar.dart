import 'package:flutter/material.dart';
import 'package:rundolist/src/presentation/widgets/app_snack_bar.dart';

class EmptyDurationErrorSnackBar extends AppSnackBar {
  static const String message = 'Duration can not be empty';

  EmptyDurationErrorSnackBar(
    BuildContext context,
  ) : super(
          context,
          message,
        );
}
