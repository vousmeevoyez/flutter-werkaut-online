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

import 'package:json_annotation/json_annotation.dart';
import 'package:werkaut/helpers/json.dart';
import 'package:werkaut/models/nutrition/ingredient.dart';
import 'package:werkaut/models/nutrition/ingredient_weight_unit.dart';
import 'package:werkaut/models/nutrition/meal_item.dart';
import 'package:werkaut/models/nutrition/nutritional_values.dart';

part 'log.g.dart';

@JsonSerializable()
class Log {
  @JsonKey(required: true)
  int? id;

  @JsonKey(required: false, name: 'meal')
  int? mealId;

  @JsonKey(required: true, name: 'plan')
  int planId;

  @JsonKey(required: true)
  late DateTime datetime;

  String? comment;

  @JsonKey(required: true, name: 'ingredient')
  late int ingredientId;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late Ingredient ingredientObj;

  @JsonKey(required: true, name: 'weight_unit')
  int? weightUnitId;

  @JsonKey(includeFromJson: false, includeToJson: false)
  IngredientWeightUnit? weightUnitObj;

  @JsonKey(required: true, fromJson: stringToNum)
  late num amount;

  Log({
    this.id,
    required this.mealId,
    required this.ingredientId,
    required this.weightUnitId,
    required this.amount,
    required this.planId,
    required this.datetime,
    this.comment,
  });

  Log.fromMealItem(MealItem mealItem, this.planId, this.mealId, [DateTime? dateTime]) {
    ingredientId = mealItem.ingredientId;
    ingredientObj = mealItem.ingredientObj;
    weightUnitId = mealItem.weightUnitId;
    datetime = dateTime ?? DateTime.now();
    amount = mealItem.amount;
  }

  // Boilerplate
  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  Map<String, dynamic> toJson() => _$LogToJson(this);

  /// Calculations
  NutritionalValues get nutritionalValues {
    // This is already done on the server. It might be better to read it from there.
    final out = NutritionalValues();

    //final weight = amount;
    final weight =
        weightUnitObj == null ? amount : amount * weightUnitObj!.amount * weightUnitObj!.grams;

    out.energy = ingredientObj.energy * weight / 100;
    out.protein = ingredientObj.protein * weight / 100;
    out.carbohydrates = ingredientObj.carbohydrates * weight / 100;
    out.carbohydratesSugar = ingredientObj.carbohydratesSugar * weight / 100;
    out.fat = ingredientObj.fat * weight / 100;
    out.fatSaturated = ingredientObj.fatSaturated * weight / 100;
    out.fibres = ingredientObj.fibres * weight / 100;
    out.sodium = ingredientObj.sodium * weight / 100;

    return out;
  }
}
