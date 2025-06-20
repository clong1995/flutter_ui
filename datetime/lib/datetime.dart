import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';

class Datetime {
  static String toStr(DateTime dateTime, [String? pattern]) {
    String p = pattern ?? "";
    switch (pattern) {
      case "date":
        p = "yyyy-MM-dd";
        break;
      case "time":
        p = "HH:mm:ss";
        break;
      case "date time":
        p = "yyyy-MM-dd HH:mm:ss";
        break;
    }
    if (p == "") {
      p = "yyyy-MM-dd HH:mm:ss";
    }
    return Jiffy.parseFromDateTime(dateTime).format(pattern: p);
  }

  static String toTimeStr(TimeOfDay time) => '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  static DateTime add(
      DateTime dateTime, {
        int years = 0,
        int months = 0,
        int weeks = 0,
        int days = 0,
        int hours = 0,
        int minutes = 0,
        int seconds = 0,
      }) => Jiffy.parseFromDateTime(dateTime)
      .add(
    years: years,
    months: months,
    weeks: weeks,
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  )
      .dateTime;

  static String fromNow(DateTime dateTime, [DateTime? now]) {
    if (now == null) {
      return Jiffy.parseFromDateTime(dateTime).fromNow();
    }
    return Jiffy.parseFromDateTime(dateTime).from(Jiffy.parseFromDateTime(now));
  }

  //某季度的起始日期和结束日期
  static List<String> rangeOfQuarter(DateTime dateTime) {
    int year = dateTime.year;
    switch (Jiffy.parseFromDateTime(dateTime).quarter) {
      case 1:
        return ["$year-01-01", "$year-03-31"];
      case 2:
        return ["$year-04-01", "$year-06-30"];
      case 3:
        return ["$year-07-01", "$year-09-30"];
      case 4:
        return ["$year-10-01", "$year-12-31"];
    }
    return [];
  }

  static String weekDayStr(String date) {
    final datetime = DateTime.parse(date);
    if (datetime.weekday == DateTime.monday) {
      return "星期一";
    } else if (datetime.weekday == DateTime.tuesday) {
      return "星期二";
    } else if (datetime.weekday == DateTime.wednesday) {
      return "星期三";
    } else if (datetime.weekday == DateTime.thursday) {
      return "星期四";
    } else if (datetime.weekday == DateTime.friday) {
      return "星期五";
    } else if (datetime.weekday == DateTime.saturday) {
      return "星期六";
    } else {
      return "星期日";
    }
  }

// 计算距离当前时间过了多长时间
/*static String fromNow(DateTime dateTime, [DateTime? now]) {
    now ??= DateTime.now();
    final duration = now.difference(dateTime);

    if (duration.inDays > 0) {
      return "${duration.inDays}天前";
    }
    if (duration.inHours > 0) {
      return "${duration.inHours}小时前";
    }
    if (duration.inMinutes > 0) {
      return "${duration.inMinutes}分前";
    }
    if (duration.inSeconds > 0) {
      return "${duration.inHours}秒前";
    }
    return "";
  }*/
}
