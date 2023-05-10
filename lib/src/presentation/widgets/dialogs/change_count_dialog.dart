import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/src/presentation/controllers/counter/counter_bloc.dart';

class ChangeCountDialog extends StatelessWidget {
  late final int currentCount;

  ChangeCountDialog({super.key}) {
    currentCount = services<CounterBloc>().state;
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final textTheme = Theme.of(context).textTheme;

    void onPressed() {
      Navigator.pop<num?>(
        context,
        num.tryParse(controller.text.trim()),
      );
    }

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      title: Text(
        'Change Count of Random Promts',
        style: textTheme.titleLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: textTheme.bodyMedium,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text('Count'),
                    labelStyle: textTheme.bodyMedium,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  controller: controller,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'Current value: $currentCount',
            style: textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: onPressed,
          child: const Text(
            'Update',
          ),
        ),
      ],
    );
  }
}
