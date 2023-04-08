// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpellListItem _$SpellListItemFromJson(Map<String, dynamic> json) =>
    SpellListItem(
      index: json['index'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$SpellListItemToJson(SpellListItem instance) =>
    <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'url': instance.url,
    };

Spell _$SpellFromJson(Map<String, dynamic> json) => Spell(
      id: json['index'] as String,
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

RuleSection _$RuleSectionFromJson(Map<String, dynamic> json) => RuleSection(
      name: json['name'] as String,
      desc: json['desc'] as String,
      subsections: (json['subsections'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$RuleSectionToJson(RuleSection instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
      'subsections': instance.subsections,
    };

Rule _$RuleFromJson(Map<String, dynamic> json) => Rule(
      name: json['name'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$RuleToJson(Rule instance) => <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
    };
