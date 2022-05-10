import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Character extends Equatable {
  const Character({
    required this.name,
    required this.characterClass,
    required this.race,
    required this.level,
    required this.subclass,
    required this.stats,
    required this.savingThrows,
    required this.skills,
    required this.resources,
    required this.hp,
    required this.ac,
  });

  Character.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        characterClass = map['character_class'],
        race = map['race'],
        level = (map['level'] as num).toInt(),
        subclass = map['subclass'],
        stats = map['stats'],
        savingThrows = map['saving_throws'],
        skills = map['skills'],
        resources = [],
        hp = (map['hp'] as num).toInt(),
        ac = (map['ac'] as num).toInt();
  final String name;
  final String characterClass;
  final String race;
  final int level;
  final String subclass;
  final dynamic stats;
  final List savingThrows;
  final List skills;
  final List resources;
  final int hp;
  final int ac;

  Map<String, dynamic> toJson() => {
      'name': name,
      'character_class': characterClass,
      'race': race,
      'level': level,
      'subclass': subclass,
      'stats': stats,
      'saving_throws': savingThrows,
      'skills': skills,
      'resources': resources,
      'hp': hp,
      'ac': ac,
    };

  @override
  List<Object?> get props => [
        name,
        characterClass,
        race,
        level,
        subclass,
        stats,
        savingThrows,
        skills,
        resources,
        hp,
        ac,
      ];
}
