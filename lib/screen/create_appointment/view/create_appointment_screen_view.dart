import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:ekorek/utill/duration_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';
import 'package:utopia_widgets/layout/form_layout.dart';

import '../../../common/widgets/button/button.dart';
import '../../../common/widgets/tutor_info/tutor_info.dart';
import '../../../common/widgets/user_address/user_address.dart';
import '../state/create_appointment_screen_state.dart';

class CreateAppointmentScreenView extends StatelessWidget {
  final CreateAppointmentScreenState state;

  const CreateAppointmentScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text('Set an appointment')),
      body: FormLayout.simple(
        backgroundColor: Colors.transparent,
        content: Column(
          children: [
            TutorInfo(
              tutor: state.tutor,
              subject: state.subject,
            ),
            _buildPickers(context),
            _buildAppointmentInfo(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: UserAddress(user: state.tutor),
            ),
          ],
        ),
        bottom: _buildButton(context),
      ),
    );
  }

  Widget _buildPickers(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
            onPressed: () => state.pickDay(context),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.access_time, color: AppColors.primaryColor),
            onPressed: () => state.pickTime(context),
          ),
        ),
        Expanded(flex: 2, child: _buildLessonDurationButton(context)),
      ],
    );
  }

  Widget _buildLessonDurationButton(BuildContext context) {
    final durationText = state.lessonDurationState.value.displayClockTime();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.remove, color: AppColors.primaryColor, size: 28),
          onPressed: state.removeTime,
        ),
        Text(
          durationText,
          style: context.themeData.textTheme.headline6,
        ),
        IconButton(
          icon: const Icon(
            Icons.add,
            color: AppColors.primaryColor,
            size: 28,
          ),
          onPressed: state.addTime,
        )
      ],
    );
  }

  Widget _buildAppointmentInfo(BuildContext context) {
    final pickedDay = state.pickedDayState.value;
    final pickedDayText = pickedDay == null ? "----" : pickedDay.toString();

    final pickedTime = state.startTimeState.value;
    final pickedTimeText = pickedTime == null ? "----" : pickedTime.toString();

    final durationText = state.lessonDurationState.value.displayClockTime();

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Picked Day: ", style: context.themeData.textTheme.bodyText1),
                Text(pickedDayText, style: context.themeData.textTheme.bodyText1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Picked hour: ", style: context.themeData.textTheme.bodyText1),
                Text(pickedTimeText, style: context.themeData.textTheme.bodyText1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Lesson duration: ", style: context.themeData.textTheme.bodyText1),
                Text(durationText, style: context.themeData.textTheme.bodyText1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price for lesson: ", style: context.themeData.textTheme.bodyText1),
                Text(state.lessonPrice.toString(), style: context.themeData.textTheme.bodyText1),
              ],
            ),
          ].separatedWith(SizedBox(height: 16,)),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Button(
        onTap: state.submit,
        text: "Continue",
        isLoading: state.submitState.isSubmitInProgress,
        enabled: state.submitEnabled,
      ),
    );
  }
}
