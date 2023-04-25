import 'package:flutter/material.dart';
import 'package:rundolist/src/domain/entities/promt.dart';

class ResultPage extends StatelessWidget {
  final Promt promt;

  const ResultPage(
    this.promt, {
    super.key,
  });

  static const route = '/result';

  @override
  Widget build(BuildContext context) {
    void onScaffoldPressed() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: GestureDetector(
        onTap: onScaffoldPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Result Promt',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Center(
              child: Chip(
                label: Hero(
                  tag: promt.id,
                  child: Text(
                    promt.data,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: .50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
