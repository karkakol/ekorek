import 'package:ekorek/utill/duration_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../common/widgets/tutor_info/tutor_info.dart';
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
              onPressed: () {
                Navigator.of(context).maybePop();
              }),
          title: Text('Set an appointment')),
      body: ListView(
        children: [
          TutorInfo(
            tutor: state.tutor,
            subject: state.subject,
          ),
          _buildDayPicker(context),
          _buildStartTimePicker(context),
          _buildLessonDuration(context),
          _buildPrize(context),
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildDayPicker(BuildContext context) {
    final pickedDay = state.pickedDayState.value;
    final pickedDayText = pickedDay == null ? "----" : pickedDay.toString();
    return Row(
      children: [
        Text('Pick day'),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => state.pickDay(context),
        ),
        Text(pickedDayText),
      ],
    );
  }

  Widget _buildStartTimePicker(BuildContext context) {
    final pickedTime = state.startTimeState.value;
    final pickedTimeText = pickedTime == null ? "----" : pickedTime.toString();
    return Row(
      children: [
        Text('Pick hour'),
        IconButton(
          icon: const Icon(Icons.access_time),
          onPressed: () => state.pickTime(context),
        ),
        Text(pickedTimeText),
      ],
    );
  }

  Widget _buildLessonDuration(BuildContext context) {
    return Row(
      children: [
        Text('Set lesson duration'),
        _buildLessonDurationButton(context),
      ],
    );
  }

  Widget _buildLessonDurationButton(BuildContext context) {
    final durationText = state.lessonDurationState.value.displayClockTime();

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: state.removeTime,
        ),
        Text(durationText),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: state.addTime,
        )
      ],
    );
  }

  Widget _buildPrize(BuildContext context) {
    return Text("Price for a lesson is: ${state.lessonPrice}");
  }

  Widget _buildButton(BuildContext context) {
    return OutlinedButton(
      onPressed: state.submit,
      child: state.submitState.isSubmitInProgress ? SpinKitThreeBounce(
        color: Colors.blue,
        size: 20.0,
      ): Text("Set an appointment"),
    );
  }
}
