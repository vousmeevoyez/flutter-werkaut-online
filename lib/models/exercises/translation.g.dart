// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translation _$TranslationFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'uuid',
      'language',
      'created',
      'exercise_base',
      'name',
      'description'
    ],
  );
  return Translation(
    id: json['id'] as int?,
    uuid: json['uuid'] as String?,
    created: json['created'] == null ? null : DateTime.parse(json['created'] as String),
    name: json['name'] as String,
    description: json['description'] as String,
    baseId: json['exercise_base'] as int?,
  )..languageId = json['language'] as int;
}

Map<String, dynamic> _$TranslationToJson(Translation instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'language': instance.languageId,
      'created': instance.created?.toIso8601String(),
      'exercise_base': instance.baseId,
      'name': instance.name,
      'description': instance.description,
    };
