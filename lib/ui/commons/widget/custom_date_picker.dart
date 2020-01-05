import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onSelectedDate;
  final int blocWeekDay;
  final String label;

  CustomDatePicker(
      {this.label = 'Data', this.onSelectedDate, this.blocWeekDay = 0});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  var _selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    widget.onSelectedDate(_selectedDate);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey),
        ),
        child: ListTile(
          title: Text(
            widget.label,
          ),
          subtitle: Text(
            DateFormat('dd-MM-yyyy').format(_selectedDate),
            overflow: TextOverflow.ellipsis, maxLines: 2,
//          style: TextStyle(fontSize: 18),
          ),
          trailing: Icon(
            Icons.date_range,
            size: 30,
          ),
          onTap: () async {
            _showDialog();
          },
        ),
      ),
    );
  }

  void _showDialog() async {
    DateTime selectedDate = await showDatePicker(
      context: context,
      locale: Locale("pt", "BR"),
      selectableDayPredicate: (date) {
        if (date == _selectedDate) {
          return true;
        }
        return date.weekday != widget.blocWeekDay;
      },
      initialDate: _selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (selectedDate != null) {
      widget.onSelectedDate(selectedDate);
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }
}
