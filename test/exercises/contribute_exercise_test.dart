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

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/providers/add_exercise.dart';
import 'package:werkaut/providers/exercises.dart';
import 'package:werkaut/providers/user.dart';
import 'package:werkaut/screens/add_exercise_screen.dart';

import '../../test_data/exercises.dart';
import '../../test_data/profile.dart';
import '../workout/gym_mode_screen_test.mocks.dart';
import 'contribute_exercise_test.mocks.dart';

@GenerateMocks([AddExerciseProvider, UserProvider])
void main() {
  final mockAddExerciseProvider = MockAddExerciseProvider();
  final mockExerciseProvider = MockExercisesProvider();
  final mockUserProvider = MockUserProvider();

  Widget createExerciseScreen({locale = 'en'}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExercisesProvider>(create: (context) => mockExerciseProvider),
        ChangeNotifierProvider<AddExerciseProvider>(create: (context) => mockAddExerciseProvider),
        ChangeNotifierProvider<UserProvider>(create: (context) => mockUserProvider),
      ],
      child: MaterialApp(
        locale: Locale(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const AddExerciseScreen(),
      ),
    );
  }

  testWidgets('Unverified users see an info widget', (WidgetTester tester) async {
    // Arrange
    tProfile1.isTrustworthy = false;
    when(mockUserProvider.profile).thenReturn(tProfile1);

    // Act
    await tester.pumpWidget(createExerciseScreen());

    // Assert
    expect(find.byType(EmailNotVerified), findsOneWidget);
    expect(find.byType(AddExerciseStepper), findsNothing);
  });

  testWidgets('Verified users see the stepper to add exercises', (WidgetTester tester) async {
    // Arrange
    tProfile1.isTrustworthy = true;
    when(mockUserProvider.profile).thenReturn(tProfile1);

    when(mockExerciseProvider.categories).thenReturn(testCategories);
    when(mockExerciseProvider.muscles).thenReturn(testMuscles);
    when(mockExerciseProvider.equipment).thenReturn(testEquipment);
    when(mockExerciseProvider.exerciseBasesByVariation).thenReturn({});
    when(mockExerciseProvider.bases).thenReturn(getTestExerciseBases());
    when(mockExerciseProvider.languages).thenReturn(testLanguages);

    when(mockAddExerciseProvider.equipment).thenReturn([]);
    when(mockAddExerciseProvider.primaryMuscles).thenReturn([]);
    when(mockAddExerciseProvider.secondaryMuscles).thenReturn([]);
    when(mockAddExerciseProvider.newVariationForExercise).thenReturn(null);

    // Act
    await tester.pumpWidget(createExerciseScreen());

    // Assert
    expect(find.byType(EmailNotVerified), findsNothing);
    expect(find.byType(AddExerciseStepper), findsOneWidget);
  });
}
