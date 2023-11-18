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
import 'package:provider/provider.dart';
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/widgets/core/app_bar.dart';
import 'package:werkaut/widgets/nutrition/forms.dart';
import 'package:werkaut/widgets/nutrition/nutritional_plans_list.dart';

class NutritionScreen extends StatelessWidget {
  static const routeName = '/nutrition';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(AppLocalizations.of(context).nutritionalPlans),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.pushNamed(
            context,
            FormScreen.routeName,
            arguments: FormScreenArguments(
              AppLocalizations.of(context).newNutritionalPlan,
              PlanForm(),
            ),
          );
        },
      ),
      body: Consumer<NutritionPlansProvider>(
        builder: (context, nutritionProvider, child) => NutritionalPlansList(nutritionProvider),
      ),
    );
  }
}