class Spells {
  final String index;
  final String name;
  final String url;

  const Spells({
    required this.index,
    required this.name,
    required this.url,
  });
  factory Spells.fromJson(Map<String, dynamic> json) {
    return Spells(index: json['index'], name: json['name'], url: json['url']);
  }
}

class Spell {
  final String id;
  // final String index;
  final String name;
  final String desc;
  final List higer_level;
  final String range;
  final List components;
  final bool ritual;
  final String duration;
  final bool concentration;
  final String casting_time;
  final int level;
  // final Map heal_at_slot_level;
  final Map school;
  final List classes;
  final List subclasses;
  // final String url;

  const Spell({
    required this.id,
    required this.desc,
    required this.higer_level,
    required this.range,
    required this.components,
    required this.ritual,
    required this.duration,
    required this.concentration,
    required this.casting_time,
    required this.level,
    // required this.heal_at_slot_level,
    required this.school,
    required this.classes,
    required this.subclasses,
    // required this.index,
    required this.name,
    // required this.url,
  });
  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      // index: json['index'],
      name: json['name'],
      // url: json['url'],
      casting_time: json['casting_time'],
      classes: json['classes'],
      components: json['components'],
      concentration: json['concentration'],
      desc: json['desc'],
      duration: json['duration'],
      // heal_at_slot_level: json['heal_at_slot_level'],
      higer_level: json['higher_level'],
      id: json['id'],
      level: json['level'],
      range: json['range'],
      ritual: json['ritual'],
      school: json['school'],
      subclasses: json['subclasses'],
    );
  }
}
