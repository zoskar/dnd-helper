// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      name: json['name'] as String,
      characterClass: json['characterClass'] as String,
      race: json['race'] as String,
      level: (json['level'] as num).toInt(),
      subclass: json['subclass'] as String,
      stats: json['stats'],
      savingThrows: json['savingThrows'] as List<dynamic>,
      skills: json['skills'] as List<dynamic>,
      resources: (json['resources'] as List<dynamic>)
          .map((e) => Resource.fromJson(e as Map<String, dynamic>))
          .toList(),
      hp: (json['hp'] as num).toInt(),
      currentHp: (json['currentHp'] as num).toInt(),
      ac: (json['ac'] as num).toInt(),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'characterClass': instance.characterClass,
      'race': instance.race,
      'level': instance.level,
      'subclass': instance.subclass,
      'stats': instance.stats,
      'savingThrows': instance.savingThrows,
      'skills': instance.skills,
      'hp': instance.hp,
      'currentHp': instance.currentHp,
      'ac': instance.ac,
      'resources': instance.resources,
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      name: json['name'] as String,
      maxUses: (json['maxUses'] as num).toInt(),
      remainingUses: (json['remainingUses'] as num).toInt(),
      onShortRest: json['onShortRest'] as bool,
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'name': instance.name,
      'maxUses': instance.maxUses,
      'remainingUses': instance.remainingUses,
      'onShortRest': instance.onShortRest,
    };
