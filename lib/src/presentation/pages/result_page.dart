import 'package:flutter/material.dart';
import 'package:rundolist/src/domain/entities/promt.dart';

class ResultPage extends StatelessWidget {
  final List<Promt> promt;

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
                'Result',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 4.0,
                runSpacing: 4.0,
                children: promt.map(
                  (e) {
                    return Chip(
                      label: Hero(
                        tag: e.id,
                        child: Text(
                          e.data,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: .50,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
