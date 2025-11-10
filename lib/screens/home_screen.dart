import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/spot.dart';
import '../repository/in_memory_spot_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InMemorySpotRepository _repo = InMemorySpotRepository();
  List<Spot> _spots = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await _repo.initFromAsset();
    final all = await _repo.getAll();
    setState(() {
      _spots = all;
      _loading = false;
    });
  }

  void _openUrl(String? url) async {
    if (url == null) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    // BuildContext を async 後に直接使わないよう、事前に ScaffoldMessengerState を取得する
    final messenger = ScaffoldMessenger.of(context);
    final launched = await launchUrl(uri);
    if (!launched && mounted) {
      messenger.showSnackBar(const SnackBar(content: Text('URL を開けません')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('函館マップコレクション（簡易）')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                options: MapOptions(
                  center: LatLng(41.773, 140.726), // 函館中心付近
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers:
                        _spots
                            .map(
                              (s) => Marker(
                                width: 40,
                                height: 40,
                                point: LatLng(s.lat, s.lng),
                                builder:
                                    (ctx) => IconButton(
                                      icon: const Icon(
                                        Icons.location_on,
                                        color: Colors.purple,
                                      ),
                                      onPressed: () => _showSpotSheet(s),
                                    ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
    );
  }

  void _showSpotSheet(Spot s) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if ((s.description ?? '').isNotEmpty) Text(s.description!),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _openUrl(s.url),
                        child: const Text('公式サイトを開く'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('閉じる'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
