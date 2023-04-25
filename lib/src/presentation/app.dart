import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/presentation/color_schemes.g.dart';
import 'package:rundolist/src/presentation/controllers/duration/duration_bloc.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';
import 'package:rundolist/src/presentation/pages/forbidden_page.dart';
import 'package:rundolist/src/presentation/pages/home_page.dart';
import 'package:rundolist/src/presentation/pages/result_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final globalNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Run Do List',
      navigatorKey: globalNavKey,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _onGenerateRoute,
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
              ],
              child: const HomePage(),
            );

          case ForbiddenPage.route:
            return const ForbiddenPage();

          case ResultPage.route:
            if (settings.arguments != null && settings.arguments is Promt) {
              // ignore: cast_nullable_to_non_nullable
              return ResultPage(settings.arguments as Promt);
            }

            return const ForbiddenPage();
        }

        return const ForbiddenPage();
      },
    );
  }
}
