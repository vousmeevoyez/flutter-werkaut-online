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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:werkaut/providers/auth.dart';
import 'package:werkaut/providers/body_weight.dart';
import 'package:werkaut/providers/exercises.dart';
import 'package:werkaut/providers/gallery.dart';
import 'package:werkaut/providers/measurement.dart';
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/providers/user.dart';
import 'package:werkaut/providers/workout_plans.dart';
import 'package:werkaut/screens/dashboard.dart';
import 'package:werkaut/screens/gallery_screen.dart';
import 'package:werkaut/screens/nutritional_plans_screen.dart';
import 'package:werkaut/screens/weight_screen.dart';
import 'package:werkaut/screens/workout_plans_screen.dart';
import 'package:werkaut/theme/theme.dart';

class HomeTabsScreen extends StatefulWidget {
  static const routeName = '/dashboard2';

  @override
  _HomeTabsScreenState createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> with SingleTickerProviderStateMixin {
  late Future<void> _initialData;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Loading data here, since the build method can be called more than once
    _initialData = _loadEntries();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _screenList = [
    DashboardScreen(),
    WorkoutPlansScreen(),
    NutritionScreen(),
    WeightScreen(),
    const GalleryScreen(),
  ];

  /// Load initial data from the server
  Future<void> _loadEntries() async {
    final authProvider = context.read<AuthProvider>();

    if (!authProvider.dataInit) {
      final workoutPlansProvider = context.read<WorkoutPlansProvider>();
      final nutritionPlansProvider = context.read<NutritionPlansProvider>();
      final exercisesProvider = context.read<ExercisesProvider>();
      final galleryProvider = context.read<GalleryProvider>();
      final weightProvider = context.read<BodyWeightProvider>();
      final measurementProvider = context.read<MeasurementProvider>();
      final userProvider = context.read<UserProvider>();

      // Base data
      log('Loading base data');
      try {
        await Future.wait([
          authProvider.setServerVersion(),
          userProvider.fetchAndSetProfile(),
          workoutPlansProvider.fetchAndSetUnits(),
          nutritionPlansProvider.fetchIngredientsFromCache(),
          exercisesProvider.fetchAndSetExercises(),
        ]);
      } catch (e) {
        log('fire! fire!');
        log(e.toString());
      }

      // Plans, weight and gallery
      log('Loading plans, weight, measurements and gallery');
      await Future.wait([
        galleryProvider.fetchAndSetGallery(),
        nutritionPlansProvider.fetchAndSetAllPlansSparse(),
        workoutPlansProvider.fetchAndSetAllPlansSparse(),
        weightProvider.fetchAndSetEntries(),
        measurementProvider.fetchAndSetAllCategoriesAndEntries(),
      ]);

      // Current nutritional plan
      log('Loading current nutritional plan');
      if (nutritionPlansProvider.currentPlan != null) {
        final plan = nutritionPlansProvider.currentPlan!;
        await nutritionPlansProvider.fetchAndSetPlanFull(plan.id!);
      }

      // Current workout plan
      log('Loading current workout plan');
      if (workoutPlansProvider.activePlan != null) {
        final planId = workoutPlansProvider.activePlan!.id!;
        await workoutPlansProvider.fetchAndSetWorkoutPlanFull(planId);
        workoutPlansProvider.setCurrentPlan(planId);
      }
    }

    authProvider.dataInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialData,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: SizedBox(
                      height: 70,
                      child: RiveAnimation.asset(
                        'assets/animations/werkaut_logo.riv',
                        animations: ['idle_loop2'],
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).loadingText,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: _screenList.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.dashboard),
                  label: AppLocalizations.of(context).labelDashboard,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.fitness_center),
                  label: AppLocalizations.of(context).labelBottomNavWorkout,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.restaurant),
                  label: AppLocalizations.of(context).labelBottomNavNutrition,
                ),
                BottomNavigationBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.weightScale,
                    size: 20,
                  ),
                  label: AppLocalizations.of(context).weight,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.photo_library),
                  label: AppLocalizations.of(context).gallery,
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: werkautPrimaryColorLight,
              backgroundColor: werkautPrimaryColor,
              onTap: _onItemTapped,
              showUnselectedLabels: false,
            ),
          );
        }
      },
    );
  }
}
