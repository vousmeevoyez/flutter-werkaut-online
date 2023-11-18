/*
 * This file is part of werkaut Workout Manager <https://github.com/werkaut-project>.
 * Copyright (C) 2020, 2021 werkaut Team
 *
 * werkaut Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/models/workouts/day.dart';
import 'package:werkaut/providers/workout_plans.dart';
import 'package:werkaut/widgets/workouts/gym_mode.dart';

class GymModeScreen extends StatelessWidget {
  static const routeName = '/gym-mode';

  @override
  Widget build(BuildContext context) {
    final _day = ModalRoute.of(context)!.settings.arguments as Day;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<WorkoutPlansProvider>(
          builder: (context, value, child) => GymMode(_day),
        ),
      ),
    );
  }
}
