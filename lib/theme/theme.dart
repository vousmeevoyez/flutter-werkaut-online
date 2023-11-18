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
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

const Color werkautPrimaryColor = Color(0xff2a4c7d);
const Color werkautPrimaryButtonColor = Color(0xff266dd3);
const Color werkautPrimaryColorLight = Color(0xff94B2DB);
const Color werkautSecondaryColor = Color(0xffe63946);
const Color werkautSecondaryColorLight = Color(0xffF6B4BA);
const Color werkautTextMuted = Colors.black38;
const Color werkautBackground = Color(0xfff4f4f6);

// Chart colors

/// Original sizes for the material text theme
/// https://api.flutter.dev/flutter/material/TextTheme-class.html
const materialSizes = {
  'h1': 96.0,
  'h2': 60.0,
  'h3': 48.0,
  'h4': 34.0,
  'h5': 24.0,
  'h6': 20.0,
};

final ThemeData werkautTheme = ThemeData(
  /*
    * General stuff
    */
  primaryColor: werkautPrimaryColor,
  scaffoldBackgroundColor: werkautBackground,

  // This makes the visual density adapt to the platform that you run
  // the app on. For desktop platforms, the controls will be smaller and
  // closer together (more dense) than on mobile platforms.
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // Show icons in the system's bar in light colors
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    color: werkautPrimaryColor,
  ),

  /*
     * Text theme
     */
  textTheme: TextTheme(
    headline1: const TextStyle(fontFamily: 'OpenSansLight', color: Colors.black),
    headline2: const TextStyle(fontFamily: 'OpenSansLight', color: Colors.black),
    headline3: TextStyle(
      fontSize: materialSizes['h3']! * 0.8,
      fontFamily: 'OpenSansBold',
      color: Colors.black,
    ),
    headline4: TextStyle(
      fontSize: materialSizes['h4']! * 0.8,
      fontFamily: 'OpenSansBold',
      color: Colors.black,
    ),
    headline5: TextStyle(
      fontSize: materialSizes['h5'],
      fontFamily: 'OpenSansBold',
      color: Colors.black,
    ),
    headline6: TextStyle(
      fontSize: materialSizes['h6']! * 0.8,
      fontFamily: 'OpenSansBold',
      color: Colors.black,
    ),
  ),

  /*
     * Button theme
     */
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
//       This primary is deprecated and should not be used
//       primary: werkautPrimaryButtonColor,
      foregroundColor: werkautPrimaryButtonColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: werkautPrimaryButtonColor,
      visualDensity: VisualDensity.compact,
      side: const BorderSide(color: werkautPrimaryButtonColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: werkautPrimaryButtonColor,
    ),
  ),

  /*
    * Forms, etc.
    */
  sliderTheme: const SliderThemeData(
    activeTrackColor: werkautPrimaryButtonColor,
    thumbColor: werkautPrimaryColor,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: werkautSecondaryColor),
  // Text Selection Theme
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: werkautPrimaryColor,
    selectionColor: werkautPrimaryColor.withOpacity(0.2),
    selectionHandleColor: werkautPrimaryColor,
  ),
  // Text Fields Theme
  inputDecorationTheme: InputDecorationTheme(
    focusColor: werkautPrimaryColor,
    iconColor: Colors.grey.shade600,
    floatingLabelStyle: const TextStyle(color: werkautPrimaryColor),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: werkautPrimaryColor),
    ),
  ),
);

const werkautCalendarStyle = CalendarStyle(
// Use `CalendarStyle` to customize the UI
  outsideDaysVisible: false,
  todayDecoration: BoxDecoration(
    color: Colors.amber,
    shape: BoxShape.circle,
  ),

  markerDecoration: BoxDecoration(
    color: Colors.black,
    shape: BoxShape.circle,
  ),
  selectedDecoration: BoxDecoration(
    color: werkautSecondaryColor,
    shape: BoxShape.circle,
  ),
  rangeStartDecoration: BoxDecoration(
    color: werkautSecondaryColor,
    shape: BoxShape.circle,
  ),
  rangeEndDecoration: BoxDecoration(
    color: werkautSecondaryColor,
    shape: BoxShape.circle,
  ),
  rangeHighlightColor: werkautSecondaryColorLight,
  weekendTextStyle: TextStyle(color: werkautSecondaryColor),
);
