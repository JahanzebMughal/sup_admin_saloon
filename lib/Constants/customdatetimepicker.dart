import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';

getDate(BuildContext context, bool Function(DateTime, bool)? pickerdate) async {
  return await showRoundedDatePicker(
    selectableDayPredicate: (day) {
      return true;
    },
    onTapDay: pickerdate,
    height: 300,
    imageHeader: const AssetImage('assets/Header Image.png'),
    styleDatePicker: MaterialRoundedDatePickerStyle(
      textStyleCurrentDayOnCalendar:
          const TextStyle(backgroundColor: lightprimarycolor),
      textStyleButtonNegative: const TextStyle(color: cancelled),
      textStyleButtonPositive: const TextStyle(
        color: lightprimarycolor,
      ),
      decorationDateSelected:
          const BoxDecoration(color: lightprimarycolor, shape: BoxShape.circle),
      textStyleButtonAction: const TextStyle(
          backgroundColor: lightprimarycolor, color: lightprimarycolor),
      backgroundHeader: lightprimarycolor,
    ),
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(DateTime.now().year),
    lastDate: DateTime(DateTime.now().year + 20),
    borderRadius: 16,
  );
}

returndate({required DateTime date}) {
  return date;
}
