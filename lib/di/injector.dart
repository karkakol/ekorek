import 'package:ekorek/config/config.dart';
import 'package:ekorek/service/auth_service/auth_service.dart';
import 'package:injector/injector.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

Injector setupInjector() {
  final injector = Injector();
  injector
    ..registerSingleton<Config>(() => Config.current)
    ..registerSingleton<AuthService>(() => AuthService());
  return injector;
}

T useInjected<T>() => useProvided<Injector>().get<T>();
