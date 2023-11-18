import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/providers/workout_plans.dart';
import 'package:werkaut/screens/workout_plan_screen.dart';
import 'package:werkaut/theme/theme.dart';

import '../test/workout/workout_form_test.mocks.dart';
import '../test_data/workouts.dart';

Widget createWorkoutDetailScreen({locale = 'en'}) {
  final key = GlobalKey<NavigatorState>();

  final mockWorkoutProvider = MockWorkoutPlansProvider();
  final workout = getWorkout();
  when(mockWorkoutProvider.activePlan).thenReturn(workout);
  when(mockWorkoutProvider.fetchAndSetWorkoutPlanFull(1)).thenAnswer((_) => Future.value(workout));

  return MultiProvider(
    providers: [
      ChangeNotifierProvider<WorkoutPlansProvider>(
        create: (context) => mockWorkoutProvider,
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
            settings: RouteSettings(arguments: getWorkout()),
            builder: (_) => WorkoutPlanScreen(),
          ),
        ),
        child: const SizedBox(),
      ),
    ),
  );
}
