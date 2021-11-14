import 'dart:developer';

import 'package:intl/intl.dart';

bool isProductAvailable({required List<String> liveTimings}) {
  bool isAvailable = true;

  if (liveTimings.contains("All Time")) {
    return true;
  } else {
    for (int i = 0; i < liveTimings.length; i++) {
      List<String> timeList = liveTimings[i].split("-");
      DateTime fromTime = DateFormat("hh:mm aaa").parse(timeList[0].trim());
      DateTime toTime = DateFormat("hh:mm aaa").parse(timeList[1].trim());

      String currentTimeString = DateFormat("hh:mm aaa").format(DateTime.now());
      DateTime currentTime = DateFormat("hh:mm aaa").parse(currentTimeString);

      if (currentTime.isAfter(fromTime) && currentTime.isBefore(toTime)) {
        return true;
      } else
        isAvailable = false;
    }
  }

  return isAvailable;
}
