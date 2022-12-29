class NoticiaModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoticiaModel(
    this.id,
    this.title,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  );

  factory NoticiaModel.fromJson(Map map) {
    return NoticiaModel(
      map['id'] ?? '',
      map['title'],
      map['description'],
      map['image'],
      DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'NoticiaModel(id: $id, title: $title, description: $description, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
