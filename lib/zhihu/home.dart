import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {
  static String date = new DateFormat("yyyyMMdd").format(new DateTime.now());
  DateTime selectedDate = new DateTime.now();
  Widget homeList = new HomeList(date: date);

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime(2016),
      lastDate: new DateTime.now(),
    );
    if (picked != null) {
      selectedDate = picked;
      var date = new DateFormat("yyyyMMdd").format(picked);
      setState(() => {date = date, homeList = new HomeList(date: date)});
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Daily Hot"),
          actions: <Widget>[
            new IconButton(
              color: new Color(Colors.white.value),
              icon: new Icon(Icons.date_range),
              onPressed: _selectDate,
            )
          ],
        ),
        body: new Container(
          padding: const EdgeInsets.all(16.0),
          child: homeList,
        ));
  }
}
