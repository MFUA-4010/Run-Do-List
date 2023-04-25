import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeTimeDialog extends StatelessWidget {
  const ChangeTimeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

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
        'Change Remove Duration',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Row(
        children: [
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: const Text('Enter time'),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              controller: controller,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            'sec',
            style: Theme.of(context).textTheme.bodySmall,
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
