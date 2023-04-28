import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/presentation/color_schemes.g.dart';
import 'package:rundolist/src/presentation/controllers/counter/counter_bloc.dart';
import 'package:rundolist/src/presentation/controllers/duration/duration_bloc.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';
import 'package:rundolist/src/presentation/controllers/theme/theme_bloc.dart';
import 'package:rundolist/src/presentation/pages/forbidden_page.dart';
import 'package:rundolist/src/presentation/pages/home_page.dart';
import 'package:rundolist/src/presentation/pages/result_page.dart';
import 'package:rundolist/utils/global_context_mixin.dart';

class App extends StatelessWidget with GlobalContextUtil {
  static const appTitle = 'Run Do List';

  late final ThemeBloc themeBloc;

  App({super.key}) {
    themeBloc = services<ThemeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      bloc: themeBloc,
      builder: (context, state) {
        return MaterialApp(
          title: appTitle,
          navigatorKey: key,
          onGenerateRoute: _onGenerateRoute,
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          themeMode: state,
        );
      },
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (ctx) {
        switch (settings.name) {
          case HomePage.route:
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => services<PromtBloc>(),
                ),
                BlocProvider(
                  create: (context) => services<DurationBloc>(),
                ),
                BlocProvider(
                  create: (context) => services<CounterBloc>(),
                ),
                BlocProvider(
                  create: (context) => themeBloc,
                ),
              ],
              child: const HomePage(),
            );

          case ForbiddenPage.route:
            return const ForbiddenPage();

          case ResultPage.route:
            if (settings.arguments != null && settings.arguments is List<Promt>) {
              // ignore: cast_nullable_to_non_nullable
              return ResultPage(settings.arguments as List<Promt>);
            }

            return const ForbiddenPage();
        }

        return const ForbiddenPage();
      },
    );
  }
}
