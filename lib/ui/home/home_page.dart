import 'package:cheking/ui/add/add_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../main.dart';
import '../../model/meeting.dart';
import '../../model/use_model/use_hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Meeting> meetingBox;
  late Box<UseHive> useBox;

  int totalAmountPerDate = 0;
  int totalAmountPerMonth = 0;

  DateTime _visibleMonth = DateTime.now();
  String selectedValue = "";

  @override
  void initState() {
    super.initState();
    meetingBox = Hive.box('meeting');
    useBox = Hive.box('use');
    meetings = _getDataSource();
    selectedValue = useBox.values.first.addUse;

    if (useBox.isEmpty) {
      useBox.add(UseHive("All"));
    }

    totalAmountPerMonth = _calculateSumForMonthNew(_visibleMonth);
  }


  int _calculateSumForMonthNew(DateTime date) {
    int sumMonth = 0;
    for (int i = 0; i < meetingBox.length; i++) {
      if(selectedValue == "All") {
        if(meetingBox.getAt(i)?.date.year == date.year &&
            (meetingBox.getAt(i)!.date.month) == date.month) {
          sumMonth += int.parse(meetingBox.getAt(i)?.amount ?? "0");
        }
      } else {
        if (meetingBox.getAt(i)?.date.year == date.year &&
            (meetingBox.getAt(i)!.date.month-1) == date.month &&
            meetingBox.getAt(i)?.use == selectedValue) {
          sumMonth += int.parse(meetingBox.getAt(i)?.amount ?? "0");

        }
      }
    }

    print("++++++++++$sumMonth++++++++++++++");
    print("++++++++++$selectedValue++++++++++++++");
    totalAmountPerMonth = sumMonth;
    return sumMonth;
  }


  int _calculateSumForMonth(DateTime date) {
    int sumMonth = 0;
    for (int i = 0; i < meetingBox.length; i++) {
      if(selectedValue == "All") {
        if(meetingBox.getAt(i)?.date.year == date.year &&
            (meetingBox.getAt(i)!.date.month-1) == date.month) {
          sumMonth += int.parse(meetingBox.getAt(i)?.amount ?? "0");
        }
      } else {
        if (meetingBox.getAt(i)?.date.year == date.year &&
            (meetingBox.getAt(i)!.date.month-1) == date.month &&
            meetingBox.getAt(i)?.use == selectedValue) {
          sumMonth += int.parse(meetingBox.getAt(i)?.amount ?? "0");

        }
      }
    }

    print("++++++++++$sumMonth++++++++++++++");
    print("++++++++++$selectedValue++++++++++++++");
    totalAmountPerMonth = sumMonth;
    return sumMonth;
  }


  int _calculateSumForDate(DateTime date) {
    int sum = 0;
    for (int i = 0; i < meetingBox.length; i++) {
      if(selectedValue == "All") {
        if (meetingBox.getAt(i)?.date.year == date.year &&
            (meetingBox.getAt(i)!.date.month) == date.month &&
            meetingBox.getAt(i)?.date.day == date.day) {
          sum += int.parse(meetingBox.getAt(i)?.amount ?? "0");
        }
      } else {
        if (meetingBox.getAt(i)?.date.year == date.year &&
            (meetingBox.getAt(i)!.date.month) == date.month &&
            meetingBox.getAt(i)?.date.day == date.day &&
            meetingBox.getAt(i)?.use == selectedValue) {
          sum += int.parse(meetingBox.getAt(i)?.amount ?? "0");
        }
      }
    }
    return sum;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calender Task",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: const Color(0xffe4e2ac),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20).r,
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: DropdownButtonFormField<String>(
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value!;
                          _calculateSumForMonth(_visibleMonth);
                        });
                      },
                      items: useBox.values
                          .map<DropdownMenuItem<String>>((UseHive value) {
                        return DropdownMenuItem<String>(
                          value: value.addUse,
                          child: Text(value.addUse),
                        );
                      }).toList(),
                      isDense: true,
                      padding: EdgeInsets.zero,
                      decoration: const InputDecoration(
                          hintText: 'Select Use', border: InputBorder.none)),
                ),
              ),
            )
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: meetingBox.listenable(),
          builder: (context, value, child) {
            return SafeArea(
              child: Center(
                child: Column(
                  children: [
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 350.h,
                            child: SfCalendar(
                              view: CalendarView.month,
                              initialDisplayDate: DateTime.now(),
                              initialSelectedDate: DateTime.now(),
                              cellBorderColor: Colors.white,
                              viewHeaderStyle: ViewHeaderStyle(
                                  dayTextStyle: TextStyle(
                                      color: const Color(0xffe4e2ac),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold)),
                              viewHeaderHeight: 70.h,
                              headerHeight: 60.h,
                              selectionDecoration: BoxDecoration(
                                  border:
                                      Border.all(color: const Color(0xffe4e2ac), width: 3),
                                  borderRadius: BorderRadius.circular(10)),
                              headerStyle: CalendarHeaderStyle(
                                  backgroundColor: Colors.white,
                                  textAlign: TextAlign.center,
                                  textStyle: TextStyle(
                                    fontSize: 25.sp,
                                    letterSpacing: 2,
                                  )),
                              showCurrentTimeIndicator: true,
                              monthViewSettings: const MonthViewSettings(
                                appointmentDisplayMode:
                                    MonthAppointmentDisplayMode.appointment,
                              ),
                              viewNavigationMode: ViewNavigationMode.snap,
                              onTap: (CalendarTapDetails calendarTapDetails) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddPage(
                                            val: meetings,
                                            calendarTapDetails:
                                                calendarTapDetails,
                                        selectedUse: selectedValue,
                                          )),
                                );
                              },
                              onViewChanged: (viewChangedDetails) {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    _visibleMonth =
                                        viewChangedDetails.visibleDates.first;
                                    print(_visibleMonth);
                                    totalAmountPerDate =
                                        _calculateSumForMonth(_visibleMonth);
                                  });
                                });
                              },
                              monthCellBuilder: (BuildContext context,
                                  MonthCellDetails details) {

                                if(selectedValue == "All") {
                                  totalAmountPerDate = _calculateSumForDate(details.date);
                                } else {
                                  totalAmountPerDate = _calculateSumForDate(
                                    details.date,
                                  );
                                }
                                return Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 20),
                                        child: Text(
                                          details.date.day.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                    totalAmountPerDate == 0
                                        ? const SizedBox()
                                        : Positioned(
                                            child: Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 2)
                                                        .r,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0),
                                                  child: Text(totalAmountPerDate
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: const Color(
                                                              0x89624E03)),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      margin: const EdgeInsets.all(10).r,
                      width: double.maxFinite,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xffe4e2ac),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text("Total Amount for $selectedValue  : ₹$totalAmountPerMonth",
                            style: TextStyle(fontSize: 15.sp)),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  List<Meeting> _getDataSource() {
    return meetings;
  }


}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).date;
  }

  @override
  String getAmount(int index) {
    return _getMeetingData(index).amount;
  }

  @override
  String getTitle(int index) {
    return _getMeetingData(index).title;
  }

  @override
  String getFrequency(int index) {
    return _getMeetingData(index).frequency;
  }

  @override
  String getUse(int index) {
    return _getMeetingData(index).use;
  }

  @override
  String getBank(int index) {
    return _getMeetingData(index).bank;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }
    return meetingData;
  }
}
