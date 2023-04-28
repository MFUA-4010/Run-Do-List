import 'package:flutter/material.dart';
import 'package:rundolist/src/presentation/widgets/app_snack_bar.dart';

class UpCountErrorSnackBar extends AppSnackBar {
  static const String message = 'Count must be less than count of promts \nMin count have been set';

  UpCountErrorSnackBar(
    BuildContext context,
  ) : super(
          context,
          message,
        );
}
