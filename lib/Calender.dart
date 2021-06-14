import 'package:calenderevents/Helper/DataBaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'TableModel/Events.dart';

const headingColor = const Color(0xFF565d91);

class CalenderScreen extends StatefulWidget {
  Calender createState() => Calender();
}

class Calender extends State<CalenderScreen> {
  late DataBaseHelper dataBaseHelper;
  List<Events> eventsList = [];
  List<Events> alleventsList = [];
  String value = "a",
      date = '',
      _selectedtype = 'Event',
      repeat = 'Do not repeat',
      disc = '',
      enddate = '';
  List<String> type = ['Event', 'Event2', 'Event3', "Event4"];

  addEvents() {
    Events data =
        Events("test", date, "10:00", _selectedtype, repeat, disc, enddate);
    List<Events> listOfevents = [data];
    dataBaseHelper.insertEvents(listOfevents);

    dataBaseHelper.retrieveEvents(date).then((value) => {
          setState(() {
            eventsList = value;
          })
        });
    dataBaseHelper.retrieveAllData().then((value) => {
          setState(() {
            alleventsList = value;
          })
        });
  }

  showRepeatList(BuildContext context, StateSetter setState) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: StatefulBuilder(builder: (context, setState) {
            return Container(
                height: 40.h,
                child: Column(children: [
                  Container(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            repeat = "Do not repeat";
                          });

                          Navigator.pop(context);
                        },
                        child: Text('Do not repeat')),
                  ),
                  Container(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            repeat = "Daily";
                          });

                          Navigator.pop(context);
                        },
                        child: Text('Daily')),
                  ),
                  Container(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            repeat = "Same day of every week";
                          });

                          Navigator.pop(context);
                        },
                        child: Text('Same day of every week')),
                  ),
                  Container(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            repeat = "Alternative week";
                          });

                          Navigator.pop(context);
                        },
                        child: Text('Alternative week')),
                  ),
                  Container(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            repeat = "Same day of every month";
                          });

                          Navigator.pop(context);
                        },
                        child: Text('Same day of every month')),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'))),
                        Expanded(
                            flex: 1,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Ok'))),
                      ]))
                ]));
          }));
        });
  }

  showPopup(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: StatefulBuilder(builder: (context, setState) {
            return Container(
                height: 50.h,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.clear_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("CREATE APPOINTMENT",
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Type*",
                              style: TextStyle(fontSize: 10.sp)))),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 1.w),
                    width: 100.h,
                    child: DropdownButton(
                      // Not necessary for Option 1
                      value: _selectedtype,
                      onChanged: (select) {
                        setState(() {
                          _selectedtype = '$select';
                        });
                      },
                      items: type.map((values) {
                        return DropdownMenuItem(
                          child: new Text(values),
                          value: values,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.w),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Date*",
                              style: TextStyle(fontSize: 10.sp)))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.w),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(date,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Start Time*",
                              style: TextStyle(fontSize: 10.sp)))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.w),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("10:00 AM",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.w),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Description*",
                              style: TextStyle(fontSize: 10.sp)))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              disc = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: new BorderSide(color: headingColor),
                            ),
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: headingColor,
                          ),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 1.w),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Repeat*",
                              style: TextStyle(fontSize: 10.sp)))),
                  Container(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                showRepeatList(context, setState);
                              },
                              child: Text(repeat,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold))))),
                  Container(
                      child: OutlinedButton(
                    onPressed: () {
                      addEvents();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Text(
                      "Add Appointment",
                      style: TextStyle(color: Colors.black),
                    ),
                  ))
                ])));
          }));
        });
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    for (int j = 0; j < alleventsList.length; j++) {
      DateTime dateTime = DateTime.parse(alleventsList[j].eventDate);
      DateTime enddateTime = DateTime.parse(alleventsList[j].eventEndDate);
      appointments.add(Appointment(
        startTime: dateTime,
        endTime: DateTime.now().add(Duration(minutes: 10)),
        subject: alleventsList[j].eventDescription,
        color: Colors.blue,
        startTimeZone: '',
        endTimeZone: '',
      ));
    }
    return _AppointmentDataSource(appointments);
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.header) {
    } else if (details.targetElement == CalendarElement.viewHeader) {
    } else if (details.targetElement == CalendarElement.calendarCell) {
      date = new DateFormat('yyyy-MM-dd').format(details.date!).toString();
      enddate = new DateFormat('yyyy-MM-dd').format(details.date!).toString();
      dataBaseHelper.retrieveEvents(date).then((value) => {
            setState(() {
              eventsList = value;
            })
          });

      dataBaseHelper.retrieveAllData().then((value) => {
            setState(() {
              alleventsList = value;
            })
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          Container(
            height: 5.h,
          ),
          Container(
              child: Row(children: [
            Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24.sp,
                ),
                onPressed: () {},
              ),
            )),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Back",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                ),
              ),
            ),
          ])),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Calender",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
            ),
          ),
          Container(
              height: 45.h,
              width: 95.w,
              child: SfCalendar(
                view: CalendarView.month,
                onTap: calendarTapped,
                dataSource: _getCalendarDataSource(),
              )),
          Container(
              height: 38.h,
              child: ListView.builder(
                  itemCount: eventsList.length == 0 ? 0 : eventsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 2.h),
                        child: Container(
                            height: 5.h,
                            margin: EdgeInsets.symmetric(vertical: 1.h),
                            child: Row(children: [
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Text(
                                  eventsList[index].eventDescription,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                child: Text(eventsList[index].eventType,
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold)),
                              )),
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(eventsList[index].eventDate,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold))),
                              )),
                            ])));
                  }))
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showPopup(context);
          },
          child: Icon(Icons.add),
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();

    this.dataBaseHelper = DataBaseHelper();
    this.dataBaseHelper.initializeDB().whenComplete(() async {});
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
