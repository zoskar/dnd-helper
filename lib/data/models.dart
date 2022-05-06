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
    required this.temporaryHp,
  });
  final String name;
  final String characterClass;
  final String race;
  final int level;
  final String subclass;
  final dynamic stats;
  final dynamic savingThrows;
  final dynamic skills;
  final List resources;
  final int hp;
  final int temporaryHp;

  Character.fromJson(Map<String, dynamic> map)
      : name = map['name'] as String,
        characterClass = map['character_class'] as String,
        race = map['race'] as String,
        level = (map['level'] as num).toInt(),
        subclass = map['subclass'] as String,
        stats = map['stats'],
        savingThrows = map['saving_throws'],
        skills = map['skills'],
        resources = [],
        hp = (map['hp'] as num).toInt(),
        temporaryHp = (map['temporary_hp'] as num).toInt();

  Map<String, dynamic> toJson() {
    return {
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
      'temporary_hp': temporaryHp,
    };
  }

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
        temporaryHp
      ];
}
