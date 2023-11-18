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
import 'package:werkaut/helpers/consts.dart';
import 'package:werkaut/helpers/json.dart';
import 'package:werkaut/models/nutrition/meal.dart';
import 'package:werkaut/models/nutrition/nutritional_plan.dart';
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/screens/nutritional_plan_screen.dart';
import 'package:werkaut/widgets/nutrition/forms.dart';

import '../../test_data/nutritional_plans.dart';
import 'nutritional_meal_form_test.mocks.dart';

@GenerateMocks([NutritionPlansProvider])
void main() {
  var mockNutrition = MockNutritionPlansProvider();

  var plan1 = NutritionalPlan.empty();
  var meal1 = Meal();
  final meal2 = Meal();

  when(mockNutrition.editMeal(any)).thenAnswer((_) => Future.value(Meal()));
  when(mockNutrition.addMeal(any, any)).thenAnswer((_) => Future.value(Meal()));

  setUp(() {
    plan1 = getNutritionalPlan();
    meal1 = plan1.meals.first;
    mockNutrition = MockNutritionPlansProvider();
  });

  Widget createHomeScreen(Meal meal, {locale = 'en'}) {
    final key = GlobalKey<NavigatorState>();

    return ChangeNotifierProvider<NutritionPlansProvider>(
      create: (context) => mockNutrition,
      child: MaterialApp(
        locale: Locale(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorKey: key,
        home: Scaffold(
          body: MealForm(1, meal),
        ),
        routes: {
          NutritionalPlanScreen.routeName: (ctx) => NutritionalPlanScreen(),
        },
      ),
    );
  }

  testWidgets('Test the widgets on the meal form', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen(meal1));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byKey(const Key(SUBMIT_BUTTON_KEY_NAME)), findsOneWidget);
  });

  testWidgets('Test editing an existing meal', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen(meal1));
    await tester.pumpAndSettle();

    expect(
      find.text('17:00'),
      findsOneWidget,
      reason: 'Time of existing meal is filled in',
    );

    expect(
      find.text('Initial Name 1'),
      findsOneWidget,
      reason: 'Time of existing meal is filled in',
    );

    await tester.enterText(find.byKey(const Key('field-time')), '12:34');
    await tester.enterText(find.byKey(const Key('field-name')), 'test meal');
    await tester.tap(find.byKey(const Key(SUBMIT_BUTTON_KEY_NAME)));

    // Correct method was called
    verify(mockNutrition.editMeal(any));
    verifyNever(mockNutrition.addMeal(any, any));
  });

  testWidgets('Test creating a new nutritional plan', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen(meal2));
    await tester.pumpAndSettle();

    expect(
      find.text(timeToString(TimeOfDay.now())!),
      findsOneWidget,
      reason: 'Current time is filled in',
    );

    await tester.enterText(find.byKey(const Key('field-time')), '08:00');
    await tester.enterText(find.byKey(const Key('field-name')), 'test meal');
    await tester.tap(find.byKey(const Key(SUBMIT_BUTTON_KEY_NAME)));

    // Correct method was called
    verifyNever(mockNutrition.editMeal(any));
    verify(mockNutrition.addMeal(any, any));

    // Detail page
    // ...
  });
}
