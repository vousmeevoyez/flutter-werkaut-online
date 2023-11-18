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

import 'dart:convert';

class werkautHttpException implements Exception {
  Map<String, dynamic>? errors;

  /// Custom http exception.
  /// Expects the response body of the REST call and will try to parse it to
  /// JSON. Will use the response as-is if it fails.
  werkautHttpException(dynamic responseBody) {
    if (responseBody == null) {
      errors = {'unknown_error': 'An unknown error occurred, no further information available'};
    } else {
      try {
        errors = {'unknown_error': json.decode(responseBody)};
      } catch (e) {
        errors = {'unknown_error': responseBody};
      }
    }
  }

  @override
  String toString() {
    return errors!.values.toList().join(', ');
  }
}
