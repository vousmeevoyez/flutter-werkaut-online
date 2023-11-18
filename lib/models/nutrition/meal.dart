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
import 'package:json_annotation/json_annotation.dart';
import 'package:werkaut/helpers/json.dart';
import 'package:werkaut/models/nutrition/meal_item.dart';
import 'package:werkaut/models/nutrition/nutritional_values.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  @JsonKey(required: false)
  late int? id;

  @JsonKey(name: 'plan')
  late int planId;

  @JsonKey(toJson: timeToString, fromJson: stringToTime)
  TimeOfDay? time;

  @JsonKey(name: 'name')
  late String name;

  @JsonKey(includeFromJson: false, includeToJson: false, name: 'meal_items', defaultValue: [])
  List<MealItem> mealItems = [];

  Meal({
    this.id,
    int? plan,
    TimeOfDay? time,
    String? name,
    List<MealItem>? mealItems,
  }) {
    if (plan != null) {
      planId = plan;
    }

    this.mealItems = mealItems ?? [];

    this.time = time ?? TimeOfDay.now();
    this.name = name ?? '';
  }

  // Boilerplate
  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);

  /// Calculations
  NutritionalValues get nutritionalValues {
    // This is already done on the server. It might be better to read it from there.
    var out = NutritionalValues();

    for (final item in mealItems) {
      out += item.nutritionalValues;
    }

    return out;
  }
}
