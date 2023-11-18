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
import 'package:werkaut/models/workouts/workout_plan.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/screens/workout_plan_screen.dart';
import 'package:werkaut/widgets/workouts/day.dart';
import 'package:werkaut/widgets/workouts/forms.dart';

class WorkoutPlanDetail extends StatefulWidget {
  final WorkoutPlan _workoutPlan;
  final Function _changeMode;
  const WorkoutPlanDetail(this._workoutPlan, this._changeMode);

  @override
  _WorkoutPlanDetailState createState() => _WorkoutPlanDetailState();
}

class _WorkoutPlanDetailState extends State<WorkoutPlanDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget._workoutPlan.days.isNotEmpty)
          ToggleButtons(
            renderBorder: false,
            onPressed: (int index) {
              if (index == 1) {
                widget._changeMode(WorkoutScreenMode.log);
              }
            },
            isSelected: const [true, false],
            children: const <Widget>[
              Icon(Icons.table_chart_outlined),
              Icon(Icons.show_chart),
            ],
          ),
        if (widget._workoutPlan.description != '')
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(widget._workoutPlan.description),
          ),
        ...widget._workoutPlan.days.map((workoutDay) => WorkoutDayWidget(workoutDay)).toList(),
        Column(
          children: [
            ElevatedButton(
              child: Text(AppLocalizations.of(context).newDay),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  FormScreen.routeName,
                  arguments: FormScreenArguments(
                    AppLocalizations.of(context).newDay,
                    DayFormWidget(widget._workoutPlan),
                    hasListView: true,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
