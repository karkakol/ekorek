import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/model/appointment/appointment.dart';
import 'package:ekorek/screen/meetings/widgets/appointment_widget.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../state/use_meetings_page_state.dart';

class MeetingsPageView extends StatelessWidget {
  final MeetingsPageState state;

  const MeetingsPageView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              _buildTitle("Pending"),
              _buildTitle("Coming"),
              _buildTitle("Past"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildAppointments(context, state.currentAppointments),
                _buildAppointments(context, state.incomingAppointments),
                _buildAppointments(context, state.historyAppointments),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointments(BuildContext context, IList<Appointment> appointments) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      itemCount: appointments.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: AppointmentWidget(
          appointment: appointments[index],
          currentUser: state.currentUser,
          student: state.getStudent(appointments[index].studentId),
          tutor: state.getTutor(appointments[index].tutorId),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.darkColor,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
