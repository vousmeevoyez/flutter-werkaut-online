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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/providers/add_exercise.dart';
import 'package:werkaut/providers/base_provider.dart';
import 'package:werkaut/providers/body_weight.dart';
import 'package:werkaut/providers/exercises.dart';
import 'package:werkaut/providers/gallery.dart';
import 'package:werkaut/providers/measurement.dart';
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/providers/user.dart';
import 'package:werkaut/providers/workout_plans.dart';
import 'package:werkaut/screens/add_exercise_screen.dart';
import 'package:werkaut/screens/auth_screen.dart';
import 'package:werkaut/screens/dashboard.dart';
import 'package:werkaut/screens/exercise_screen.dart';
import 'package:werkaut/screens/exercises_screen.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/screens/gallery_screen.dart';
import 'package:werkaut/screens/gym_mode.dart';
import 'package:werkaut/screens/home_tabs_screen.dart';
import 'package:werkaut/screens/measurement_categories_screen.dart';
import 'package:werkaut/screens/measurement_entries_screen.dart';
import 'package:werkaut/screens/nutritional_diary_screen.dart';
import 'package:werkaut/screens/nutritional_plan_screen.dart';
import 'package:werkaut/screens/nutritional_plans_screen.dart';
import 'package:werkaut/screens/splash_screen.dart';
import 'package:werkaut/screens/weight_screen.dart';
import 'package:werkaut/screens/workout_plan_screen.dart';
import 'package:werkaut/screens/workout_plans_screen.dart';
import 'package:werkaut/theme/theme.dart';
import 'package:werkaut/widgets/core/about.dart';

import 'providers/auth.dart';

void main() {
  zx.setLogEnabled(kDebugMode);
  // Needs to be called before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ExercisesProvider>(
          create: (context) => ExercisesProvider(
              werkautBaseProvider(Provider.of<AuthProvider>(context, listen: false))),
          update: (context, base, previous) =>
              previous ?? ExercisesProvider(werkautBaseProvider(base)),
        ),
        ChangeNotifierProxyProvider2<AuthProvider, ExercisesProvider, WorkoutPlansProvider>(
          create: (context) => WorkoutPlansProvider(
            werkautBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
            Provider.of<ExercisesProvider>(context, listen: false),
            [],
          ),
          update: (context, auth, exercises, previous) =>
              previous ?? WorkoutPlansProvider(werkautBaseProvider(auth), exercises, []),
        ),
        ChangeNotifierProxyProvider<AuthProvider, NutritionPlansProvider>(
          create: (context) => NutritionPlansProvider(
            werkautBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
            [],
          ),
          update: (context, auth, previous) =>
              previous ?? NutritionPlansProvider(werkautBaseProvider(auth), []),
        ),
        ChangeNotifierProxyProvider<AuthProvider, MeasurementProvider>(
          create: (context) => MeasurementProvider(
            werkautBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
          ),
          update: (context, base, previous) =>
              previous ?? MeasurementProvider(werkautBaseProvider(base)),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(
            werkautBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
          ),
          update: (context, base, previous) => previous ?? UserProvider(werkautBaseProvider(base)),
        ),
        ChangeNotifierProxyProvider<AuthProvider, BodyWeightProvider>(
          create: (context) => BodyWeightProvider(
            werkautBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
          ),
          update: (context, base, previous) =>
              previous ?? BodyWeightProvider(werkautBaseProvider(base)),
        ),
        ChangeNotifierProxyProvider<AuthProvider, GalleryProvider>(
          create: (context) =>
              GalleryProvider(Provider.of<AuthProvider>(context, listen: false), []),
          update: (context, auth, previous) => previous ?? GalleryProvider(auth, []),
        ),
        ChangeNotifierProxyProvider<AuthProvider, AddExerciseProvider>(
          create: (context) => AddExerciseProvider(
            werkautBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
          ),
          update: (context, base, previous) =>
              previous ?? AddExerciseProvider(werkautBaseProvider(base)),
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'werkaut',
          theme: werkautTheme,
          home: auth.isAuth
              ? HomeTabsScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            DashboardScreen.routeName: (ctx) => DashboardScreen(),
            FormScreen.routeName: (ctx) => FormScreen(),
            GalleryScreen.routeName: (ctx) => const GalleryScreen(),
            GymModeScreen.routeName: (ctx) => GymModeScreen(),
            HomeTabsScreen.routeName: (ctx) => HomeTabsScreen(),
            MeasurementCategoriesScreen.routeName: (ctx) => MeasurementCategoriesScreen(),
            MeasurementEntriesScreen.routeName: (ctx) => MeasurementEntriesScreen(),
            NutritionScreen.routeName: (ctx) => NutritionScreen(),
            NutritionalDiaryScreen.routeName: (ctx) => NutritionalDiaryScreen(),
            NutritionalPlanScreen.routeName: (ctx) => NutritionalPlanScreen(),
            WeightScreen.routeName: (ctx) => WeightScreen(),
            WorkoutPlanScreen.routeName: (ctx) => WorkoutPlanScreen(),
            WorkoutPlansScreen.routeName: (ctx) => WorkoutPlansScreen(),
            ExercisesScreen.routeName: (ctx) => const ExercisesScreen(),
            ExerciseDetailScreen.routeName: (ctx) => const ExerciseDetailScreen(),
            AddExerciseScreen.routeName: (ctx) => const AddExerciseScreen(),
            AboutPage.routeName: (ctx) => const AboutPage(),
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
