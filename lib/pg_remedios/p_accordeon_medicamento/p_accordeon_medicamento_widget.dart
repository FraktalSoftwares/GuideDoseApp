import '/backend/supabase/supabase.dart';
import '/backend/offline/sync_manager.dart';
import '/backend/offline/offline_database.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_accordeon_medicamento_model.dart';
export 'p_accordeon_medicamento_model.dart';

class PAccordeonMedicamentoWidget extends StatefulWidget {
  const PAccordeonMedicamentoWidget({
    super.key,
    required this.id,
  });

  final int? id;

  @override
  State<PAccordeonMedicamentoWidget> createState() =>
      _PAccordeonMedicamentoWidgetState();
}

class _PAccordeonMedicamentoWidgetState
    extends State<PAccordeonMedicamentoWidget> {
  late PAccordeonMedicamentoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PAccordeonMedicamentoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  // MÃ©todo helper para carregar dados do accordion (online ou offline)
  Future<List<Map<String, dynamic>>> _loadAccordeonData() async {
    print(
        'ðŸ” ACCORDION MED: Iniciando carregamento para medicamento ${widget.id}');
    final syncManager = SyncManager.instance;
    print('ðŸ“¡ ACCORDION MED: Status online: ${syncManager.isOnline}');

    if (syncManager.isOnline) {
      try {
        print(
            'ðŸŒ ACCORDION MED: Buscando online para medicamento ${widget.id}');
        final rows = await VMedicamentoItensDetalhadosTable().queryRows(
          queryFn: (q) => q.eqOrNull('medicamento_id', widget.id),
        );

        print('âœ… ACCORDION MED: Encontrados ${rows.length} itens online');

        // Converte VMedicamentoItensDetalhadosRow para Map
        final result = rows
            .map((row) => {
                  'id': row.id,
                  'medicamento_id': row.medicamentoId,
                  'topico': row.topico,
                  'ordem': row.ordem,
                  'titulo': row.titulo,
                  'subtitulo': row.subtitulo,
                  'concentracao': row.concentracao,
                  'unidade_calculo': row.unidadeCalculo,
                  'dose_min': row.doseMin,
                  'dose_max': row.doseMax,
                  'dose_teto': row.doseTeto,
                  'contexto': row.contexto,
                  'tipo_indicacao': row.tipoIndicacao,
                  'dados_calculo': row.dadosCalculo,
                })
            .toList();

        // Remove duplicatas por ID
        final uniqueItems = <String, Map<String, dynamic>>{};
        for (var item in result) {
          final key = item['id'].toString();
          if (!uniqueItems.containsKey(key)) {
            uniqueItems[key] = item;
          }
        }
        final finalResult = uniqueItems.values.toList();

        print('Topicos: ${finalResult.map((e) => e['topico']).toSet()}');
        return finalResult;
      } catch (e) {
        print('âŒ ACCORDION MED: Erro ao buscar online: $e');
        // Se falhar online, tenta offline - continua para o bloco abaixo
      }
    }

    // Offline: busca do cache (ou fallback quando online falha)
    try {
      print(
          '📦 ACCORDION MED: Buscando do cache para medicamento ${widget.id}');
      final cached = await OfflineDatabase.instance
          .getAccordeonByMedicamentoId(widget.id ?? 0);
      print('âœ… ACCORDION MED: Encontrados ${cached.length} itens no cache');

      // dados_calculo já vem decodificado do banco (offline_database.dart)
      final result = cached.map((item) {
        return {
          'id': item['remote_id'],
          'medicamento_id': item['medicamento_id'],
          'topico': item['topico'],
          'ordem': item['ordem'],
          'titulo': item['titulo'],
          'subtitulo': item['subtitulo'],
          'concentracao': item['concentracao'],
          'unidade_calculo': item['unidade_calculo'],
          'dose_min': item['dose_min'],
          'dose_max': item['dose_max'],
          'dose_teto': item['dose_teto'],
          'contexto': item['contexto'],
          'tipo_indicacao': item['tipo_indicacao'],
          'dados_calculo': item['dados_calculo'],
        };
      }).toList();

      // Remove duplicatas por ID
      final uniqueItems = <String, Map<String, dynamic>>{};
      for (var item in result) {
        final key = item['id'].toString();
        if (!uniqueItems.containsKey(key)) {
          uniqueItems[key] = item;
        }
      }
      final finalResult = uniqueItems.values.toList();

      print('Topicos: ${finalResult.map((e) => e['topico']).toSet()}');
      print('Removidas ${result.length - finalResult.length} duplicatas');
      return finalResult;
    } catch (e) {
      print('âŒ ACCORDION MED: Erro ao buscar do cache: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadAccordeonData(),
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
        List<Map<String, dynamic>> containerVMedicamentoItensDetalhadosRowList =
            snapshot.data ?? [];

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  '86ehoge5' /* Preparo */,
                ),
                style: FlutterFlowTheme.of(context).textAuth.override(
                      font: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).textAuth.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).text,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).textAuth.fontStyle,
                    ),
              ),
              Builder(
                builder: (context) {
                  final medicamento =
                      containerVMedicamentoItensDetalhadosRowList
                          .map((e) => e)
                          .toList()
                          .where((e) => 'Preparo' == e['topico'])
                          .toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: medicamento.length,
                    itemBuilder: (context, medicamentoIndex) {
                      final medicamentoItem = medicamento[medicamentoIndex];
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  valueOrDefault<String>(
                                    medicamentoItem['titulo'],
                                    '-',
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFFE2E8F0),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              if (medicamentoItem['subtitulo'] != null &&
                                  medicamentoItem['subtitulo'] != '' &&
                                  medicamentoItem['subtitulo']
                                          .toString()
                                          .toLowerCase() !=
                                      'indefinido')
                                Flexible(
                                  child: Text(
                                    valueOrDefault<String>(
                                      medicamentoItem['subtitulo'],
                                      '-',
                                    ),
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFFE2E8F0),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 4.0))
                            .addToEnd(SizedBox(height: 4.0)),
                      );
                    },
                  );
                },
              ),
              Divider(
                height: 2.0,
                thickness: 1.0,
                color: Color(0xFFE2E8F0),
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'qxvq84ir' /* IndicaÃ§Ã£o e doses */,
                ),
                style: FlutterFlowTheme.of(context).textAuth.override(
                      font: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).textAuth.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).text,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).textAuth.fontStyle,
                    ),
              ),
              Builder(
                builder: (context) {
                  // Obtém a faixa etária do usuário
                  var faixaEtaria = FFAppState().User.usrFaixa?.toLowerCase() ?? '';
                  
                  // Se a faixa etária estiver vazia, tenta calcular a partir da idade
                  if (faixaEtaria.isEmpty) {
                    final idadeString = FFAppState().User.usrIdade ?? '';
                    final anosMeses = FFAppState().User.usrAnosmeses ?? 'Anos';
                    final linguagem = FFAppState().User.usrLinguagem ?? 'Português';
                    
                    double idadeEmAnos = 0;
                    
                    if (idadeString.isNotEmpty) {
                      final idadeNumero = double.tryParse(idadeString.replaceAll(',', '.')) ?? 0;
                      
                      // Se está em meses, converte para anos
                      if (anosMeses.toLowerCase() == 'meses') {
                        idadeEmAnos = idadeNumero / 12.0;
                      } else {
                        // Se está em anos, usa diretamente
                        idadeEmAnos = idadeNumero;
                      }
                    }
                    
                    if (idadeEmAnos > 0) {
                      // Calcula a faixa etária baseado na idade em anos
                      String faixaCalculada;
                      final lang = linguagem.toLowerCase();
                      
                      if (idadeEmAnos < 1) {
                        faixaCalculada = lang.contains('english') ? 'Newborn (Neonate)' : 
                                        (lang.contains('español') || lang.contains('espanõl')) ? 'RN (Recién Nacido)' : 
                                        'RN (Recém-Nascido)';
                      } else if (idadeEmAnos < 5) {
                        faixaCalculada = lang.contains('english') ? 'Small Child' : 
                                        (lang.contains('español') || lang.contains('espanõl')) ? 'Niño Pequeño' : 
                                        'Infantil Pequena';
                      } else if (idadeEmAnos < 12) {
                        faixaCalculada = lang.contains('english') ? 'Large Child' : 
                                        (lang.contains('español') || lang.contains('espanõl')) ? 'Niño Grande' : 
                                        'Infantil Grande';
                      } else if (idadeEmAnos <= 17) {
                        faixaCalculada = lang.contains('english') ? 'Teenager' : 'Adolescente';
                      } else if (idadeEmAnos <= 59) {
                        faixaCalculada = 'Adulto';
                      } else {
                        faixaCalculada = lang.contains('english') ? 'Elderly' : 
                                        (lang.contains('español') || lang.contains('espanõl')) ? 'Anciano' : 
                                        'Idoso';
                      }
                      
                      faixaEtaria = faixaCalculada.toLowerCase();
                      
                      // Atualiza o FFAppState com a faixa calculada
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        FFAppState().updateUserStruct((e) => e..usrFaixa = faixaCalculada);
                        print('🔍 FILTRO: Faixa etária calculada automaticamente: $faixaCalculada (idade: ${idadeEmAnos.toStringAsFixed(2)} anos)');
                      });
                    }
                  }
                  
                  final isAdulto = faixaEtaria.contains('adulto');
                  final isPediatrico = !isAdulto && (faixaEtaria.contains('criança') || 
                                                      faixaEtaria.contains('adolescente') || 
                                                      faixaEtaria.contains('infantil') ||
                                                      faixaEtaria.contains('niño'));
                  
                  // Debug: verifica faixa etária
                  print('🔍 FILTRO: Faixa etária do usuário: ${FFAppState().User.usrFaixa}');
                  print('🔍 FILTRO: Faixa etária processada: $faixaEtaria');
                  print('🔍 FILTRO: isAdulto: $isAdulto, isPediatrico: $isPediatrico');

                  final medicamento =
                      containerVMedicamentoItensDetalhadosRowList
                          .map((e) => e)
                          .toList()
                          .where((e) => 'Indicações' == e['topico'])
                          .where((e) {
                            // Se não há faixa etária definida, mostra todos
                            if (faixaEtaria.isEmpty) return true;

                            final titulo = (e['titulo'] ?? '').toString().toLowerCase();
                            final subtitulo = (e['subtitulo'] ?? '').toString().toLowerCase();
                            final textoCompleto = '$titulo $subtitulo';

                            // Verifica se contém indicação de faixa etária - APENAS TAGS COM PARÊNTESES
                            // Isso evita falsos positivos quando a palavra aparece em outros contextos
                            final contemPediatrico = textoCompleto.contains('(pediátrico)') || 
                                                     textoCompleto.contains('(pediatrico)');
                            final contemAdulto = textoCompleto.contains('(adulto)');
                            
                            // Debug: verifica o que está sendo detectado
                            if (contemPediatrico || contemAdulto) {
                              print('🔍 FILTRO: Item "${titulo.substring(0, titulo.length > 50 ? 50 : titulo.length)}..."');
                              print('   - Contém Pediátrico: $contemPediatrico');
                              print('   - Contém Adulto: $contemAdulto');
                            }

                            // Se não tem nenhuma indicação de faixa, mostra normalmente
                            if (!contemPediatrico && !contemAdulto) return true;

                            // Filtra baseado na faixa etária do usuário
                            if (isAdulto) {
                              // Se é adulto, NÃO mostra os que têm "(Pediátrico)"
                              if (contemPediatrico) {
                                print('   ❌ FILTRO: Item pediátrico REMOVIDO (faixa: Adulto)');
                                return false;
                              }
                              // Mostra os que têm "(Adulto)" OU os que não têm indicação de faixa
                              if (contemAdulto) {
                                print('   ✅ FILTRO: Item adulto MANTIDO');
                              } else {
                                print('   ✅ FILTRO: Item sem indicação MANTIDO (faixa: Adulto)');
                              }
                              return true; // Mantém todos que não são pediátricos
                            } else if (isPediatrico) {
                              // Se é pediátrico, NÃO mostra os que têm "(Adulto)"
                              if (contemAdulto) {
                                print('   ❌ FILTRO: Item adulto REMOVIDO (faixa: Pediátrico)');
                                return false;
                              }
                              // Mostra os que têm "(Pediátrico)" OU os que não têm indicação de faixa
                              if (contemPediatrico) {
                                print('   ✅ FILTRO: Item pediátrico MANTIDO');
                              } else {
                                print('   ✅ FILTRO: Item sem indicação MANTIDO (faixa: Pediátrico)');
                              }
                              return true; // Mantém todos que não são adultos
                            }

                            // Caso padrão: mostra todos
                            return true;
                          })
                          .toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: medicamento.length,
                    itemBuilder: (context, medicamentoIndex) {
                      final medicamentoItem = medicamento[medicamentoIndex];
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  valueOrDefault<String>(
                                    medicamentoItem['titulo'],
                                    '-',
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFFE2E8F0),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              if (medicamentoItem['subtitulo'] != null &&
                                  medicamentoItem['subtitulo'] != '' &&
                                  medicamentoItem['subtitulo']
                                          .toString()
                                          .toLowerCase() !=
                                      'indefinido')
                                Flexible(
                                  child: Text(
                                    valueOrDefault<String>(
                                      medicamentoItem['subtitulo'],
                                      '-',
                                    ),
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFFE2E8F0),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 4.0))
                            .addToEnd(SizedBox(height: 4.0)),
                      );
                    },
                  );
                },
              ),
              Divider(
                height: 2.0,
                thickness: 1.0,
                color: Color(0xFFE2E8F0),
              ),
              if ('true' ==
                      getJsonField(
                        containerVMedicamentoItensDetalhadosRowList
                            .where((e) =>
                                (widget!.id == e['medicamento_id']) &&
                                ('SliderConfig' == e['topico']))
                            .toList()
                            .firstOrNull?['dados_calculo'],
                        r'''$.slideInput''',
                      ).toString()
                  ? true
                  : false)
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        '7hb7xx6k' /* IndicaÃ§Ã£o e doses */,
                      ),
                      style: FlutterFlowTheme.of(context)
                          .titleMedicamentos
                          .override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedicamentos
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .fontStyle,
                          ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            // Obtém as opções do dropdown
                            final opcoes = functions.getDropdownLabels(
                                containerVMedicamentoItensDetalhadosRowList
                                    .map((e) => e['dados_calculo'])
                                    .withoutNulls
                                    .toList());
                            
                            // Se não tem valor selecionado e há opções disponíveis, seleciona a primeira
                            final valorAtual = _model.dropDownValue;
                            final precisaSelecionar = (valorAtual == null || valorAtual.isEmpty) && opcoes.isNotEmpty;
                            
                            if (precisaSelecionar) {
                              // Usa WidgetsBinding para garantir que o estado seja atualizado após o build
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                final valorAtualCallback = _model.dropDownValue;
                                if (mounted && 
                                    (valorAtualCallback == null || valorAtualCallback.isEmpty) &&
                                    opcoes.isNotEmpty) {
                                  safeSetState(() {
                                    _model.dropDownValue = opcoes.first;
                                    _model.dropDownValueController?.value = opcoes.first;
                                  });
                                }
                              });
                            }
                            
                            return Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: FlutterFlowDropDown<String>(
                                controller: _model.dropDownValueController ??=
                                    FormFieldController<String>(
                                  _model.dropDownValue ??= opcoes.isNotEmpty ? opcoes.first : '',
                                ),
                                options: List<String>.from(opcoes),
                                optionLabels: opcoes,
                                onChanged: (val) =>
                                    safeSetState(() => _model.dropDownValue = val),
                            width: double.infinity,
                            height: 40.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              'q8ad2f5g' /* Selecione */,
                            ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                elevation: 2.0,
                                borderColor: Colors.transparent,
                                borderWidth: 0.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                            );
                          },
                        ),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                          color: Color(0xFF42546E),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                              builder: (context) {
                                // Obtém valores necessários
                                final sliderValue = _model.sliderPrincipalValue ?? 0.0;
                                final pesoString = FFAppState().User.uSRKGs ?? '';
                                final peso = double.tryParse(pesoString.replaceAll(',', '.')) ?? 0.0;
                                
                                // Obtém a unidade do JSON
                                final unidade = getJsonField(
                                  containerVMedicamentoItensDetalhadosRowList
                                      .where((e) =>
                                          (widget!.id == e['medicamento_id']) &&
                                          ('SliderConfig' == e['topico']))
                                      .toList()
                                      .firstOrNull?['dados_calculo'],
                                  r'''$.unidade''',
                                ).toString();
                                
                                // Extrai as partes da unidade (ex: "mcg/kg/min" -> ["mcg", "kg", "min"])
                                final partesUnidade = unidade.split('/');
                                
                                // Calcula o resultado do cálculo: peso x mcg (sliderValue)
                                // Se a unidade contém "kg", multiplica peso pelo valor do slider
                                // Caso contrário, usa apenas o valor do slider
                                final usaPeso = unidade.contains('kg');
                                final doseTotal = usaPeso ? (peso * sliderValue) : sliderValue;
                                
                                // Formata a exibição: mostra o resultado do cálculo dinamicamente
                                // Conforme o slider muda, o valor de mcg aumenta baseado no cálculo
                                String textoExibicao;
                                if (peso > 0 && sliderValue > 0 && partesUnidade.length >= 2) {
                                  // Extrai mcg (ou mg, mEq, etc) da unidade (primeira parte)
                                  final unidadeDose = partesUnidade.isNotEmpty ? partesUnidade[0] : '';
                                  // Extrai min (ou h) da unidade (última parte)
                                  final unidadeTempo = partesUnidade.length > 1 ? partesUnidade[partesUnidade.length - 1] : '';
                                  
                                  // Mostra o resultado do cálculo: "doseTotal mcg/min"
                                  // Exemplo: "18.0 mcg/min" (onde 18 = 60kg x 0.3mcg/kg/min)
                                  // Conforme aumenta a vazão (slider), o valor de mcg aumenta dinamicamente
                                  textoExibicao = '${doseTotal.toStringAsFixed(1)} $unidadeDose/$unidadeTempo';
                                } else if (sliderValue > 0) {
                                  // Fallback: mostra formato antigo se não conseguir calcular
                                  textoExibicao = '${sliderValue.toStringAsFixed(1)} $unidade';
                                } else {
                                  // Se não tem valor ainda, mostra apenas a unidade
                                  textoExibicao = unidade.isNotEmpty ? unidade : 'Ajuste a dose';
                                }
                                
                                return Text(
                                  textoExibicao,
                                  style: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FlutterFlowTheme.of(context)
                                              .infoMedicamentos
                                              .fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context)
                                              .infoMedicamentos
                                              .fontStyle,
                                        ),
                                        color: Color(0xFF94A3B8),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                );
                              },
                            ),
                            Flexible(
                              child: Text(
                                getJsonField(
                                  containerVMedicamentoItensDetalhadosRowList
                                      .where((e) =>
                                          (widget!.id == e['medicamento_id']) &&
                                          ('SliderConfig' == e['topico']))
                                      .toList()
                                      .firstOrNull?['dados_calculo'],
                                  r'''$.doseMax''',
                                )?.toString() ?? '',
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF94A3B8),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Builder(
                          builder: (context) {
                            // Obtém a unidade do JSON para exibir no balão do slider
                            final unidade = getJsonField(
                              containerVMedicamentoItensDetalhadosRowList
                                  .where((e) =>
                                      (widget!.id == e['medicamento_id']) &&
                                      ('SliderConfig' == e['topico']))
                                  .toList()
                                  .firstOrNull?['dados_calculo'],
                              r'''$.unidade''',
                            ).toString();
                            
                            // Remove espaços extras e garante que a unidade está limpa
                            final unidadeLimpa = unidade.trim();
                            
                            // Obtém o valor atual do slider (atualiza dinamicamente)
                            final valorAtual = _model.sliderPrincipalValue ?? 0.0;
                            
                            // Formata o label com valor + unidade completa
                            // Suporta: mcg/kg/min, mg/kg/min, U/h, e outras unidades
                            // Prioriza a exibição do valor direto com unidade completa no balão
                            final labelCompleto = unidadeLimpa.isNotEmpty 
                                ? '${valorAtual.toStringAsFixed(1)} $unidadeLimpa'
                                : valorAtual.toStringAsFixed(1);
                            
                            return SliderTheme(
                              data: SliderThemeData(
                                showValueIndicator: ShowValueIndicator.always,
                              ),
                              child: Slider.adaptive(
                                activeColor: Color(0xFF456A92),
                                inactiveColor:
                                    FlutterFlowTheme.of(context).alternate,
                                min: valueOrDefault<double>(
                                  functions.getSliderParam(
                                      containerVMedicamentoItensDetalhadosRowList
                                          .map((e) => e['dados_calculo'])
                                          .withoutNulls
                                          .toList(),
                                      'doseMin'),
                                  0.0,
                                ),
                                max: valueOrDefault<double>(
                                  functions.getSliderParam(
                                      containerVMedicamentoItensDetalhadosRowList
                                          .map((e) => e['dados_calculo'])
                                          .withoutNulls
                                          .toList(),
                                      'doseMax'),
                                  0.0,
                                ),
                                value: _model.sliderPrincipalValue ??=
                                    functions.getSliderParam(
                                        containerVMedicamentoItensDetalhadosRowList
                                            .map((e) => e['dados_calculo'])
                                            .withoutNulls
                                            .toList(),
                                        'doseMin'),
                                label: labelCompleto,
                                onChanged: (newValue) {
                                  newValue =
                                      double.parse(newValue.toStringAsFixed(1));
                                  safeSetState(
                                      () => _model.sliderPrincipalValue = newValue);
                                },
                              ),
                            );
                          },
                        ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          Builder(
                            builder: (context) {
                              // Obtém a unidade do JSON para exibir no balão do slider
                              final unidade = getJsonField(
                                containerVMedicamentoItensDetalhadosRowList
                                    .where((e) =>
                                        (widget!.id == e['medicamento_id']) &&
                                        ('SliderConfig' == e['topico']))
                                    .toList()
                                    .firstOrNull?['dados_calculo'],
                                r'''$.unidade''',
                              ).toString();
                              
                              // Remove espaços extras e garante que a unidade está limpa
                              final unidadeLimpa = unidade.trim();
                              
                              // Obtém o valor atual do slider (atualiza dinamicamente)
                              final valorAtual = _model.sliderValue ?? 0.0;
                              
                              // Formata o label com valor + unidade completa
                              // Suporta: mcg/kg/min, mg/kg/min, U/h, e outras unidades
                              // Prioriza a exibição do valor direto com unidade completa no balão
                              final labelCompleto = unidadeLimpa.isNotEmpty 
                                  ? '${valorAtual.toStringAsFixed(1)} $unidadeLimpa'
                                  : valorAtual.toStringAsFixed(1);
                              
                              return SliderTheme(
                                data: SliderThemeData(
                                  showValueIndicator: ShowValueIndicator.always,
                                ),
                                child: Slider.adaptive(
                                  activeColor: Color(0xFF456A92),
                                  inactiveColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  min: valueOrDefault<double>(
                                    getJsonField(
                                      containerVMedicamentoItensDetalhadosRowList
                                          .where((e) =>
                                              (widget!.id == e['medicamento_id']) &&
                                              ('SliderConfig' == e['topico']))
                                          .toList()
                                          .firstOrNull?['dados_calculo'],
                                      r'''$.doseMin''',
                                    ),
                                    0.0,
                                  ),
                                  max: valueOrDefault<double>(
                                    getJsonField(
                                      containerVMedicamentoItensDetalhadosRowList
                                          .where((e) =>
                                              (widget!.id == e['medicamento_id']) &&
                                              ('SliderConfig' == e['topico']))
                                          .toList()
                                          .firstOrNull?['dados_calculo'],
                                      r'''$.doseMax''',
                                    ),
                                    0.5,
                                  ),
                                  value: _model.sliderValue ??= valueOrDefault<double>(
                                    getJsonField(
                                      containerVMedicamentoItensDetalhadosRowList
                                          .where((e) =>
                                              (widget!.id == e['medicamento_id']) &&
                                              ('SliderConfig' == e['topico']))
                                          .toList()
                                          .firstOrNull?['dados_calculo'],
                                      r'''$.doseMin''',
                                    ),
                                    0.0,
                                  ),
                                  label: labelCompleto,
                                  onChanged: (newValue) {
                                    newValue =
                                        double.parse(newValue.toStringAsFixed(1));
                                    safeSetState(
                                        () => _model.sliderValue = newValue);
                                  },
                                ),
                              );
                            },
                          ),
                        Text(
                          valueOrDefault<String>(
                            functions.calcularResultadoMestre(
                                containerVMedicamentoItensDetalhadosRowList
                                    .map((e) => e['dados_calculo'])
                                    .withoutNulls
                                    .toList(),
                                _model.sliderPrincipalValue ?? 0.0,
                                FFAppState().User.uSRKGs,
                                _model.dropDownValue ?? '',
                                valueOrDefault<String>(
                                  FFAppState().User.usrUndMedPeso,
                                  'Quilogramas (kg)',
                                )),
                            '0',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
            ].divide(SizedBox(height: 8.0)),
          ),
        );
      },
    );
  }
}
