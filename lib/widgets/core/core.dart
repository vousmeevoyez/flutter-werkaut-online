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
import 'package:werkaut/theme/theme.dart';

class MutedText extends StatelessWidget {
  final String _text;
  final TextAlign textAlign;

  const MutedText(
    this._text, {
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: const TextStyle(color: werkautTextMuted),
      textAlign: textAlign,
    );
  }
}

class Pill extends StatelessWidget {
  const Pill({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight.withOpacity(0.15),
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
      ),
    );
  }
}

class CircleIconAvatar extends StatelessWidget {
  final double radius;
  final Icon _icon;

  final Color color;

  const CircleIconAvatar(this._icon, {this.radius = 20, this.color = Colors.black12});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: radius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: _icon,
      ),
    );
  }
}
