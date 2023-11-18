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
import 'package:werkaut/models/nutrition/image.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  @JsonKey(required: true)
  final int id;

  /// Barcode of the product
  @JsonKey(required: true)
  final String? code;

  /// Name of the product
  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true, name: 'created')
  final DateTime created;

  /// Energy in kJ per 100g of product
  @JsonKey(required: true)
  final int energy;

  /// g per 100g of product
  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString)
  final num carbohydrates;

  /// g per 100g of product
  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString, name: 'carbohydrates_sugar')
  final num carbohydratesSugar;

  /// g per 100g of product
  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString)
  final num protein;

  /// g per 100g of product
  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString)
  final num fat;

  /// g per 100g of product
  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString, name: 'fat_saturated')
  final num fatSaturated;

  /// g per 100g of product
  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString)
  final num fibres;

  /// g per 100g of product
  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString)
  final num sodium;

  IngredientImage? image;

  Ingredient({
    required this.id,
    required this.code,
    required this.name,
    required this.created,
    required this.energy,
    required this.carbohydrates,
    required this.carbohydratesSugar,
    required this.protein,
    required this.fat,
    required this.fatSaturated,
    required this.fibres,
    required this.sodium,
    this.image,
  });

  // Boilerplate
  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
