import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rundolist/core/key_sets/key_sets.dart';
import 'package:rundolist/src/domain/entities/enums/progress.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/presentation/controllers/counter/counter_bloc.dart';
import 'package:rundolist/src/presentation/controllers/duration/duration_bloc.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';
import 'package:rundolist/src/presentation/controllers/pseudo/pseudo_bloc.dart';
import 'package:rundolist/src/presentation/controllers/theme/theme_bloc.dart';
import 'package:rundolist/src/presentation/pages/result_page.dart';
import 'package:rundolist/src/presentation/widgets/chips/add_chip.dart';
import 'package:rundolist/src/presentation/widgets/chips/promt_chip.dart';
import 'package:rundolist/src/presentation/widgets/dialogs/change_count_dialog.dart';
import 'package:rundolist/src/presentation/widgets/dialogs/change_time_dialog.dart';
import 'package:rundolist/src/presentation/widgets/dialogs/new_promt_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    final pseudoBloc = BlocProvider.of<PseudoBloc>(context);
    final promtBloc = BlocProvider.of<PromtBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    FutureOr<void> onThemeChangePressed() {
      themeBloc.add(const ChangeThemeEvent());
    }

    FutureOr<void> onCheatUse(String numStr) {
      pseudoBloc.add(HandleCheatNumStrPseudoEvent(numStr));
    }

    FutureOr<void> onClearUse() {
      pseudoBloc.add(const RemovePseudoEvent());
    }

    return Shortcuts(
      shortcuts: KeySets.peudoRandomShortcuts,
      child: Actions(
        actions: KeySets.pseudoRandomActions(
          // Pseudo Use
          (numStr) {
            onCheatUse(numStr);
          },
          // Pseudo Clear
          () {
            onClearUse();
          },
        ),
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: _AppBar(
              context,
              onThemeChangePressed: onThemeChangePressed,
            ),
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: _Content(promtBloc),
                  ),
                  _Footer(promtBloc),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends AppBar {
  _AppBar(
    BuildContext context, {
    void Function()? onThemeChangePressed,
  }) : super(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Run Do List',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'dev',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: onThemeChangePressed,
              icon: const Icon(
                Icons.mode_night_rounded,
              ),
            ),
          ],
        );
}

class _Content extends StatelessWidget {
  final PromtBloc bloc;

  const _Content(
    this.bloc,
  );

  @override
  Widget build(BuildContext context) {
    Future<void> onAddPressed() async {
      final String? data = await showDialog<String?>(
        context: context,
        builder: (_) => const NewPromtDialog(),
      );

      if (data?.isNotEmpty ?? false) {
        bloc.add(
          AddPromtEvent(
            data: data!,
          ),
        );
      }
    }

    return BlocConsumer<PromtBloc, PromtState>(
      listener: (context, state) {
        if (state is LoadedPromtState) {
          if (state.progress == Progress.done) {
            Navigator.of(context).pushNamed(
              ResultPage.route,
              arguments: state.resultPromts,
            );
          }
        }
      },
      bloc: bloc,
      builder: (context, state) {
        if (state is LoadedPromtState) {
          return Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 4.0,
              runSpacing: 4.0,
              children: [
                ...List.generate(
                  state.promts.length,
                  (i) {
                    final Promt promt = state.promts.elementAt(i);

                    return PromtChip(promt: promt);
                  },
                ),
                AddChip(
                  fadeController: state.buttonFadeController,
                  onPressed: () => onAddPressed(),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 1.0,
          ),
        );
      },
    );
  }
}

class _Footer extends StatelessWidget {
  final PromtBloc bloc;

  const _Footer(
    this.bloc,
  );

  @override
  Widget build(BuildContext context) {
    void onRandomPressed() {
      bloc.add(const DoRandomPromtEvent());
    }

    Future<void> onTimeChangePressed() async {
      final duration = await showDialog<num>(
        context: context,
        builder: (_) => ChangeTimeDialog(),
      );

      // ignore: use_build_context_synchronously
      final durationBloc = BlocProvider.of<DurationBloc>(context);
      durationBloc.add(ChangeDurationEvent(duration));
    }

    Future<void> onCountChangePressed() async {
      final count = await showDialog<num>(
        context: context,
        builder: (_) => ChangeCountDialog(),
      );

      // ignore: use_build_context_synchronously
      final counterBloc = BlocProvider.of<CounterBloc>(context);
      counterBloc.add(ChangeCounterEvent(count));
    }

    void onClearPressed() {
      final counterBloc = BlocProvider.of<PromtBloc>(context);
      counterBloc.add(const ClearPromtEvent());
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 600.0,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Divider(
              height: 1.0,
            ),
          ),
          BlocBuilder<PromtBloc, PromtState>(
            builder: (context, state) {
              if (state is LoadedPromtState) {
                return Row(
                  children: [
                    Visibility(
                      visible: state.progress == Progress.inactive,
                      child: IconButton(
                        onPressed: () => onTimeChangePressed(),
                        icon: const Icon(
                          Icons.av_timer_rounded,
                        ),
                      ),
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onRandomPressed,
                        child: Builder(
                          builder: (_) {
                            if (state.progress == Progress.active) {
                              return Text(
                                'Stop'.toUpperCase(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              );
                            }

                            return Text(
                              'Random It'.toUpperCase(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.progress == Progress.inactive,
                      child: IconButton(
                        onPressed: () => onCountChangePressed(),
                        icon: const Icon(
                          Icons.numbers_rounded,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.progress == Progress.inactive,
                      child: IconButton(
                        onPressed: () => onClearPressed(),
                        icon: const Icon(
                          Icons.clear_rounded,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
