import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/models/nutrition/ingredient.dart';
import 'package:werkaut/models/nutrition/log.dart';
import 'package:werkaut/models/nutrition/meal.dart';
import 'package:werkaut/models/nutrition/meal_item.dart';
import 'package:werkaut/models/nutrition/nutritional_plan.dart';
import 'package:werkaut/providers/body_weight.dart';
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/screens/nutritional_plan_screen.dart';
import 'package:werkaut/theme/theme.dart';

import '../test/user/provider_test.mocks.dart';

Widget createNutritionalPlanScreen({locale = 'en'}) {
  final mockBaseProvider = MockwerkautBaseProvider();

  final key = GlobalKey<NavigatorState>();

  final muesli = Ingredient(
    id: 1,
    code: '123456787',
    name: 'Müsli',
    created: DateTime(2021, 5, 1),
    energy: 500,
    carbohydrates: 10,
    carbohydratesSugar: 2,
    protein: 5,
    fat: 20,
    fatSaturated: 7,
    fibres: 12,
    sodium: 0.5,
  );
  final milk = Ingredient(
    id: 1,
    code: '123456787',
    name: 'Milk',
    created: DateTime(2021, 5, 1),
    energy: 500,
    carbohydrates: 10,
    carbohydratesSugar: 2,
    protein: 5,
    fat: 20,
    fatSaturated: 7,
    fibres: 12,
    sodium: 0.5,
  );
  final apple = Ingredient(
    id: 1,
    code: '123456787',
    name: 'Apple',
    created: DateTime(2021, 5, 1),
    energy: 500,
    carbohydrates: 10,
    carbohydratesSugar: 2,
    protein: 5,
    fat: 20,
    fatSaturated: 7,
    fibres: 12,
    sodium: 0.5,
  );

  final mealItem1 = MealItem(ingredientId: 1, amount: 100, ingredient: muesli);
  final mealItem2 = MealItem(ingredientId: 2, amount: 75, ingredient: milk);
  final mealItem3 = MealItem(ingredientId: 3, amount: 100, ingredient: apple);

  final meal1 = Meal(
    id: 1,
    plan: 1,
    time: const TimeOfDay(hour: 8, minute: 30),
    name: 'Breakfast',
    mealItems: [mealItem1, mealItem2],
  );

  final meal2 = Meal(
    id: 2,
    plan: 1,
    time: const TimeOfDay(hour: 11, minute: 0),
    name: 'Snack 1',
    mealItems: [mealItem3],
  );

  final NutritionalPlan plan = NutritionalPlan(
    id: 1,
    description: 'Mini diet',
    creationDate: DateTime(2021, 5, 23),
    meals: [meal1, meal2],
  );

  // Add logs
  plan.logs.add(Log.fromMealItem(mealItem1, 1, 1, DateTime(2021, 6, 1)));
  plan.logs.add(Log.fromMealItem(mealItem2, 1, 1, DateTime(2021, 6, 1)));
  plan.logs.add(Log.fromMealItem(mealItem3, 1, 1, DateTime(2021, 6, 10)));

  return MultiProvider(
    providers: [
      ChangeNotifierProvider<NutritionPlansProvider>(
        create: (context) => NutritionPlansProvider(mockBaseProvider, []),
      ),
      ChangeNotifierProvider<BodyWeightProvider>(
        create: (context) => BodyWeightProvider(mockBaseProvider),
      ),
    ],
    child: MaterialApp(
      locale: Locale(locale),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: werkautTheme,
      navigatorKey: key,
      home: TextButton(
        onPressed: () => key.currentState!.push(
          MaterialPageRoute<void>(
            settings: RouteSettings(arguments: plan),
            builder: (_) => NutritionalPlanScreen(),
          ),
        ),
        child: const SizedBox(),
      ),
    ),
  );
}
