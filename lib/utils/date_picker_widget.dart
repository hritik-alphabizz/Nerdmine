import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(String) onDateSelected;
  String? initialDate;
  final String  displayText;

  DatePickerWidget({
    required this.onDateSelected,
    this.initialDate, required this.displayText,
  });

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String it = DateFormat('yyyy-MM-dd').format(now);

    _selectedDate = DateFormat('yyyy-MM-dd').parse(it);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(DateFormat('yyyy-MM-dd').format(_selectedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.initialDate ?? widget.displayText,
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ],
    );
  }
}
