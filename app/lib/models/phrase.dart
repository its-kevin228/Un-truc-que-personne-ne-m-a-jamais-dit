class Phrase {
  final int id;
  final String content;

  Phrase({required this.id, required this.content});

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(id: json['id'] as int, content: json['content'] as String);
  }

  // Phrase par défaut en cas d'erreur
  factory Phrase.defaultPhrase() {
    return Phrase(
      id: 0,
      content:
          "Parfois, le plus beau cadeau que tu peux te faire, c'est de te laisser le temps.",
    );
  }
}
