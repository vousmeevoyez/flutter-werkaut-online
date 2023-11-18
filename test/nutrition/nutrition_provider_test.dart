import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:werkaut/models/nutrition/ingredient.dart';
import 'package:werkaut/providers/nutrition.dart';

import '../fixtures/fixture_reader.dart';
import '../measurements/measurement_provider_test.mocks.dart';

void main() {
  late NutritionPlansProvider nutritionProvider;
  late MockwerkautBaseProvider mockwerkautBaseProvider;

  setUp(() {
    mockwerkautBaseProvider = MockwerkautBaseProvider();
    nutritionProvider = NutritionPlansProvider(mockwerkautBaseProvider, []);

    const String planInfoUrl = 'nutritionplaninfo';
    const String planUrl = 'nutritionplan';
    const String diaryUrl = 'nutritiondiary';
    const String ingredientUrl = 'ingredient';

    final Map<String, dynamic> nutritionalPlanInfoResponse = jsonDecode(
      fixture('nutrition/nutritional_plan_info_detail_response.json'),
    );
    final Map<String, dynamic> nutritionalPlanDetailResponse = jsonDecode(
      fixture('nutrition/nutritional_plan_detail_response.json'),
    );
    final List<dynamic> nutritionDiaryResponse = jsonDecode(
      fixture('nutrition/nutrition_diary_response.json'),
    )['results'];
    final Map<String, dynamic> ingredient59887Response = jsonDecode(
      fixture('nutrition/ingredient_59887_response.json'),
    );
    final Map<String, dynamic> ingredient10065Response = jsonDecode(
      fixture('nutrition/ingredient_10065_response.json'),
    );
    final Map<String, dynamic> ingredient58300Response = jsonDecode(
      fixture('nutrition/ingredient_58300_response.json'),
    );

    final ingredientList = [
      Ingredient.fromJson(ingredient59887Response),
      Ingredient.fromJson(ingredient10065Response),
      Ingredient.fromJson(ingredient58300Response),
    ];

    nutritionProvider.ingredients = ingredientList;

    final Uri planInfoUri = Uri(
      scheme: 'http',
      host: 'localhost',
      path: 'api/v2/$planInfoUrl/1',
    );
    final Uri planUri = Uri(
      scheme: 'http',
      host: 'localhost',
      path: 'api/v2/$planUrl',
    );
    final Uri diaryUri = Uri(
      scheme: 'http',
      host: 'localhost',
      path: 'api/v2/$diaryUrl',
    );
    when(mockwerkautBaseProvider.makeUrl(planInfoUrl, id: anyNamed('id'))).thenReturn(planInfoUri);
    when(mockwerkautBaseProvider.makeUrl(planUrl, id: anyNamed('id'))).thenReturn(planUri);
    when(mockwerkautBaseProvider.makeUrl(diaryUrl, query: anyNamed('query'))).thenReturn(diaryUri);
    when(mockwerkautBaseProvider.fetch(planInfoUri)).thenAnswer(
      (realInvocation) => Future.value(nutritionalPlanInfoResponse),
    );
    when(mockwerkautBaseProvider.fetch(planUri)).thenAnswer(
      (realInvocation) => Future.value(nutritionalPlanDetailResponse),
    );
    when(mockwerkautBaseProvider.fetchPaginated(diaryUri)).thenAnswer(
      (realInvocation) => Future.value(nutritionDiaryResponse),
    );
  });

  group('fetchAndSetPlanFull', () {
    test('should correctly load a full nutritional plan', () async {
      // arrange
      await nutritionProvider.fetchAndSetPlanFull(1);

      // assert
      expect(nutritionProvider.items.isEmpty, false);
    });
  });
}
