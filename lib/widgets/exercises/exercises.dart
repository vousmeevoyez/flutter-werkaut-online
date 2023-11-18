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
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/helpers/consts.dart';
import 'package:werkaut/helpers/i18n.dart';
import 'package:werkaut/helpers/platform.dart';
import 'package:werkaut/models/exercises/base.dart';
import 'package:werkaut/models/exercises/muscle.dart';
import 'package:werkaut/models/exercises/translation.dart';
import 'package:werkaut/providers/exercises.dart';
import 'package:werkaut/widgets/core/core.dart';
import 'package:werkaut/widgets/exercises/images.dart';
import 'package:werkaut/widgets/exercises/list_tile.dart';
import 'package:werkaut/widgets/exercises/videos.dart';

class ExerciseDetail extends StatelessWidget {
  final ExerciseBase _exerciseBase;
  late Translation _exercise;
  static const PADDING = 9.0;

  ExerciseDetail(this._exerciseBase);

  @override
  Widget build(BuildContext context) {
    _exercise = _exerciseBase.getExercise(Localizations.localeOf(context).languageCode);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category and equipment
          getCategoriesAndEquipment(context),

          // Alternative names
          ...getAliases(context),

          // Videos
          ...getVideos(),

          // Images
          ...getImages(),

          // Description
          ...getDescription(context),

          // Notes
          ...getNotes(context),

          // Muscles
          ...getMuscles(context),

          // Variants
          ...getVariations(context)
        ],
      ),
    );
  }

  List<Widget> getVariations(BuildContext context) {
    final List<Widget> out = [];
    if (_exerciseBase.variationId == null) {
      return out;
    }

    out.add(Text(
      AppLocalizations.of(context).variations,
      style: Theme.of(context).textTheme.headline5,
    ));
    Provider.of<ExercisesProvider>(context, listen: false)
        .findExerciseBasesByVariationId(
      _exerciseBase.variationId!,
      exerciseBaseIdToExclude: _exerciseBase.id,
    )
        .forEach((element) {
      out.add(ExerciseListTile(
        exerciseBase: element,
      ));
    });

    out.add(const SizedBox(height: PADDING));
    return out;
  }

  List<Widget> getNotes(BuildContext context) {
    final List<Widget> out = [];
    if (_exercise.notes.isNotEmpty) {
      out.add(Text(
        AppLocalizations.of(context).notes,
        style: Theme.of(context).textTheme.headline5,
      ));
      for (final e in _exercise.notes) {
        out.add(Text(e.comment));
      }
      out.add(const SizedBox(height: PADDING));
    }

    return out;
  }

  List<Widget> getMuscles(BuildContext context) {
    final List<Widget> out = [];
    out.add(Text(
      AppLocalizations.of(context).muscles,
      style: Theme.of(context).textTheme.headline5,
    ));
    out.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: PADDING),
            child: MuscleWidget(
              muscles: _exerciseBase.muscles,
              musclesSecondary: _exerciseBase.musclesSecondary,
              isFront: true,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: PADDING),
            child: MuscleWidget(
              muscles: _exerciseBase.muscles,
              musclesSecondary: _exerciseBase.musclesSecondary,
              isFront: false,
            ),
          ),
        ),
      ],
    ));

    out.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MuscleColorHelper(main: true),
          ..._exerciseBase.muscles.map((e) => Text(e.nameTranslated(context))).toList(),
        ],
      ),
    );
    out.add(const SizedBox(height: PADDING));
    out.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MuscleColorHelper(main: false),
          ..._exerciseBase.musclesSecondary.map((e) => Text(e.name)).toList(),
        ],
      ),
    );

    out.add(const SizedBox(height: PADDING));

    return out;
  }

  List<Widget> getDescription(BuildContext context) {
    final List<Widget> out = [];
    out.add(Text(
      AppLocalizations.of(context).description,
      style: Theme.of(context).textTheme.headline5,
    ));
    out.add(Html(data: _exercise.description));

    return out;
  }

  List<Widget> getImages() {
    // TODO: add carousel for the other images
    final List<Widget> out = [];
    if (_exerciseBase.getMainImage != null) {
      out.add(ExerciseImageWidget(image: _exerciseBase.getMainImage));
      out.add(const SizedBox(height: PADDING));
    }

    return out;
  }

  Widget getCategoriesAndEquipment(BuildContext context) {
    final List<Widget> out = [];

    out.add(
      Chip(label: Text(getTranslation(_exerciseBase.category.name, context))),
    );
    if (_exerciseBase.equipment.isNotEmpty) {
      _exerciseBase.equipment
          .map((e) => Chip(label: Text(getTranslation(e.name, context))))
          .forEach((element) {
        out.add(element);
      });
    }
    out.add(const SizedBox(height: PADDING));
    return Row(children: [...out]);
  }

  List<Widget> getVideos() {
    // TODO: add carousel for the other videos
    final List<Widget> out = [];
    if (_exerciseBase.videos.isNotEmpty && !isDesktop) {
      _exerciseBase.videos.map((v) => ExerciseVideoWidget(video: v)).forEach((element) {
        out.add(element);
      });

      out.add(const SizedBox(height: PADDING));
    }
    return out;
  }

  List<Widget> getAliases(BuildContext context) {
    final List<Widget> out = [];
    if (_exercise.alias.isNotEmpty) {
      out.add(MutedText(
        AppLocalizations.of(context)
            .alsoKnownAs(_exercise.alias.map((e) => e.alias).toList().join(', ')),
      ));
      out.add(const SizedBox(height: PADDING));
    }

    return out;
  }
}

class MuscleColorHelper extends StatelessWidget {
  final bool main;

  const MuscleColorHelper({
    this.main = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          color: main ? COLOR_MAIN_MUSCLES : COLOR_SECONDARY_MUSCLES,
        ),
        const SizedBox(width: 2),
        Text(
          main
              ? AppLocalizations.of(context).muscles
              : AppLocalizations.of(context).musclesSecondary,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class MuscleRowWidget extends StatelessWidget {
  final List<Muscle> muscles;
  final List<Muscle> musclesSecondary;

  const MuscleRowWidget({required this.muscles, required this.musclesSecondary});

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: MuscleWidget(
              muscles: muscles,
              musclesSecondary: musclesSecondary,
              isFront: true,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: MuscleWidget(
              muscles: muscles,
              musclesSecondary: musclesSecondary,
              isFront: false,
            ),
          ),
        ),
      ],
    );
  }
}

class MuscleWidget extends StatelessWidget {
  late final List<Muscle> muscles;
  late final List<Muscle> musclesSecondary;
  final bool isFront;

  MuscleWidget({
    List<Muscle> muscles = const [],
    List<Muscle> musclesSecondary = const [],
    this.isFront = true,
  }) {
    this.muscles = muscles.where((m) => m.isFront == isFront).toList();
    this.musclesSecondary = musclesSecondary.where((m) => m.isFront == isFront).toList();
  }

  @override
  Widget build(BuildContext context) {
    final background = isFront ? 'front' : 'back';

    return Stack(
      children: [
        SvgPicture.asset('assets/images/muscles/$background.svg'),
        ...muscles
            .map((m) => SvgPicture.asset('assets/images/muscles/main/muscle-${m.id}.svg'))
            .toList(),
        ...musclesSecondary
            .map((m) => SvgPicture.asset('assets/images/muscles/secondary/muscle-${m.id}.svg'))
            .toList(),
      ],
    );
  }
}
