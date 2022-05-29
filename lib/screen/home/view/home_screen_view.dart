import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/screen/home/state/use_home_screen_state.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatelessWidget {
  final HomeScreenState state;

  const HomeScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ekorek"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Welcome Home"),
            Button(onTap: state.onSignOut, text: "Sign Out"),
          ],
        ),
      ),
    );
  }
}
