import 'package:flutter/material.dart';
import 'package:portfolio/pages/intro/presentation/intro_state.dart';
import 'package:portfolio/responsive.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'pages/projects/domain/projects_data_model.dart';

/// TODO
/// X organize files
/// X fix aboutme
/// X Utils animation methods
/// X move data to state classes
/// X rebuild performance testing
/// X move scrollable padding to responsive
/// X final review & final/const changes
/// X favicon NB logo

Future<void> main() async {
  // timeDilation = 10;
  // debugPaintSizeEnabled = true;
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  final _initialRoute = Uri.base.path;
  final _startTime = DateTime.now().millisecondsSinceEpoch;
  final _projectsData = await ProjectsDataModel.init();

  final state = AppState(_initialRoute, _startTime, _projectsData);

  runApp(Portfolio(loginState: state));
}

class Portfolio extends StatelessWidget {
  static const String _title = 'Nicholas Blaauboer | Developer Portfolio';

  final AppState loginState;

  Portfolio({
    Key? key,
    required this.loginState,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          lazy: false,
          create: (_) => loginState,
        ),
        ChangeNotifierProvider<IntroProvider>(
          lazy: false,
          create: (_) => IntroProvider(loginState),
        ),
        Provider<Responsive>(
          lazy: false,
          create: (_) => Responsive(),
        ),
      ],
      child: Builder(builder: (context) {
        final _router = context.read<AppState>().router;

        return MaterialApp.router(
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          title: _title,
        );
      }),
    );
  }
}
