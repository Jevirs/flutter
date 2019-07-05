import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'list.dart';

class ZhihuHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<ZhihuHome> {
  static String date = DateFormat("yyyyMMdd").format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  Widget homeList = HomeList(date: date);

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2016),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      selectedDate = picked;
      var date = DateFormat("yyyyMMdd").format(picked);
      setState(() => {date = date, homeList = HomeList(date: date)});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Daily Hot"),
          actions: <Widget>[
            IconButton(
              color: Color(Colors.white.value),
              icon: Icon(Icons.date_range),
              onPressed: _selectDate,
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: homeList,
        ));
  }
}
