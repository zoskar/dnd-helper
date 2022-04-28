// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spells _$SpellsFromJson(Map<String, dynamic> json) => Spells(
      index: json['index'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$SpellsToJson(Spells instance) => <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'url': instance.url,
    };

Spell _$SpellFromJson(Map<String, dynamic> json) => Spell(
      id: json['_id'] as String,
      desc: (json['desc'] as List<dynamic>).map((e) => e as String).toList(),
      higher_level: json['higher_level'] as List<dynamic>,
      range: json['range'] as String,
      components: json['components'] as List<dynamic>,
      ritual: json['ritual'] as bool,
      duration: json['duration'] as String,
      concentration: json['concentration'] as bool,
      casting_time: json['casting_time'] as String,
      level: json['level'] as int,
      school: json['school'] as Map<String, dynamic>,
      classes: json['classes'] as List<dynamic>,
      subclasses: json['subclasses'] as List<dynamic>,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SpellToJson(Spell instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'higher_level': instance.higher_level,
      'range': instance.range,
      'components': instance.components,
      'ritual': instance.ritual,
      'duration': instance.duration,
      'concentration': instance.concentration,
      'casting_time': instance.casting_time,
      'level': instance.level,
      'school': instance.school,
      'classes': instance.classes,
      'subclasses': instance.subclasses,
    };
