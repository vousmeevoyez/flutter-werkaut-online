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

import 'package:werkaut/providers/auth.dart';
import 'package:werkaut/providers/exercises.dart';

import 'measurements/measurement_provider_test.mocks.dart';
import 'other/base_provider_test.mocks.dart';

// Test Auth provider
final AuthProvider testAuthProvider = AuthProvider(MockClient(), false)
  ..token = 'FooBar'
  ..serverUrl = 'https://localhost';

// Test Exercises provider
final mockBaseProvider = MockwerkautBaseProvider();
final ExercisesProvider testExercisesProvider = ExercisesProvider(mockBaseProvider);
