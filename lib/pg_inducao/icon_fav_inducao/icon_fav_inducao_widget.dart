import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/backend/offline/sync_manager.dart';
import '/backend/offline/offline_database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'icon_fav_inducao_model.dart';
export 'icon_fav_inducao_model.dart';

class IconFavInducaoWidget extends StatefulWidget {
  const IconFavInducaoWidget({
    super.key,
    required this.inducaoID,
    this.onFavChanged,
  });

  final int? inducaoID;
  final Function()? onFavChanged;

  @override
  State<IconFavInducaoWidget> createState() => _IconFavInducaoWidgetState();
}

class _IconFavInducaoWidgetState extends State<IconFavInducaoWidget> {
  late IconFavInducaoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IconFavInducaoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<bool> _checkIfFavorite() async {
    final syncManager = SyncManager.instance;

    if (syncManager.isOnline) {
      // Online: verifica no Supabase
      try {
        final result = await InducoesFavTable().querySingleRow(
          queryFn: (q) => q
              .eqOrNull('ind_usr_id', currentUserUid)
              .eqOrNull('ind_id', widget.inducaoID),
        );
        return result.isNotEmpty;
      } catch (e) {
        // Se falhar online, verifica no cache
        return await _checkFavoriteInCache();
      }
    } else {
      // Offline: verifica no cache local
      return await _checkFavoriteInCache();
    }
  }

  Future<bool> _checkFavoriteInCache() async {
    final db = await OfflineDatabase.instance.database;
    final result = await db.query(
      'inducoes',
      where: 'remote_id = ? AND is_favorite = 1',
      whereArgs: [widget.inducaoID],
    );
    return result.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkIfFavorite(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Container(
            width: 24.0,
            height: 24.0,
            child: Center(
              child: SizedBox(
                width: 16.0,
                height: 16.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
            ),
          );
        }

        final isFavorite = snapshot.data!;

        return Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (isFavorite) {
                // Remove favorito
                await SyncManager.instance
                    .removeFavorite('inducao', widget.inducaoID!);
              } else {
                // Adiciona favorito
                await SyncManager.instance
                    .addFavorite('inducao', widget.inducaoID!);
              }

              // Atualiza UI
              safeSetState(() {});

              // Notifica parent
              if (widget.onFavChanged != null) {
                widget.onFavChanged!();
              }
            },
            child: Icon(
              isFavorite ? Icons.star_rate : Icons.star_border,
              color: isFavorite
                  ? Color(0xFFFFED00)
                  : FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
          ),
        );
      },
    );
  }
}
