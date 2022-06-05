import 'package:ekorek/config/config.dart';
import 'package:ekorek/service/auth_service/auth_service.dart';
import 'package:ekorek/service/remote_config_service/remote_config_service.dart';
import 'package:ekorek/service/search_tutor_service/search_tutor_service.dart';
import 'package:ekorek/service/user_service/user_service.dart';
import 'package:injector/injector.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

Injector setupInjector() {
  final injector = Injector();
  injector
    ..registerSingleton<Config>(() => Config.current)
    ..registerSingleton<UserService>(() => UserService())
    ..registerSingleton<AuthService>(() => AuthService(userService: injector.get()))
    ..registerSingleton<SearchTutorService>(() => SearchTutorService())
    ..registerSingleton<RemoteConfigService>(() => RemoteConfigService());
  return injector;
}

T useInjected<T>() => useProvided<Injector>().get<T>();
