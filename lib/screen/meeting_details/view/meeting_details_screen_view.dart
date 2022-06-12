import 'package:ekorek/common/widgets/appointment_details/appointment_details.dart';
import 'package:ekorek/common/widgets/tutor_info/tutor_info.dart';
import 'package:ekorek/common/widgets/user_address/user_address.dart';
import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:utopia_widgets/layout/form_layout.dart';

import '../state/use_meeting_details_screen_state.dart';

class MeetingDetailsView extends StatelessWidget {
  final MeetingDetailsState state;

  const MeetingDetailsView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: state.isLoading ? _buildLoader() : _buildDetails(),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: SpinKitCircle(
        color: AppColors.accentColor,
        size: 60,
      ),
    );
  }

  Widget _buildDetails() {
    return FormLayout.simple(
      backgroundColor: Colors.white,
      content: Column(
        children: [
          if (state.user is UserTutor)
          UserInfo(user: state.user as UserTutor, subject: state.appointment.subject.name),
          if (state.user is UserStudent)
            UserInfo(user: state.user as UserStudent, subject: state.appointment.subject.name),
          UserAddress(user: state.user!),
          AppointmentDetails(
            duration: state.appointment.lessonLength,
            pickedDay: state.appointment.startTime,
            pickedTime: TimeOfDay(
              hour: state.appointment.startTime.hour,
              minute: state.appointment.startTime.minute,
            ),
            price: state.appointment.price,
          ),
        ],
      ),
      bottom: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: state.onCancelAppointment,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent,
                  Colors.red,
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
