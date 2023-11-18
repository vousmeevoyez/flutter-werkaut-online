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

import 'package:json_annotation/json_annotation.dart';
import 'package:werkaut/helpers/json.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {
  @JsonKey(required: true)
  int? id;

  @JsonKey(required: true, toJson: toDate)
  late DateTime date;

  @JsonKey(required: true, name: 'image')
  String? url;

  @JsonKey(defaultValue: '')
  late String description;

  Image({
    required this.id,
    required this.date,
    required this.url,
    required this.description,
  });

  Image.emtpy() {
    date = DateTime.now();
    description = '';
  }

  // Boilerplate
  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
