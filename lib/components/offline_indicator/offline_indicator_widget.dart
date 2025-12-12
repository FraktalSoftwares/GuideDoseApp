import 'package:flutter/material.dart';
import '/backend/offline/sync_manager.dart';

class OfflineIndicatorWidget extends StatefulWidget {
  const OfflineIndicatorWidget({Key? key}) : super(key: key);

  @override
  State<OfflineIndicatorWidget> createState() => _OfflineIndicatorWidgetState();
}

class _OfflineIndicatorWidgetState extends State<OfflineIndicatorWidget> {
  final _syncManager = SyncManager.instance;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _isOnline = _syncManager.isOnline;

    // Escuta mudanças no status de conexão
    _syncManager.onlineStatus.listen((isOnline) {
      if (mounted) {
        setState(() {
          _isOnline = isOnline;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isOnline) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        border: Border(
          bottom: BorderSide(
            color: Colors.orange.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 16,
            color: Colors.orange.shade800,
          ),
          const SizedBox(width: 8),
          Text(
            'Modo Offline - Dados salvos localmente',
            style: TextStyle(
              color: Colors.orange.shade800,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
