import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/screen/home/state/use_home_screen_state.dart';
import 'package:ekorek/screen/home/widgets/navigation/navigation.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatelessWidget {
  final HomeScreenState state;

  const HomeScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ekorek Home"),
        ),
        body: Column(
          children: [
            Expanded(child: _buildContent(context)),
            Navigation(
              currentIndex: state.tabController.index,
              onTabChanged: (index) => state.tabController.index = index,
            ),
          ],
        ));
  }

  Widget _buildContent(BuildContext context) {
    return TabBarView(
      controller: state.tabController,
      children: [
        _buildSearch(),
        _buildMeetings(),
        _buildProfile(),
      ],
    );
  }

  Widget _buildSearch() {
    return Center(child: Text("Search"));
  }

  Widget _buildMeetings() {
    return Center(child: Text("Meetings"));
  }

  Widget _buildProfile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile"),
          Button(onTap: state.onSignOut, text: "Sign Out"),
        ],
      ),
    );
  }
}
