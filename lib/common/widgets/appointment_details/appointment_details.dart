import 'package:ekorek/common/widgets/app_card/app_card.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:ekorek/utill/date_time_extension.dart';
import 'package:ekorek/utill/duration_extension.dart';
import 'package:ekorek/utill/time_of_day.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utopia_utils/utopia_utils.dart';

class AppointmentDetails extends StatelessWidget {
  final DateTime? pickedDay;
  final TimeOfDay? pickedTime;
  final Duration duration;
  final double price;

  const AppointmentDetails({
    Key? key,
    required this.duration,
    required this.pickedDay,
    required this.pickedTime,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pickedDayText = pickedDay == null ? "----" : pickedDay.simpleDate;

    final pickedTimeText = pickedTime == null ? "----" : pickedTime.simpleHour;

    final durationText = duration.displayHoursMinutes;

    return AppCard(
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
              Text(price.toString(), style: context.themeData.textTheme.bodyText1),
            ],
          ),
        ].separatedWith(
          const SizedBox(
            height: 16,
          ),
        ),
      ),
    );
  }
}
