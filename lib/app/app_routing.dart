import 'package:ekorek/screen/auth/sign_up/sign_up_screen.dart';
import 'package:ekorek/screen/splash/splash_screen.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AppRouting {
  static final routes = <String, RouteConfig>{
    SplashScreen.route: SplashScreen.routeConfig,
    SignUpScreen.route: SignUpScreen.routeConfig,
  };

  static const initialRoute = SplashScreen.route;
}