import 'package:ekorek/screen/create_appointment/create_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

import 'state/use_home_screen_state.dart';
import 'view/home_screen_view.dart';

class HomeScreen extends HookWidget {
  static const route = '/home';
  static final routeConfig = RouteConfig.material(() => const HomeScreen());

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navigator = context.navigator;

    final state = useHomeScreenState(
      navigateToCreateAppointment: (args) {
        navigator.pushNamed(CreateAppointmentScreen.route, arguments: args);
      }
    );
    return HomeScreenView(state: state);
  }
}
