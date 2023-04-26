import 'package:flutter/material.dart';

class EmptySnackBar extends SnackBar {
  EmptySnackBar(BuildContext context)
      : super(
          content: Text(
            'There`s no promts',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).cardColor,
                ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          duration: const Duration(milliseconds: 800),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
        );
}
