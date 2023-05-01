import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class StartTimeButton extends StatelessWidget {
  const StartTimeButton({super.key, this.startTime});
  final DateTime? startTime;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Start Time',
          suffixIcon: Icon(Icons.calendar_today),
        ),
        controller: startTime == null ? null : TextEditingController(text: DateFormat('yyyy-MM-dd').format(startTime!)),
        validator: (value) {
          if (startTime == null) {
            return 'Please select a start date and time';
          }
          return null;
        },
      ),
    );
  }
}

class EndTimeButton extends StatelessWidget {
  const EndTimeButton({super.key, this.startTime, this.endTime});
  final DateTime? startTime;
  final DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'End Time',
          suffixIcon: Icon(Icons.calendar_today),
        ),
        controller: endTime == null ? null : TextEditingController(text: DateFormat('yyyy-MM-dd').format(endTime!)),
        validator: (value) {
          if (endTime == null) {
            return 'Please select an end date and time';
          }
          if (startTime != null && endTime!.isBefore(startTime!)) {
            return 'End date/time must be after start date/time';
          }
          return null;
        },
      ),
    );
  }
}

class StringInputButton extends StatelessWidget {
  const StringInputButton({super.key,required this.textInput, required this.labelText});
  final TextEditingController textInput;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textInput,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a $textInput';
        }
        return null;
      },
      decoration: InputDecoration(labelText: labelText),
    );
  }
}

class NumInputButton extends StatelessWidget {
  const NumInputButton({super.key,required this.textInput, required this.labelText});
  final TextEditingController textInput;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textInput,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter only numbers';
        }
        return null;
      },
      decoration: InputDecoration(labelText: labelText),
    );
  }
}

Future<DateTime?> pickDateTime(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
  );

  if (pickedDate != null) {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      pickedDate = DateTime(
        pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute,
      );
    }
  }
  return pickedDate;
}
