import 'dart:convert';

class Spot {
  final String id;
  final String title;
  final String? description;
  final double lat;
  final double lng;
  final String? url;
  final String? author;
  final DateTime createdAt;

  Spot({
    required this.id,
    required this.title,
    this.description,
    required this.lat,
    required this.lng,
    this.url,
    this.author,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
    url: json['url'] as String?,
    author: json['author'] as String?,
    createdAt:
        json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'lat': lat,
    'lng': lng,
    'url': url,
    'author': author,
    'createdAt': createdAt.toIso8601String(),
  };

  @override
  String toString() => jsonEncode(toJson());
}
