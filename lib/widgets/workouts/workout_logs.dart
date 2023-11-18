/*
 * This file is part of werkaut Workout Manager <https://github.com/werkaut-project>.
 * Copyright (C) 2020, 2021 werkaut Team
 *
 * werkaut Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * werkaut Workout Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:werkaut/helpers/consts.dart';
import 'package:werkaut/models/exercises/base.dart';
import 'package:werkaut/models/workouts/log.dart';
import 'package:werkaut/models/workouts/session.dart';
import 'package:werkaut/models/workouts/workout_plan.dart';
import 'package:werkaut/screens/workout_plan_screen.dart';
import 'package:werkaut/theme/theme.dart';
import 'package:werkaut/widgets/workouts/log.dart';

class WorkoutLogs extends StatefulWidget {
  final WorkoutPlan _workoutPlan;
  final Function _changeMode;
  const WorkoutLogs(this._workoutPlan, this._changeMode);

  @override
  _WorkoutLogsState createState() => _WorkoutLogsState();
}

class _WorkoutLogsState extends State<WorkoutLogs> {
  final dayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          renderBorder: false,
          onPressed: (int index) {
            if (index == 0) {
              widget._changeMode(WorkoutScreenMode.workout);
            }
          },
          isSelected: const [false, true],
          children: const <Widget>[
            Icon(
              Icons.table_chart_outlined,
            ),
            Icon(
              Icons.show_chart,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            AppLocalizations.of(context).labelWorkoutLogs,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context).logHelpEntries,
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context).logHelpEntriesUnits,
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: WorkoutLogCalendar(widget._workoutPlan),
        ),
      ],
    );
  }
}

/// An event in the workout log calendar
class WorkoutLogEvent {
  final DateTime dateTime;
  final WorkoutSession? session;
  final Map<ExerciseBase, List<Log>> exercises;

  WorkoutLogEvent(this.dateTime, this.session, this.exercises);
}

class WorkoutLogCalendar extends StatefulWidget {
  final WorkoutPlan _workoutPlan;

  const WorkoutLogCalendar(this._workoutPlan);

  @override
  _WorkoutLogCalendarState createState() => _WorkoutLogCalendarState();
}

class _WorkoutLogCalendarState extends State<WorkoutLogCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<WorkoutLogEvent>> _selectedEvents;
  late Map<String, List<WorkoutLogEvent>> _events;

  @override
  void initState() {
    super.initState();

    _events = {};
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    loadEvents();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void loadEvents() {
    for (final date in widget._workoutPlan.logData.keys) {
      final entry = widget._workoutPlan.logData[date]!;
      _events[DateFormatLists.format(date)] = [
        WorkoutLogEvent(
          date,
          entry['session'],
          entry['exercises'],
        )
      ];
    }

    // Add initial selected day to events list
    _selectedEvents.value = _getEventsForDay(_selectedDay!);
  }

  List<WorkoutLogEvent> _getEventsForDay(DateTime day) {
    return _events[DateFormatLists.format(day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          locale: Localizations.localeOf(context).languageCode,
          firstDay: DateTime.now().subtract(const Duration(days: 1000)),
          lastDay: DateTime.now(),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: werkautCalendarStyle,
          eventLoader: _getEventsForDay,
          availableGestures: AvailableGestures.horizontalSwipe,
          availableCalendarFormats: const {
            CalendarFormat.month: '',
          },
          onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          child: ValueListenableBuilder<List<WorkoutLogEvent>>(
              valueListenable: _selectedEvents,
              builder: (context, logEvents, _) {
                // At the moment there is only one "event" per day
                return logEvents.isNotEmpty
                    ? DayLogWidget(
                        logEvents.first.dateTime,
                        logEvents.first.exercises,
                        logEvents.first.session,
                      )
                    : Container();
              }),
        ),
      ],
    );
  }
}
