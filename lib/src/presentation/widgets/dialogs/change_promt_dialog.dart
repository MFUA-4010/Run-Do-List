import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';

class ChangePromtDialog extends StatelessWidget {
  final String initialValue;

  const ChangePromtDialog({
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = initialValue;

    void onDeletePressed() {
      final bloc = services<PromtBloc>();
      // final bloc = BlocProvider.of<PromtBloc>(context);
      bloc.add(RemovePromtEvent(id: bloc.editingPromtId ?? ''));

      Navigator.pop<String?>(
        context,
      );
    }

    void onUpdatePressed() {
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
        'Promt Editing',
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
        IconButton(
          onPressed: onDeletePressed,
          icon: Icon(
            Icons.delete_outline_rounded,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        FilledButton(
          onPressed: onUpdatePressed,
          child: const Text(
            'Update',
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
