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

part 'alias.g.dart';

@JsonSerializable()
class Alias {
  @JsonKey(required: true)
  final int? id;

  @JsonKey(required: true, name: 'exercise')
  final int exerciseId;

  @JsonKey(required: true)
  final String alias;

  Alias({
    this.id,
    required this.exerciseId,
    required this.alias,
  });

  // Boilerplate
  factory Alias.fromJson(Map<String, dynamic> json) => _$AliasFromJson(json);
  Map<String, dynamic> toJson() => _$AliasToJson(this);
}
