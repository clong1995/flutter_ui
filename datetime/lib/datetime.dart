import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Datetime {
  static String toStr(DateTime dateTime, [String? pattern]) {
    var p = pattern ?? '';
    switch (pattern) {
      case 'date':
        p = 'yyyy-MM-dd';
      case 'time':
        p = 'HH:mm:ss';
      case 'date time':
        p = 'yyyy-MM-dd HH:mm:ss';
    }
    if (p == '') {
      p = 'yyyy-MM-dd HH:mm:ss';
    }
    return Jiffy.parseFromDateTime(dateTime).format(pattern: p);
  }

  static String toTimeStr(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}'
      ':'
      '${time.minute.toString().padLeft(2, '0')}';

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
  static List<String> rangeOfQuarter(int quarter) {
    switch (quarter) {
      case 1:
        return ['01-01', '03-31'];
      case 2:
        return ['04-01', '06-30'];
      case 3:
        return ['07-01', '09-30'];
      case 4:
        return ['10-01', '12-31'];
    }
    return [];
  }

  //当前季度
  static int quarter(DateTime date) {
    final month = date.month;
    if (month <= 3) return 1;
    if (month <= 6) return 2;
    if (month <= 9) return 3;
    return 4;
  }

  static String weekDayStr(String date) {
    final datetime = DateTime.parse(date);
    if (datetime.weekday == DateTime.monday) {
      return '星期一';
    } else if (datetime.weekday == DateTime.tuesday) {
      return '星期二';
    } else if (datetime.weekday == DateTime.wednesday) {
      return '星期三';
    } else if (datetime.weekday == DateTime.thursday) {
      return '星期四';
    } else if (datetime.weekday == DateTime.friday) {
      return '星期五';
    } else if (datetime.weekday == DateTime.saturday) {
      return '星期六';
    } else {
      return '星期日';
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

  static int lastDayOfMonth(int year, int month) {
    final beginningOfNextMonth = (month < 12)
        ? DateTime(year, month + 1)
        : DateTime(year + 1);
    final lastDay = beginningOfNextMonth.subtract(const Duration(days: 1));
    return lastDay.day;
  }
}
