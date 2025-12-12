import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InducoesFavRow>>(
      future: (_model.requestCompleter ??= Completer<List<InducoesFavRow>>()
            ..complete(InducoesFavTable().querySingleRow(
              queryFn: (q) => q
                  .eqOrNull(
                    'ind_usr_id',
                    currentUserUid,
                  )
                  .eqOrNull(
                    'ind_id',
                    widget!.inducaoID,
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
        List<InducoesFavRow> containerInducoesFavRowList = snapshot.data!;

        final containerInducoesFavRow = containerInducoesFavRowList.isNotEmpty
            ? containerInducoesFavRowList.first
            : null;

        return Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (containerInducoesFavRow?.id == null)
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await InducoesFavTable().insert({
                      'created_at':
                          supaSerialize<DateTime>(getCurrentTimestamp),
                      'ind_usr_id': currentUserUid,
                      'ind_id': widget!.inducaoID,
                    });
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
              if (containerInducoesFavRow?.id != null)
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await InducoesFavTable().delete(
                      matchingRows: (rows) => rows.eqOrNull(
                        'ind_id',
                        widget!.inducaoID,
                      ),
                    );
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
