import 'package:flutter/material.dart';
import 'package:rundolist/src/presentation/widgets/app_snack_bar.dart';

class EmptyCountErrorSnackBar extends AppSnackBar {
  static const String message = 'Count can not be empty';

  EmptyCountErrorSnackBar(
    BuildContext context,
  ) : super(
          context,
          message,
        );
}
