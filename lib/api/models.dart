import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Spells {
  final String index;
  final String name;
  final String url;

  const Spells({
    required this.index,
    required this.name,
    required this.url,
  });
  factory Spells.fromJson(Map<String, dynamic> json) => _$SpellsFromJson(json);

  Map<String, dynamic> toJson() => _$SpellsToJson(this);
}

@JsonSerializable()
class Spell {
  @JsonKey(name: '_id')
  final String id;
  // final String index;
  final String name;
  final List<String> desc;
  final List higher_level;
  final String range;
  final List components;
  final bool ritual;
  final String duration;
  final bool concentration;
  final String casting_time;
  final int level;
  final Map school;
  final List classes;
  final List subclasses;

  String get description => desc.first;

  const Spell({
    required this.id,
    required this.desc,
    required this.higher_level,
    required this.range,
    required this.components,
    required this.ritual,
    required this.duration,
    required this.concentration,
    required this.casting_time,
    required this.level,
    required this.school,
    required this.classes,
    required this.subclasses,
    required this.name,
  });

  factory Spell.fromJson(Map<String, dynamic> json) => _$SpellFromJson(json);

  Map<String, dynamic> toJson() => _$SpellToJson(this);
}

@JsonSerializable()
class RuleSection {
  final String name;
  final String desc;
  final List<Map<String, String>> subsections;

  const RuleSection({
    required this.name,
    required this.desc,
    required this.subsections,
  });
  factory RuleSection.fromJson(Map<String, dynamic> json) =>
      _$RuleSectionFromJson(json);

  Map<String, dynamic> toJson() => _$RuleSectionToJson(this);
}
