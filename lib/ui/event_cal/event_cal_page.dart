import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class EventCalPage extends StatefulWidget {
  const EventCalPage({super.key});

  @override
  State<EventCalPage> createState() => _EventCalPageState();
}

class _EventCalPageState extends State<EventCalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventCalendar(
        calendarType: CalendarType.GREGORIAN,
        calendarLanguage: 'en',
        events: [
          Event(
            child: const Text('Laravel Event'),
            dateTime: CalendarDateTime(
              year: 1401,
              month: 5,
              day: 12,
              calendarType: CalendarType.JALALI,
            ),
            onTap: (listIndex) {
              print("+++++++$listIndex+++++++++++++++");
            },

          ),

        ],
        showEvents: true,


      )
    );
  }
}
