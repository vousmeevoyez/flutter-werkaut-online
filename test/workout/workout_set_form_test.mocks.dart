// Mocks generated by Mockito 5.4.2 from annotations
// in werkaut/test/workout/workout_set_form_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i19;
import 'dart:ui' as _i20;

import 'package:http/http.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:werkaut/models/exercises/base.dart' as _i3;
import 'package:werkaut/models/exercises/category.dart' as _i4;
import 'package:werkaut/models/exercises/equipment.dart' as _i5;
import 'package:werkaut/models/exercises/language.dart' as _i7;
import 'package:werkaut/models/exercises/muscle.dart' as _i6;
import 'package:werkaut/models/exercises/translation.dart' as _i22;
import 'package:werkaut/models/workouts/day.dart' as _i13;
import 'package:werkaut/models/workouts/log.dart' as _i17;
import 'package:werkaut/models/workouts/repetition_unit.dart' as _i11;
import 'package:werkaut/models/workouts/session.dart' as _i16;
import 'package:werkaut/models/workouts/set.dart' as _i14;
import 'package:werkaut/models/workouts/setting.dart' as _i15;
import 'package:werkaut/models/workouts/weight_unit.dart' as _i10;
import 'package:werkaut/models/workouts/workout_plan.dart' as _i12;
import 'package:werkaut/providers/auth.dart' as _i8;
import 'package:werkaut/providers/base_provider.dart' as _i2;
import 'package:werkaut/providers/exercises.dart' as _i18;
import 'package:werkaut/providers/workout_plans.dart' as _i21;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakewerkautBaseProvider_0 extends _i1.SmartFake implements _i2.werkautBaseProvider {
  _FakewerkautBaseProvider_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExerciseBase_1 extends _i1.SmartFake implements _i3.ExerciseBase {
  _FakeExerciseBase_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExerciseCategory_2 extends _i1.SmartFake implements _i4.ExerciseCategory {
  _FakeExerciseCategory_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEquipment_3 extends _i1.SmartFake implements _i5.Equipment {
  _FakeEquipment_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMuscle_4 extends _i1.SmartFake implements _i6.Muscle {
  _FakeMuscle_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLanguage_5 extends _i1.SmartFake implements _i7.Language {
  _FakeLanguage_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAuthProvider_6 extends _i1.SmartFake implements _i8.AuthProvider {
  _FakeAuthProvider_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClient_7 extends _i1.SmartFake implements _i9.Client {
  _FakeClient_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUri_8 extends _i1.SmartFake implements Uri {
  _FakeUri_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_9 extends _i1.SmartFake implements _i9.Response {
  _FakeResponse_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeightUnit_10 extends _i1.SmartFake implements _i10.WeightUnit {
  _FakeWeightUnit_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRepetitionUnit_11 extends _i1.SmartFake implements _i11.RepetitionUnit {
  _FakeRepetitionUnit_11(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWorkoutPlan_12 extends _i1.SmartFake implements _i12.WorkoutPlan {
  _FakeWorkoutPlan_12(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDay_13 extends _i1.SmartFake implements _i13.Day {
  _FakeDay_13(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSet_14 extends _i1.SmartFake implements _i14.Set {
  _FakeSet_14(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSetting_15 extends _i1.SmartFake implements _i15.Setting {
  _FakeSetting_15(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWorkoutSession_16 extends _i1.SmartFake implements _i16.WorkoutSession {
  _FakeWorkoutSession_16(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLog_17 extends _i1.SmartFake implements _i17.Log {
  _FakeLog_17(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ExercisesProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockExercisesProvider extends _i1.Mock implements _i18.ExercisesProvider {
  MockExercisesProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.werkautBaseProvider get baseProvider => (super.noSuchMethod(
        Invocation.getter(#baseProvider),
        returnValue: _FakewerkautBaseProvider_0(
          this,
          Invocation.getter(#baseProvider),
        ),
      ) as _i2.werkautBaseProvider);

  @override
  set exerciseBases(List<_i3.ExerciseBase>? exercisesBases) => super.noSuchMethod(
        Invocation.setter(
          #exerciseBases,
          exercisesBases,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i3.ExerciseBase> get filteredExerciseBases => (super.noSuchMethod(
        Invocation.getter(#filteredExerciseBases),
        returnValue: <_i3.ExerciseBase>[],
      ) as List<_i3.ExerciseBase>);

  @override
  set filteredExerciseBases(List<_i3.ExerciseBase>? newFilteredExercises) => super.noSuchMethod(
        Invocation.setter(
          #filteredExerciseBases,
          newFilteredExercises,
        ),
        returnValueForMissingStub: null,
      );

  @override
  Map<int, List<_i3.ExerciseBase>> get exerciseBasesByVariation => (super.noSuchMethod(
        Invocation.getter(#exerciseBasesByVariation),
        returnValue: <int, List<_i3.ExerciseBase>>{},
      ) as Map<int, List<_i3.ExerciseBase>>);

  @override
  List<_i3.ExerciseBase> get bases => (super.noSuchMethod(
        Invocation.getter(#bases),
        returnValue: <_i3.ExerciseBase>[],
      ) as List<_i3.ExerciseBase>);

  @override
  List<_i4.ExerciseCategory> get categories => (super.noSuchMethod(
        Invocation.getter(#categories),
        returnValue: <_i4.ExerciseCategory>[],
      ) as List<_i4.ExerciseCategory>);

  @override
  List<_i6.Muscle> get muscles => (super.noSuchMethod(
        Invocation.getter(#muscles),
        returnValue: <_i6.Muscle>[],
      ) as List<_i6.Muscle>);

  @override
  List<_i5.Equipment> get equipment => (super.noSuchMethod(
        Invocation.getter(#equipment),
        returnValue: <_i5.Equipment>[],
      ) as List<_i5.Equipment>);

  @override
  List<_i7.Language> get languages => (super.noSuchMethod(
        Invocation.getter(#languages),
        returnValue: <_i7.Language>[],
      ) as List<_i7.Language>);

  @override
  set languages(List<_i7.Language>? languages) => super.noSuchMethod(
        Invocation.setter(
          #languages,
          languages,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i19.Future<void> setFilters(_i18.Filters? newFilters) => (super.noSuchMethod(
        Invocation.method(
          #setFilters,
          [newFilters],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> findByFilters() => (super.noSuchMethod(
        Invocation.method(
          #findByFilters,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.ExerciseBase findExerciseBaseById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findExerciseBaseById,
          [id],
        ),
        returnValue: _FakeExerciseBase_1(
          this,
          Invocation.method(
            #findExerciseBaseById,
            [id],
          ),
        ),
      ) as _i3.ExerciseBase);

  @override
  List<_i3.ExerciseBase> findExerciseBasesByVariationId(
    int? id, {
    int? exerciseBaseIdToExclude,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #findExerciseBasesByVariationId,
          [id],
          {#exerciseBaseIdToExclude: exerciseBaseIdToExclude},
        ),
        returnValue: <_i3.ExerciseBase>[],
      ) as List<_i3.ExerciseBase>);

  @override
  _i4.ExerciseCategory findCategoryById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findCategoryById,
          [id],
        ),
        returnValue: _FakeExerciseCategory_2(
          this,
          Invocation.method(
            #findCategoryById,
            [id],
          ),
        ),
      ) as _i4.ExerciseCategory);

  @override
  _i5.Equipment findEquipmentById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findEquipmentById,
          [id],
        ),
        returnValue: _FakeEquipment_3(
          this,
          Invocation.method(
            #findEquipmentById,
            [id],
          ),
        ),
      ) as _i5.Equipment);

  @override
  _i6.Muscle findMuscleById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findMuscleById,
          [id],
        ),
        returnValue: _FakeMuscle_4(
          this,
          Invocation.method(
            #findMuscleById,
            [id],
          ),
        ),
      ) as _i6.Muscle);

  @override
  _i7.Language findLanguageById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findLanguageById,
          [id],
        ),
        returnValue: _FakeLanguage_5(
          this,
          Invocation.method(
            #findLanguageById,
            [id],
          ),
        ),
      ) as _i7.Language);

  @override
  _i19.Future<void> fetchAndSetCategories() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetCategories,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> fetchAndSetVariations() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetVariations,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> fetchAndSetMuscles() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetMuscles,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> fetchAndSetEquipment() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetEquipment,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> fetchAndSetLanguages() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetLanguages,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<_i3.ExerciseBase> fetchAndSetExerciseBase(int? exerciseBaseId) => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetExerciseBase,
          [exerciseBaseId],
        ),
        returnValue: _i19.Future<_i3.ExerciseBase>.value(_FakeExerciseBase_1(
          this,
          Invocation.method(
            #fetchAndSetExerciseBase,
            [exerciseBaseId],
          ),
        )),
      ) as _i19.Future<_i3.ExerciseBase>);

  @override
  _i3.ExerciseBase readExerciseBaseFromBaseInfo(dynamic baseData) => (super.noSuchMethod(
        Invocation.method(
          #readExerciseBaseFromBaseInfo,
          [baseData],
        ),
        returnValue: _FakeExerciseBase_1(
          this,
          Invocation.method(
            #readExerciseBaseFromBaseInfo,
            [baseData],
          ),
        ),
      ) as _i3.ExerciseBase);

  @override
  _i19.Future<void> checkExerciseCacheVersion() => (super.noSuchMethod(
        Invocation.method(
          #checkExerciseCacheVersion,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> fetchAndSetExercises() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetExercises,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<List<_i3.ExerciseBase>> searchExercise(
    String? name, {
    String? languageCode = r'en',
    bool? searchEnglish = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchExercise,
          [name],
          {
            #languageCode: languageCode,
            #searchEnglish: searchEnglish,
          },
        ),
        returnValue: _i19.Future<List<_i3.ExerciseBase>>.value(<_i3.ExerciseBase>[]),
      ) as _i19.Future<List<_i3.ExerciseBase>>);

  @override
  void addListener(_i20.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i20.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [werkautBaseProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockwerkautBaseProvider extends _i1.Mock implements _i2.werkautBaseProvider {
  MockwerkautBaseProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.AuthProvider get auth => (super.noSuchMethod(
        Invocation.getter(#auth),
        returnValue: _FakeAuthProvider_6(
          this,
          Invocation.getter(#auth),
        ),
      ) as _i8.AuthProvider);

  @override
  set auth(_i8.AuthProvider? _auth) => super.noSuchMethod(
        Invocation.setter(
          #auth,
          _auth,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_7(
          this,
          Invocation.getter(#client),
        ),
      ) as _i9.Client);

  @override
  set client(_i9.Client? _client) => super.noSuchMethod(
        Invocation.setter(
          #client,
          _client,
        ),
        returnValueForMissingStub: null,
      );

  @override
  Map<String, String> getDefaultHeaders({dynamic includeAuth = false}) => (super.noSuchMethod(
        Invocation.method(
          #getDefaultHeaders,
          [],
          {#includeAuth: includeAuth},
        ),
        returnValue: <String, String>{},
      ) as Map<String, String>);

  @override
  Uri makeUrl(
    String? path, {
    int? id,
    String? objectMethod,
    Map<String, dynamic>? query,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #makeUrl,
          [path],
          {
            #id: id,
            #objectMethod: objectMethod,
            #query: query,
          },
        ),
        returnValue: _FakeUri_8(
          this,
          Invocation.method(
            #makeUrl,
            [path],
            {
              #id: id,
              #objectMethod: objectMethod,
              #query: query,
            },
          ),
        ),
      ) as Uri);

  @override
  _i19.Future<Map<String, dynamic>> fetch(Uri? uri) => (super.noSuchMethod(
        Invocation.method(
          #fetch,
          [uri],
        ),
        returnValue: _i19.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i19.Future<Map<String, dynamic>>);

  @override
  _i19.Future<List<dynamic>> fetchPaginated(Uri? uri) => (super.noSuchMethod(
        Invocation.method(
          #fetchPaginated,
          [uri],
        ),
        returnValue: _i19.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i19.Future<List<dynamic>>);

  @override
  _i19.Future<Map<String, dynamic>> post(
    Map<String, dynamic>? data,
    Uri? uri,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [
            data,
            uri,
          ],
        ),
        returnValue: _i19.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i19.Future<Map<String, dynamic>>);

  @override
  _i19.Future<Map<String, dynamic>> patch(
    Map<String, dynamic>? data,
    Uri? uri,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [
            data,
            uri,
          ],
        ),
        returnValue: _i19.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i19.Future<Map<String, dynamic>>);

  @override
  _i19.Future<_i9.Response> deleteRequest(
    String? url,
    int? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteRequest,
          [
            url,
            id,
          ],
        ),
        returnValue: _i19.Future<_i9.Response>.value(_FakeResponse_9(
          this,
          Invocation.method(
            #deleteRequest,
            [
              url,
              id,
            ],
          ),
        )),
      ) as _i19.Future<_i9.Response>);
}

/// A class which mocks [WorkoutPlansProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockWorkoutPlansProvider extends _i1.Mock implements _i21.WorkoutPlansProvider {
  MockWorkoutPlansProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.werkautBaseProvider get baseProvider => (super.noSuchMethod(
        Invocation.getter(#baseProvider),
        returnValue: _FakewerkautBaseProvider_0(
          this,
          Invocation.getter(#baseProvider),
        ),
      ) as _i2.werkautBaseProvider);

  @override
  List<_i12.WorkoutPlan> get items => (super.noSuchMethod(
        Invocation.getter(#items),
        returnValue: <_i12.WorkoutPlan>[],
      ) as List<_i12.WorkoutPlan>);

  @override
  List<_i10.WeightUnit> get weightUnits => (super.noSuchMethod(
        Invocation.getter(#weightUnits),
        returnValue: <_i10.WeightUnit>[],
      ) as List<_i10.WeightUnit>);

  @override
  _i10.WeightUnit get defaultWeightUnit => (super.noSuchMethod(
        Invocation.getter(#defaultWeightUnit),
        returnValue: _FakeWeightUnit_10(
          this,
          Invocation.getter(#defaultWeightUnit),
        ),
      ) as _i10.WeightUnit);

  @override
  List<_i11.RepetitionUnit> get repetitionUnits => (super.noSuchMethod(
        Invocation.getter(#repetitionUnits),
        returnValue: <_i11.RepetitionUnit>[],
      ) as List<_i11.RepetitionUnit>);

  @override
  _i11.RepetitionUnit get defaultRepetitionUnit => (super.noSuchMethod(
        Invocation.getter(#defaultRepetitionUnit),
        returnValue: _FakeRepetitionUnit_11(
          this,
          Invocation.getter(#defaultRepetitionUnit),
        ),
      ) as _i11.RepetitionUnit);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i12.WorkoutPlan> getPlans() => (super.noSuchMethod(
        Invocation.method(
          #getPlans,
          [],
        ),
        returnValue: <_i12.WorkoutPlan>[],
      ) as List<_i12.WorkoutPlan>);

  @override
  _i12.WorkoutPlan findById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findById,
          [id],
        ),
        returnValue: _FakeWorkoutPlan_12(
          this,
          Invocation.method(
            #findById,
            [id],
          ),
        ),
      ) as _i12.WorkoutPlan);

  @override
  int findIndexById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findIndexById,
          [id],
        ),
        returnValue: 0,
      ) as int);

  @override
  void setCurrentPlan(int? id) => super.noSuchMethod(
        Invocation.method(
          #setCurrentPlan,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resetCurrentPlan() => super.noSuchMethod(
        Invocation.method(
          #resetCurrentPlan,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i19.Future<void> fetchAndSetAllPlansFull() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetAllPlansFull,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> fetchAndSetAllPlansSparse() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetAllPlansSparse,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<_i12.WorkoutPlan> fetchAndSetPlanSparse(int? planId) => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetPlanSparse,
          [planId],
        ),
        returnValue: _i19.Future<_i12.WorkoutPlan>.value(_FakeWorkoutPlan_12(
          this,
          Invocation.method(
            #fetchAndSetPlanSparse,
            [planId],
          ),
        )),
      ) as _i19.Future<_i12.WorkoutPlan>);

  @override
  _i19.Future<_i12.WorkoutPlan> fetchAndSetWorkoutPlanFull(int? workoutId) => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetWorkoutPlanFull,
          [workoutId],
        ),
        returnValue: _i19.Future<_i12.WorkoutPlan>.value(_FakeWorkoutPlan_12(
          this,
          Invocation.method(
            #fetchAndSetWorkoutPlanFull,
            [workoutId],
          ),
        )),
      ) as _i19.Future<_i12.WorkoutPlan>);

  @override
  _i19.Future<_i12.WorkoutPlan> addWorkout(_i12.WorkoutPlan? workout) => (super.noSuchMethod(
        Invocation.method(
          #addWorkout,
          [workout],
        ),
        returnValue: _i19.Future<_i12.WorkoutPlan>.value(_FakeWorkoutPlan_12(
          this,
          Invocation.method(
            #addWorkout,
            [workout],
          ),
        )),
      ) as _i19.Future<_i12.WorkoutPlan>);

  @override
  _i19.Future<void> editWorkout(_i12.WorkoutPlan? workout) => (super.noSuchMethod(
        Invocation.method(
          #editWorkout,
          [workout],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> deleteWorkout(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteWorkout,
          [id],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<Map<String, dynamic>> fetchLogData(
    _i12.WorkoutPlan? workout,
    _i3.ExerciseBase? base,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchLogData,
          [
            workout,
            base,
          ],
        ),
        returnValue: _i19.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i19.Future<Map<String, dynamic>>);

  @override
  _i19.Future<void> fetchAndSetRepetitionUnits() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetRepetitionUnits,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> fetchAndSetWeightUnits() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetWeightUnits,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> fetchAndSetUnits() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetUnits,
          [],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<_i13.Day> addDay(
    _i13.Day? day,
    _i12.WorkoutPlan? workout,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addDay,
          [
            day,
            workout,
          ],
        ),
        returnValue: _i19.Future<_i13.Day>.value(_FakeDay_13(
          this,
          Invocation.method(
            #addDay,
            [
              day,
              workout,
            ],
          ),
        )),
      ) as _i19.Future<_i13.Day>);

  @override
  _i19.Future<void> editDay(_i13.Day? day) => (super.noSuchMethod(
        Invocation.method(
          #editDay,
          [day],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<void> deleteDay(_i13.Day? day) => (super.noSuchMethod(
        Invocation.method(
          #deleteDay,
          [day],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<_i14.Set> addSet(_i14.Set? workoutSet) => (super.noSuchMethod(
        Invocation.method(
          #addSet,
          [workoutSet],
        ),
        returnValue: _i19.Future<_i14.Set>.value(_FakeSet_14(
          this,
          Invocation.method(
            #addSet,
            [workoutSet],
          ),
        )),
      ) as _i19.Future<_i14.Set>);

  @override
  _i19.Future<void> editSet(_i14.Set? workoutSet) => (super.noSuchMethod(
        Invocation.method(
          #editSet,
          [workoutSet],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<List<_i14.Set>> reorderSets(
    List<_i14.Set>? sets,
    int? startIndex,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #reorderSets,
          [
            sets,
            startIndex,
          ],
        ),
        returnValue: _i19.Future<List<_i14.Set>>.value(<_i14.Set>[]),
      ) as _i19.Future<List<_i14.Set>>);

  @override
  _i19.Future<void> fetchComputedSettings(_i14.Set? workoutSet) => (super.noSuchMethod(
        Invocation.method(
          #fetchComputedSettings,
          [workoutSet],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<String> fetchSmartText(
    _i14.Set? workoutSet,
    _i22.Translation? exercise,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSmartText,
          [
            workoutSet,
            exercise,
          ],
        ),
        returnValue: _i19.Future<String>.value(''),
      ) as _i19.Future<String>);

  @override
  _i19.Future<void> deleteSet(_i14.Set? workoutSet) => (super.noSuchMethod(
        Invocation.method(
          #deleteSet,
          [workoutSet],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  _i19.Future<_i15.Setting> addSetting(_i15.Setting? workoutSetting) => (super.noSuchMethod(
        Invocation.method(
          #addSetting,
          [workoutSetting],
        ),
        returnValue: _i19.Future<_i15.Setting>.value(_FakeSetting_15(
          this,
          Invocation.method(
            #addSetting,
            [workoutSetting],
          ),
        )),
      ) as _i19.Future<_i15.Setting>);

  @override
  _i19.Future<dynamic> fetchSessionData() => (super.noSuchMethod(
        Invocation.method(
          #fetchSessionData,
          [],
        ),
        returnValue: _i19.Future<dynamic>.value(),
      ) as _i19.Future<dynamic>);

  @override
  _i19.Future<_i16.WorkoutSession> addSession(_i16.WorkoutSession? session) => (super.noSuchMethod(
        Invocation.method(
          #addSession,
          [session],
        ),
        returnValue: _i19.Future<_i16.WorkoutSession>.value(_FakeWorkoutSession_16(
          this,
          Invocation.method(
            #addSession,
            [session],
          ),
        )),
      ) as _i19.Future<_i16.WorkoutSession>);

  @override
  _i19.Future<_i17.Log> addLog(_i17.Log? log) => (super.noSuchMethod(
        Invocation.method(
          #addLog,
          [log],
        ),
        returnValue: _i19.Future<_i17.Log>.value(_FakeLog_17(
          this,
          Invocation.method(
            #addLog,
            [log],
          ),
        )),
      ) as _i19.Future<_i17.Log>);

  @override
  _i19.Future<void> deleteLog(_i17.Log? log) => (super.noSuchMethod(
        Invocation.method(
          #deleteLog,
          [log],
        ),
        returnValue: _i19.Future<void>.value(),
        returnValueForMissingStub: _i19.Future<void>.value(),
      ) as _i19.Future<void>);

  @override
  void addListener(_i20.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i20.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
