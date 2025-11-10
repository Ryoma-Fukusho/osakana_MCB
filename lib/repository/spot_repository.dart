import '../models/spot.dart';

abstract class SpotRepository {
  /// 全スポットを取得する
  Future<List<Spot>> getAll();

  /// スポットを追加する
  Future<void> add(Spot spot);

  /// 検索（タイトルまたは説明の部分一致）
  Future<List<Spot>> search(String query);
}
