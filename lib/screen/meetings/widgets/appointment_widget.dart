import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/config/app_theme.dart';
import 'package:ekorek/model/appointment/appointment.dart';
import 'package:ekorek/utill/duration_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentWidget extends StatelessWidget {
  final Appointment appointment;

  const AppointmentWidget({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: _buildDate(),
              ),
              Expanded(
                flex: 4,
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat("d").format(appointment.startTime),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                DateFormat("LLLL").format(appointment.startTime),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.subject.name.toUpperCase(),
              style: TextStyle(
                color: AppColors.darkColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Text(
                  getTime(),
                  style: TextStyle(
                    color: AppColors.darkColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  appointment.lessonLength.displayHoursMinutes,
                  style: TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Text(
              NumberFormat.currency(locale: 'PL').format(appointment.price),
              style: TextStyle(
                color: AppColors.darkColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTime() {
    final format = DateFormat("jm");
    final startTime = format.format(appointment.startTime);
    final endTime = format.format(appointment.endTime);
    return "$startTime - $endTime";
  }
}
