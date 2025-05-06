import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class SpellListItem {
  const SpellListItem({
    required this.index,
    required this.name,
    required this.url,
  });
  factory SpellListItem.fromJson(Map<String, dynamic> json) =>
      _$SpellListItemFromJson(json);
  final String index;
  final String name;
  final String url;

  Map<String, dynamic> toJson() => _$SpellListItemToJson(this);
}

@JsonSerializable()
class Spell {
  const Spell({
    required this.id,
    required this.desc,
    required this.higherLevel,
    required this.range,
    required this.components,
    required this.ritual,
    required this.duration,
    required this.concentration,
    required this.castingTime,
    required this.level,
    required this.school,
    required this.classes,
    required this.subclasses,
    required this.name,
  });

  factory Spell.fromJson(Map<String, dynamic> json) => _$SpellFromJson(json);
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final List<String> desc;
  @JsonKey(name: 'higher_level')
  final List higherLevel;
  final String range;
  final List components;
  final bool ritual;
  final String duration;
  final bool concentration;
  @JsonKey(name: 'casting_time')
  final String castingTime;
  final int level;
  final Map school;
  final List classes;
  final List subclasses;

  Map<String, dynamic> toJson() => _$SpellToJson(this);
}

@JsonSerializable()
class RuleSection {
  const RuleSection({
    required this.name,
    required this.desc,
    required this.subsections,
  });
  factory RuleSection.fromJson(Map<String, dynamic> json) =>
      _$RuleSectionFromJson(json);
  final String name;
  final String desc;
  final List<Map<String, String>> subsections;

  Map<String, dynamic> toJson() => _$RuleSectionToJson(this);
}

@JsonSerializable()
class Rule {
  const Rule({required this.name, required this.desc});

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);

  final String name;
  final String desc;
  Map<String, dynamic> toJson() => _$RuleToJson(this);
}
