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

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language extends Equatable {
  @JsonKey(required: true)
  final int id;

  @JsonKey(required: true, name: 'short_name')
  final String shortName;

  @JsonKey(required: true, name: 'full_name')
  final String fullName;

  const Language({
    required this.id,
    required this.shortName,
    required this.fullName,
  });

  // Boilerplate
  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @override
  List<Object?> get props => [id, shortName, fullName];
}
