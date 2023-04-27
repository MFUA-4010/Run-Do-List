import 'package:flutter/material.dart';
import 'package:rundolist/src/presentation/widgets/app_snack_bar.dart';

class EmptyPromtErrorSnackBar extends AppSnackBar {
  static const String message = 'Promt can`t be empty';

  EmptyPromtErrorSnackBar(
    BuildContext context,
  ) : super(
          context,
          message,
        );
}
