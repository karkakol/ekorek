import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/common/widgets/profile/profile.dart';
import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/screen/home/state/use_home_screen_state.dart';
import 'package:ekorek/screen/home/widgets/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

import '../widgets/tabs/search_tab.dart';

class HomeScreenView extends StatelessWidget {
  final HomeScreenState state;

  const HomeScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildContent(context)),
            Navigation(
              currentIndex: state.tabController.index,
              onTabChanged: (index) => state.tabController.index = index,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return TabBarView(
      controller: state.tabController,
      children: [
        SearchTab(),
        _buildMeetings(),
        _buildProfile(),
      ],
    );
  }

  Widget _buildSearch() {
    return Center(child: Text("Search"));
  }

  Widget _buildProfile() {
    return state.user == null
        ? Center(child: SpinKitCircle(size: 50, color: AppColors.primaryColor))
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Profile(user: state.user!),
                Button(onTap: state.onSignOut, text: 'Sign Out'),
              ].separatedWith(SizedBox(height: 8)),
            ),
        );
  }

  Widget _buildMeetings() {
    return Center(child: Text("Meetings"));
  }
}
