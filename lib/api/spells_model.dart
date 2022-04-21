class Spells {
  final String index;
  final String name;
  final String url;

  const Spells({
    required this.index,
    required this.name,
    required this.url,
  });

  // factory Post.fromMap(Map<String, String> map) {
  //   return Post(
  //     index: map['index'] as String,
  //     name: map['name'] as String,
  //     url: map['url'] as String,
  //   );
  // }
  factory Spells.fromJson(Map<String, dynamic> json) {
    return Spells(index: json['index'], name: json['name'], url: json['url']);
  }
}
