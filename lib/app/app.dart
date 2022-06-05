import 'package:ekorek/app/app_routing.dart';
import 'package:ekorek/app/state/auth/auth_state.dart';
import 'package:ekorek/app/state/setup/setup_state.dart';
import 'package:ekorek/app/state/user/user_state.dart';
import 'package:ekorek/app/state/users/users_state.dart';
import 'package:ekorek/config/config.dart';
import 'package:ekorek/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utopia_arch/utopia_arch.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  static void run(Config config) {
    WidgetsFlutterBinding.ensureInitialized();
    Config.current = config;
    runApp(const App());
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [
        InjectorProvider(setupInjector: setupInjector),
        SetupStateProvider(),
        AuthStateProvider(),
        UserStateProvider(),
        UsersStateProvider(),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        onGenerateInitialRoutes: (name) => [RouteConfig.generateInitialRoute(AppRouting.routes, name)],
        onGenerateRoute: (settings) => RouteConfig.generateRoute(AppRouting.routes, settings),
        navigatorObservers: [RouteConfig.createNavigationObserver(AppRouting.routes)],
        initialRoute: AppRouting.initialRoute,
      ),
    );
  }
}
