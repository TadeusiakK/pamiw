import 'package:flutter/material.dart';
import 'package:pamiw/app/widgets/my_drawer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const MyDrawer(),
      body: SfCalendar(
        view: CalendarView.week,
        dataSource: AppointmentDataSource(_appointments),
        firstDayOfWeek: 1,
        onTap: (CalendarTapDetails details) {
          if (details.appointments != null &&
              details.appointments!.isNotEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(AppLocalizations.of(context)!.delete_appointment),
                content: Text(AppLocalizations.of(context)!
                    .do_you_really_want_to_delete_this_appointment),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _appointments.remove(details.appointments![0]);
                        _saveAppointments();
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.delete),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AppointmentDialog(
              onAppointmentAdded: (appointment) {
                setState(() {
                  _appointments.add(appointment);
                  _saveAppointments();
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _saveAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String appointmentsString = jsonEncode(_appointments);
    await prefs.setString('appointments', appointmentsString);
  }

  _loadAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? appointmentsString = prefs.getString('appointments');
    if (appointmentsString != null) {
      List<dynamic> decoded = jsonDecode(appointmentsString);
      List<Appointment> appointments = decoded
          .map((appointment) => Appointment.fromJson(appointment))
          .toList();
      setState(() {
        _appointments = appointments;
      });
    }
  }
}

class AppointmentDialog extends StatefulWidget {
  final Function(Appointment) onAppointmentAdded;

  const AppointmentDialog({super.key, required this.onAppointmentAdded});

  @override
  State<AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  final _titleController = TextEditingController();
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: Text(
        AppLocalizations.of(context)!.add_appointment,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.title,
            ),
          ),
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.from),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _startDate != null
                        ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                        : '',
                  ),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.date,
                  ),
                  onTap: () async {
                    _startDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: _startTime != null
                          ? '${_startTime!.hour}:${_startTime!.minute}'
                          : ''),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.time,
                  ),
                  onTap: () async {
                    _startTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.to),
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _endDate != null
                        ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : '',
                  ),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.date,
                  ),
                  onTap: () async {
                    _endDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: _endTime != null
                          ? '${_endTime!.hour}:${_endTime!.minute}'
                          : ''),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.time,
                  ),
                  onTap: () async {
                    _endTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final appointment = Appointment(
              startTime: DateTime(
                _startDate!.year,
                _startDate!.month,
                _startDate!.day,
                _startTime!.hour,
                _startTime!.minute,
              ),
              endTime: DateTime(
                _endDate!.year,
                _endDate!.month,
                _endDate!.day,
                _endTime!.hour,
                _endTime!.minute,
              ),
              subject: _titleController.text,
              color: Colors.deepPurple,
            );
            widget.onAppointmentAdded(appointment);
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}

class Appointment {
  DateTime startTime;
  DateTime endTime;
  String subject;
  Color color;

  Appointment(
      {required this.startTime,
      required this.endTime,
      required this.subject,
      required this.color});

  Appointment.fromJson(Map<String, dynamic> json)
      : startTime = DateTime.parse(json['start']),
        endTime = DateTime.parse(json['end']),
        subject = json['subject'],
        color = Color(json['color']);

  Map<String, dynamic> toJson() => {
        'start': startTime.toIso8601String(),
        'end': endTime.toIso8601String(),
        'subject': subject,
        'color': color.value,
      };
}
