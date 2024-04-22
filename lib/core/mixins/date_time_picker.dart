import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin TimeDatePickerMixin {
  pickDateFirst(BuildContext context, TextEditingController controller,
      TextEditingController unFormatController,
      {DateTime? firstDate,
      DateTime? lastDate,
      DateTime? initialDate,
      void Function(DateTime)? onDateTimeChanged}) async {
    if (Platform.isIOS) {
      await showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
                height: 300,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoButton(
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ]),
                    SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          initialDateTime: initialDate ?? DateTime.now(),
                          minimumDate: firstDate ?? DateTime(1970),
                          maximumDate: lastDate ?? DateTime.now(),
                          onDateTimeChanged: onDateTimeChanged ??
                              (val) {
                                unFormatController.text = val.toString();
                                final DateFormat formatter =
                                    DateFormat('MM-dd-yyyy');
                                final String formatted = formatter.format(val);
                                controller.text = formatted +
                                    " | " +
                                    DateFormat.jm().format(val);
                              }),
                    ),

                    // Close the modal
                  ],
                ),
              ));
    } else {
      var selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(1970),
        lastDate: lastDate ?? DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // Change text color here
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (selectedDate != null) {
        var selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, // Change text color here
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        final DateFormat formatter = DateFormat('MM-dd-yyyy');
        final String formatted = formatter.format(selectedDate);
        final localizations = MaterialLocalizations.of(context);
        final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime!);
        controller.text = "$formatted | $formattedTimeOfDay";
        unFormatController.text = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedDate.minute)
            .toString();
      }
    }
  }
}
