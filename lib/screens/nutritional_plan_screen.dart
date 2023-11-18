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
import 'package:werkaut/models/nutrition/nutritional_plan.dart';
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/widgets/nutrition/forms.dart';
import 'package:werkaut/widgets/nutrition/nutritional_plan_detail.dart';

enum NutritionalPlanOptions {
  edit,
  delete,
  toggleMode,
}

class NutritionalPlanScreen extends StatelessWidget {
  static const routeName = '/nutritional-plan-detail';

  Future<NutritionalPlan> _loadFullPlan(BuildContext context, int planId) {
    return Provider.of<NutritionPlansProvider>(context, listen: false).fetchAndSetPlanFull(planId);
  }

  @override
  Widget build(BuildContext context) {
    final _nutritionalPlan = ModalRoute.of(context)!.settings.arguments as NutritionalPlan;

    return Scaffold(
      //appBar: getAppBar(nutritionalPlan),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.history_edu),
        onPressed: () {
          Navigator.pushNamed(
            context,
            FormScreen.routeName,
            arguments: FormScreenArguments(
              AppLocalizations.of(context).logIngredient,
              IngredientLogForm(_nutritionalPlan),
              hasListView: true,
            ),
          );
        },
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            actions: [
              PopupMenuButton<NutritionalPlanOptions>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  // Edit
                  if (value == NutritionalPlanOptions.edit) {
                    Navigator.pushNamed(
                      context,
                      FormScreen.routeName,
                      arguments: FormScreenArguments(
                        AppLocalizations.of(context).edit,
                        PlanForm(_nutritionalPlan),
                      ),
                    );

                    // Delete
                  } else if (value == NutritionalPlanOptions.delete) {
                    Provider.of<NutritionPlansProvider>(context, listen: false)
                        .deletePlan(_nutritionalPlan.id!);
                    Navigator.of(context).pop();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<NutritionalPlanOptions>(
                      value: NutritionalPlanOptions.edit,
                      child: Text(AppLocalizations.of(context).edit),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<NutritionalPlanOptions>(
                      value: NutritionalPlanOptions.delete,
                      child: Text(AppLocalizations.of(context).delete),
                    ),
                  ];
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_nutritionalPlan.getLabel(context)),
              background: const Image(
                image: AssetImage('assets/images/backgrounds/nutritional_plans.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder(
            future: _loadFullPlan(context, _nutritionalPlan.id!),
            builder: (context, AsyncSnapshot<NutritionalPlan> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const SizedBox(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          ],
                        ),
                      )
                    : Consumer<NutritionPlansProvider>(
                        builder: (context, value, child) =>
                            NutritionalPlanDetailWidget(_nutritionalPlan)),
          ),
        ],
      ),
    );
  }
}
