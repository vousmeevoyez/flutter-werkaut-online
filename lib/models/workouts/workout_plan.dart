/*
 * This file is part of werkaut Workout Manager <https://github.com/werkaut-project>.
 * Copyright (C) 2020 werkaut Team
 *
 * werkaut Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * werkaut Workout Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:werkaut/models/exercises/base.dart';
import 'package:werkaut/models/workouts/day.dart';
import 'package:werkaut/models/workouts/log.dart';

part 'workout_plan.g.dart';

@JsonSerializable()
class WorkoutPlan {
  @JsonKey(required: true)
  int? id;

  @JsonKey(required: true, name: 'creation_date')
  late DateTime creationDate;

  @JsonKey(required: true, name: 'name')
  late String name;

  @JsonKey(required: true, name: 'description')
  late String description;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Day> days = [];

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Log> logs = [];

  WorkoutPlan({
    this.id,
    required this.creationDate,
    required this.name,
    String? description,
    List<Day>? days,
    List<Log>? logs,
  }) {
    this.days = days ?? [];
    this.logs = logs ?? [];
    this.description = description ?? '';
  }

  WorkoutPlan.empty() {
    creationDate = DateTime.now();
    name = '';
    description = '';
  }

  // Boilerplate
  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => _$WorkoutPlanFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutPlanToJson(this);

  /// Filters the workout logs by exercise and sorts them by date
  ///
  /// Optionally, filters list so that only unique logs are returned. "Unique"
  /// means here that the values are the same, i.e. logs with the same weight,
  /// reps, etc. are considered equal. Workout ID, Log ID and date are not
  /// considered.
  List<Log> filterLogsByExerciseBase(ExerciseBase exerciseBase, {bool unique = false}) {
    var out = logs.where((element) => element.exerciseBaseId == exerciseBase.id).toList();

    if (unique) {
      out = out.toSet().toList();
    }

    out.sort((a, b) => b.date.compareTo(a.date));
    return out;
  }

  /// Massages the log data to more easily present on the log overview
  ///
  Map<DateTime, Map<String, dynamic>> get logData {
    final out = <DateTime, Map<String, dynamic>>{};
    for (final log in logs) {
      final exercise = log.exerciseBaseObj;
      final date = log.date;

      if (!out.containsKey(date)) {
        out[date] = {
          'session': null,
          'exercises': <ExerciseBase, List<Log>>{},
        };
      }

      if (!out[date]!['exercises']!.containsKey(exercise)) {
        out[date]!['exercises']![exercise] = <Log>[];
      }

      out[date]!['exercises']![exercise].add(log);
    }

    return out;
  }
}
