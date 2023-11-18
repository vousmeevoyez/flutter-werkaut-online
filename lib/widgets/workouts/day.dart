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
import 'package:werkaut/helpers/consts.dart';
import 'package:werkaut/models/workouts/day.dart';
import 'package:werkaut/models/workouts/set.dart';
import 'package:werkaut/models/workouts/setting.dart';
import 'package:werkaut/providers/workout_plans.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/screens/gym_mode.dart';
import 'package:werkaut/theme/theme.dart';
import 'package:werkaut/widgets/core/core.dart';
import 'package:werkaut/widgets/exercises/exercises.dart';
import 'package:werkaut/widgets/exercises/images.dart';
import 'package:werkaut/widgets/workouts/forms.dart';

class SettingWidget extends StatelessWidget {
  final Set set;
  final Setting setting;
  final bool expanded;
  final Function toggle;

  const SettingWidget({
    required this.set,
    required this.setting,
    required this.expanded,
    required this.toggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        child: SizedBox(
          width: 45,
          child: ExerciseImageWidget(image: setting.exerciseBaseObj.getMainImage),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(setting.exerciseBaseObj
                    .getExercise(Localizations.localeOf(context).languageCode)
                    .name),
                content: ExerciseDetail(setting.exerciseBaseObj),
                actions: [
                  TextButton(
                    child: Text(MaterialLocalizations.of(context).closeButtonLabel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      title: Text(
          setting.exerciseBaseObj.getExercise(Localizations.localeOf(context).languageCode).name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...set.getSmartRepr(setting.exerciseBaseObj).map((e) => Text(e)).toList(),
        ],
      ),
    );
  }
}

class WorkoutDayWidget extends StatefulWidget {
  final Day _day;

  const WorkoutDayWidget(this._day);

  @override
  _WorkoutDayWidgetState createState() => _WorkoutDayWidgetState();
}

class _WorkoutDayWidgetState extends State<WorkoutDayWidget> {
  bool _expanded = false;
  late List<Set> _sets;

  @override
  void initState() {
    super.initState();
    _sets = widget._day.sets;
    _sets.sort((a, b) => a.order.compareTo(b.order));
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  Widget getSetRow(Set set, int index) {
    return Row(
      key: ValueKey(set.id),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_expanded)
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.delete),
            iconSize: ICON_SIZE_SMALL,
            onPressed: () {
              Provider.of<WorkoutPlansProvider>(context, listen: false).deleteSet(set);
            },
          ),
        Expanded(
          child: Column(
            children: [
              if (set.comment != '') MutedText(set.comment),
              ...set.settingsFiltered
                  .map(
                    (setting) => SettingWidget(
                      set: set,
                      setting: setting,
                      expanded: _expanded,
                      toggle: _toggleExpanded,
                    ),
                  )
                  .toList(),
              const Divider(),
            ],
          ),
        ),
        if (_expanded)
          ReorderableDragStartListener(
            index: index,
            child: const IconButton(
              icon: Icon(Icons.drag_handle),
              onPressed: null,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            DayHeaderDismissible(
              day: widget._day,
              expanded: _expanded,
              toggle: _toggleExpanded,
            ),
            if (_expanded)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<WorkoutPlansProvider>(context, listen: false).deleteDay(
                        widget._day,
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  if (widget._day.sets.isNotEmpty)
                    Ink(
                      decoration: const ShapeDecoration(
                        color: werkautPrimaryButtonColor,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.play_arrow),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            GymModeScreen.routeName,
                            arguments: widget._day,
                          );
                        },
                      ),
                    ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        FormScreen.routeName,
                        arguments: FormScreenArguments(
                          AppLocalizations.of(context).edit,
                          DayFormWidget(
                              Provider.of<WorkoutPlansProvider>(context, listen: false)
                                  .findById(widget._day.workoutId),
                              widget._day),
                          hasListView: true,
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            const Divider(),
            ReorderableListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              buildDefaultDragHandles: false,
              onReorder: (oldIndex, newIndex) async {
                int startIndex = 0;
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                  startIndex = oldIndex;
                } else {
                  startIndex = newIndex;
                }
                setState(() {
                  _sets.insert(newIndex, _sets.removeAt(oldIndex));
                });
                _sets = await Provider.of<WorkoutPlansProvider>(context, listen: false)
                    .reorderSets(_sets, startIndex);
              },
              children: [
                for (var i = 0; i < widget._day.sets.length; i++) getSetRow(widget._day.sets[i], i),
              ],
            ),
            OutlinedButton(
              child: Text(AppLocalizations.of(context).addSet),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  FormScreen.routeName,
                  arguments: FormScreenArguments(
                    AppLocalizations.of(context).newSet,
                    SetFormWidget(widget._day),
                    hasListView: true,
                    backgroundColor: werkautBackground,
                    padding: EdgeInsets.zero,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DayHeaderDismissible extends StatelessWidget {
  final Day _day;
  final bool _expanded;
  final Function _toggle;

  const DayHeaderDismissible({
    required Day day,
    required bool expanded,
    required Function toggle,
  })  : _day = day,
        _expanded = expanded,
        _toggle = toggle;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_day.id.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: werkautPrimaryButtonColor, //Theme.of(context).primaryColor,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).gymMode,
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        // Delete day
        if (direction == DismissDirection.startToEnd) {
          Navigator.of(context).pushNamed(GymModeScreen.routeName, arguments: _day);
        }
        return false;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _day.description,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(_day.getDaysTextTranslated(Localizations.localeOf(context).languageCode)),
                ],
              ),
            ),
            IconButton(
              icon: _expanded ? const Icon(Icons.unfold_less) : const Icon(Icons.unfold_more),
              onPressed: () {
                _toggle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
