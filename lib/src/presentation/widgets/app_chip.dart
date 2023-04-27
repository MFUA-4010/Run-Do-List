import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rundolist/src/domain/entities/enums/fade.dart';

class AppChip extends StatefulWidget {
  final bool active;
  final String title;
  final StreamController<Fade> fadeController;
  final void Function()? onPressed;

  const AppChip({
    super.key,
    required this.active,
    required this.title,
    required this.fadeController,
    this.onPressed,
  });

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
      value: 1,
    );

    widget.fadeController.stream.listen(
      (Fade fade) {
        switch (fade) {
          case Fade.show:
            controller.animateTo(1.0);
            break;

          case Fade.half:
            controller.animateBack(0.4);
            break;

          case Fade.hide:
            controller.animateBack(0.0);
            break;
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: widget.onPressed,
      child: FadeTransition(
        opacity: controller,
        child: Chip(
          avatar: widget.active ? Icon(Icons.add_rounded, color: colorScheme.onPrimary) : null,
          label: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: widget.active ? colorScheme.onPrimary : colorScheme.primary),
          ),
          backgroundColor: widget.active ? colorScheme.primary : null,
          side: BorderSide(
            color: colorScheme.primary,
            width: .50,
          ),
        ),
      ),
    );
  }
}
