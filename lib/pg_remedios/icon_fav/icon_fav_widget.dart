import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/backend/offline/sync_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'icon_fav_model.dart';
export 'icon_fav_model.dart';

class IconFavWidget extends StatefulWidget {
  const IconFavWidget({
    super.key,
    required this.medID,
    this.onFavChanged,
  });

  final int? medID;
  final Function()? onFavChanged;

  @override
  State<IconFavWidget> createState() => _IconFavWidgetState();
}

class _IconFavWidgetState extends State<IconFavWidget> {
  late IconFavModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IconFavModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MedicamentosFavRow>>(
      future: (_model.requestCompleter ??= Completer<List<MedicamentosFavRow>>()
            ..complete(MedicamentosFavTable().querySingleRow(
              queryFn: (q) => q
                  .eqOrNull(
                    'user_id',
                    currentUserUid,
                  )
                  .eqOrNull(
                    'med_id',
                    widget!.medID,
                  ),
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitRing(
                color: Color(0xFF3C4F67),
                size: 50.0,
              ),
            ),
          );
        }
        List<MedicamentosFavRow> containerMedicamentosFavRowList =
            snapshot.data!;

        final containerMedicamentosFavRow =
            containerMedicamentosFavRowList.isNotEmpty
                ? containerMedicamentosFavRowList.first
                : null;

        return Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (containerMedicamentosFavRow?.id == null)
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    // Usa SyncManager para funcionar offline
                    await SyncManager.instance
                        .addFavorite('medicamento', widget!.medID!);
                    safeSetState(() => _model.requestCompleter = null);
                    await _model.waitForRequestCompleted();
                    if (widget.onFavChanged != null) {
                      widget.onFavChanged!();
                    }
                  },
                  child: Icon(
                    Icons.star_border,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
              if (containerMedicamentosFavRow?.id != null)
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    // Usa SyncManager para funcionar offline
                    await SyncManager.instance
                        .removeFavorite('medicamento', widget!.medID!);
                    safeSetState(() => _model.requestCompleter = null);
                    await _model.waitForRequestCompleted();
                    if (widget.onFavChanged != null) {
                      widget.onFavChanged!();
                    }
                  },
                  child: Icon(
                    Icons.star_rate,
                    color: Color(0xFFFFED00),
                    size: 24.0,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
