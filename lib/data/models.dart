import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Character extends Equatable {
  Character({
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
    required this.currentHp,
    required this.ac,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  final String name;
  final String characterClass;
  final String race;
  final int level;
  final String subclass;
  final dynamic stats;
  final List savingThrows;
  final List skills;
  final int hp;
  int currentHp;
  final int ac;
  List<Resource> resources;

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

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

@JsonSerializable()
class Resource {
  Resource({
    required this.name,
    required this.maxUses,
    required this.remainingUses,
    required this.onShortRest,
  });

  factory Resource.fromJson(Map<String, dynamic> json) =>
      _$ResourceFromJson(json);

  final String name;
  final int maxUses;
  int remainingUses;
  final bool onShortRest;

  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}
