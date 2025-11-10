import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/spot.dart';
import 'spot_repository.dart';

class InMemorySpotRepository implements SpotRepository {
  final List<Spot> _spots = [];

  /// assets/places.json から初期データをロードする
  Future<void> initFromAsset() async {
    try {
      final raw = await rootBundle.loadString('assets/places.json');
      final list = jsonDecode(raw) as List<dynamic>;
      _spots.clear();
      for (final e in list) {
        _spots.add(Spot.fromJson(Map<String, dynamic>.from(e as Map)));
      }
    } catch (e) {
      // asset がない場合は空のまま
    }
  }

  @override
  Future<List<Spot>> getAll() async => List.unmodifiable(_spots);

  @override
  Future<void> add(Spot spot) async {
    _spots.add(spot);
  }

  @override
  Future<List<Spot>> search(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return getAll();
    return _spots
        .where((s) {
          final t = s.title.toLowerCase();
          final d = (s.description ?? '').toLowerCase();
          return t.contains(q) || d.contains(q);
        })
        .toList(growable: false);
  }
}
