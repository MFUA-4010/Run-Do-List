import 'package:flutter/material.dart';

class NewPromtDialog extends StatelessWidget {
  const NewPromtDialog();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    void onPressed() {
      Navigator.pop<String?>(
        context,
        controller.text,
      );
    }

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      title: Text(
        'New Promt',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: TextField(
        decoration: const InputDecoration(
          label: Text('Data'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        controller: controller,
      ),
      actions: [
        FilledButton(
          onPressed: onPressed,
          child: const Text(
            'Add',
          ),
        ),
      ],
    );
  }
}
