extension DurationX on Duration?{
  String displayClockTime(){
    if(this == null) return "--:--";

    final hours = this!.inHours;
    final minutes = this!.inMinutes - hours*60;

    if(hours == 0 && minutes == 0) return '-- : --';

    final hoursText = hours < 10 ? "0$hours" : "$hours";
    final minutesText = minutes < 10 ? '0$minutes' : "$minutes";

    return "$hoursText:$minutesText";
  }
}