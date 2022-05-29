import 'package:ekorek/screen/auth/sign_in/sign_in_screen.dart';
import 'package:ekorek/screen/auth/sign_up/sign_up_screen.dart';
import 'package:ekorek/screen/auth/welcome/welcome_screen.dart';
import 'package:ekorek/screen/home/home_screen.dart';
import 'package:ekorek/screen/splash/splash_screen.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AppRouting {
  static final routes = <String, RouteConfig>{
    SplashScreen.route: SplashScreen.routeConfig,
    SignUpScreen.route: SignUpScreen.routeConfig,
    SignInScreen.route: SignInScreen.routeConfig,
    HomeScreen.route: HomeScreen.routeConfig,
    WelcomeScreen.route: WelcomeScreen.routeConfig,
  };

  static const initialRoute = SplashScreen.route;
}