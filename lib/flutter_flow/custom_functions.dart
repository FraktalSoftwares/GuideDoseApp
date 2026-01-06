import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

String calcularIMC(
  String peso,
  String altura,
  bool isImperial,
) {
  try {
    final double pesoDouble = double.parse(peso);
    double alturaMetros;

    if (isImperial) {
      // Detecta se é um valor como "510" e trata como 5'10"
      if (altura.length == 3 && altura.endsWith('10')) {
        final feet = int.tryParse(altura.substring(0, 1)) ?? 0;
        final inches = 10;
        final totalPolegadas = (feet * 12) + inches;
        alturaMetros = totalPolegadas * 0.0254;
      } else {
        // Remover possíveis espaços, "ft", "in", aspas simples e duplas
        String alt = altura
            .replaceAll("ft", "'")
            .replaceAll("in", "")
            .replaceAll("\"", "")
            .replaceAll("’", "'")
            .replaceAll(" ", "")
            .trim();

        int totalPolegadas = 0;

        if (alt.contains("'")) {
          final partes = alt.split("'");
          final feet = int.tryParse(partes[0].trim()) ?? 0;
          final inches =
              partes.length > 1 ? int.tryParse(partes[1].trim()) ?? 0 : 0;
          totalPolegadas = (feet * 12) + inches;
        } else {
          totalPolegadas = int.tryParse(alt) ?? 0;
        }

        alturaMetros = totalPolegadas * 0.0254;
      }

      final double pesoKg = pesoDouble * 0.453592;
      final imc = pesoKg / (alturaMetros * alturaMetros);
      return imc.toStringAsFixed(2);
    } else {
      final double alturaDouble = double.parse(altura);
      alturaMetros = alturaDouble / 100;

      final imc = pesoDouble / (alturaMetros * alturaMetros);
      return imc.toStringAsFixed(2);
    }
  } catch (e) {
    return 'Erro';
  }
}

String avaliarPesoIdeal(
  String altura,
  String peso,
  bool isImperial,
) {
  try {
    double alturaMetros;

    if (isImperial) {
      // Detecta formatos como "5'10", "510", etc.
      if (altura.length == 3 && altura.endsWith('10')) {
        final feet = int.tryParse(altura.substring(0, 1)) ?? 0;
        final inches = 10;
        final totalInches = (feet * 12) + inches;
        alturaMetros = totalInches * 0.0254;
      } else {
        String alt = altura
            .replaceAll("ft", "'")
            .replaceAll("in", "")
            .replaceAll("\"", "")
            .replaceAll("’", "'")
            .replaceAll(" ", "")
            .trim();

        int totalInches = 0;

        if (alt.contains("'")) {
          final partes = alt.split("'");
          final feet = int.tryParse(partes[0].trim()) ?? 0;
          final inches =
              partes.length > 1 ? int.tryParse(partes[1].trim()) ?? 0 : 0;
          totalInches = (feet * 12) + inches;
        } else {
          totalInches = int.tryParse(alt) ?? 0;
        }

        alturaMetros = totalInches * 0.0254;
      }
    } else {
      // Altura métrica em cm → metros
      final alturaCm = double.tryParse(altura.replaceAll(',', '.')) ?? 0.0;
      if (alturaCm == 0.0) return 'Altura inválida.';
      alturaMetros = alturaCm / 100;
    }

    // IMC saudável
    const imcMin = 18.5;
    const imcMax = 24.9;

    final pesoMinKg = imcMin * (alturaMetros * alturaMetros);
    final pesoMaxKg = imcMax * (alturaMetros * alturaMetros);

    if (isImperial) {
      final minLb = pesoMinKg / 0.453592;
      final maxLb = pesoMaxKg / 0.453592;
      return '${minLb.toStringAsFixed(0)}lb e ${maxLb.toStringAsFixed(0)}lb';
    } else {
      return '${pesoMinKg.toStringAsFixed(0)}kg e ${pesoMaxKg.toStringAsFixed(0)}kg';
    }
  } catch (e) {
    return 'Erro';
  }
}

double calcularIMCEsperado(
  String peso,
  String altura,
  String idade,
  String genero,
  bool isImperial,
) {
  final idadeInt = int.tryParse(idade.replaceAll(',', '.')) ?? 0;
  final generoLower = genero.toLowerCase().trim();

  double imcIdeal = 22.0;

  if (generoLower == 'masculino') {
    if (idadeInt < 25)
      imcIdeal = 22.5;
    else if (idadeInt < 35)
      imcIdeal = 23.0;
    else if (idadeInt < 45)
      imcIdeal = 23.5;
    else if (idadeInt < 55)
      imcIdeal = 24.0;
    else
      imcIdeal = 24.5;
  } else if (generoLower == 'feminino') {
    if (idadeInt < 25)
      imcIdeal = 21.5;
    else if (idadeInt < 35)
      imcIdeal = 22.0;
    else if (idadeInt < 45)
      imcIdeal = 22.5;
    else if (idadeInt < 55)
      imcIdeal = 23.0;
    else
      imcIdeal = 23.5;
  }

  return double.parse(imcIdeal.toStringAsFixed(2));
}

String calcularPesoCorrigido(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    double pesoKg;
    double alturaCm;

    if (isImperial) {
      pesoKg = (double.tryParse(peso.replaceAll(',', '.')) ?? 0.0) * 0.453592;

      if (altura.length == 3 && altura.endsWith('10')) {
        final feet = int.tryParse(altura.substring(0, 1)) ?? 0;
        final inches = 10;
        final totalInches = (feet * 12) + inches;
        alturaCm = totalInches * 2.54;
      } else {
        String alt = altura
            .replaceAll("ft", "'")
            .replaceAll("in", "")
            .replaceAll("\"", "")
            .replaceAll("’", "'")
            .replaceAll(" ", "")
            .trim();

        int totalInches = 0;

        if (alt.contains("'")) {
          final partes = alt.split("'");
          final feet = int.tryParse(partes[0].trim()) ?? 0;
          final inches =
              partes.length > 1 ? int.tryParse(partes[1].trim()) ?? 0 : 0;
          totalInches = (feet * 12) + inches;
        } else {
          totalInches = int.tryParse(alt) ?? 0;
        }

        alturaCm = totalInches * 2.54;
      }
    } else {
      pesoKg = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
      alturaCm = double.tryParse(altura.replaceAll(',', '.')) ?? 0.0;
    }

    double idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? 0.0;

    if (pesoKg == 0.0 || alturaCm == 0.0 || idadeAnos == 0.0) {
      return '-';
    }

    double pesoIdeal;

    if (idadeAnos < (1 / 30)) {
      pesoIdeal = 3.5;
    } else if (idadeAnos >= (1 / 30) && idadeAnos < 2) {
      pesoIdeal = 4 + (idadeAnos * 4);
    } else if (idadeAnos >= 2 && idadeAnos <= 10) {
      pesoIdeal = (idadeAnos * 2) + 8;
    } else if (idadeAnos > 10 && idadeAnos < 18) {
      pesoIdeal = idadeAnos * 3;
    } else {
      if (sexo.toLowerCase() == 'masculino') {
        pesoIdeal = 50 + 0.91 * (alturaCm - 152.4);
      } else {
        pesoIdeal = 45.5 + 0.91 * (alturaCm - 152.4);
      }
    }

    double pesoCorrigido;
    if (pesoKg > pesoIdeal * 1.2) {
      pesoCorrigido = pesoIdeal + 0.4 * (pesoKg - pesoIdeal);
    } else {
      pesoCorrigido = pesoKg;
    }

    if (isImperial) {
      final pesoCorrigidoLb = pesoCorrigido / 0.453592;
      return '${pesoCorrigidoLb.toStringAsFixed(1)} lb';
    } else {
      return '${pesoCorrigido.toStringAsFixed(1)} kg';
    }
  } catch (e) {
    return '-';
  }
}

String calcularSuperficieCorporal(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    double pesoKg;
    double alturaCm;

    if (isImperial) {
      pesoKg = (double.tryParse(peso.replaceAll(',', '.')) ?? 0.0) * 0.453592;

      if (altura.length == 3 && altura.endsWith('10')) {
        final feet = int.tryParse(altura.substring(0, 1)) ?? 0;
        final inches = 10;
        final totalInches = (feet * 12) + inches;
        alturaCm = totalInches * 2.54;
      } else {
        String alt = altura
            .replaceAll("ft", "'")
            .replaceAll("in", "")
            .replaceAll("\"", "")
            .replaceAll("’", "'")
            .replaceAll(" ", "")
            .trim();

        int totalInches = 0;

        if (alt.contains("'")) {
          final partes = alt.split("'");
          final feet = int.tryParse(partes[0].trim()) ?? 0;
          final inches =
              partes.length > 1 ? int.tryParse(partes[1].trim()) ?? 0 : 0;
          totalInches = (feet * 12) + inches;
        } else {
          totalInches = int.tryParse(alt) ?? 0;
        }

        alturaCm = totalInches * 2.54;
      }
    } else {
      pesoKg = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
      alturaCm = double.tryParse(altura.replaceAll(',', '.')) ?? 0.0;
    }

    double idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? 0.0;

    if (pesoKg == 0.0 || alturaCm == 0.0 || idadeAnos == 0.0) {
      return '-';
    }

    double bsa = math.sqrt((pesoKg * alturaCm) / 3600);

    double fatorCorrecao = 1.0;

    if (idadeAnos > 40 && idadeAnos <= 60) {
      fatorCorrecao -= (idadeAnos - 40) * 0.005;
    } else if (idadeAnos > 60) {
      fatorCorrecao -= (20 * 0.005) + ((idadeAnos - 60) * 0.01);
    }

    double bsaAjustado = bsa * fatorCorrecao;

    // Ajuste por sexo: feminino -5%
    if (sexo.toLowerCase() == 'feminino') {
      bsaAjustado *= 0.95;
    }

    return '${bsaAjustado.toStringAsFixed(2)} m²';
  } catch (e) {
    return '-';
  }
}

String calcularPercentualPesoIdeal(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    double pesoKg;
    double alturaCm;

    if (isImperial) {
      pesoKg = (double.tryParse(peso.replaceAll(',', '.')) ?? 0.0) * 0.453592;

      if (altura.length == 3 && altura.endsWith('10')) {
        final feet = int.tryParse(altura.substring(0, 1)) ?? 0;
        final inches = 10;
        final totalInches = (feet * 12) + inches;
        alturaCm = totalInches * 2.54;
      } else {
        String alt = altura
            .replaceAll("ft", "'")
            .replaceAll("in", "")
            .replaceAll("\"", "")
            .replaceAll("’", "'")
            .replaceAll(" ", "")
            .trim();

        int totalInches = 0;

        if (alt.contains("'")) {
          final partes = alt.split("'");
          final feet = int.tryParse(partes[0].trim()) ?? 0;
          final inches =
              partes.length > 1 ? int.tryParse(partes[1].trim()) ?? 0 : 0;
          totalInches = (feet * 12) + inches;
        } else {
          totalInches = int.tryParse(alt) ?? 0;
        }

        alturaCm = totalInches * 2.54;
      }
    } else {
      pesoKg = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
      alturaCm = double.tryParse(altura.replaceAll(',', '.')) ?? 0.0;
    }

    double idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? 0.0;

    if (pesoKg == 0.0 || alturaCm == 0.0 || idadeAnos == 0.0) {
      return '-';
    }

    double pesoIdeal;

    if (idadeAnos < (1 / 30)) {
      pesoIdeal = 3.5;
    } else if (idadeAnos >= (1 / 30) && idadeAnos < 2) {
      pesoIdeal = 4 + (idadeAnos * 4);
    } else if (idadeAnos >= 2 && idadeAnos <= 10) {
      pesoIdeal = (idadeAnos * 2) + 8;
    } else if (idadeAnos > 10 && idadeAnos < 18) {
      pesoIdeal = idadeAnos * 3;
    } else {
      if (sexo.toLowerCase() == 'masculino') {
        pesoIdeal = 50 + 0.91 * (alturaCm - 152.4);
      } else {
        pesoIdeal = 45.5 + 0.91 * (alturaCm - 152.4);
      }
    }

    if (pesoIdeal <= 0) return '-';

    double percentual = (pesoKg / pesoIdeal) * 100;

    return '${percentual.toStringAsFixed(1)} %';
  } catch (e) {
    return '-';
  }
}

String calcularPesoParaAltura(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    double pesoKg;
    double alturaCm;

    if (isImperial) {
      pesoKg = (double.tryParse(peso.replaceAll(',', '.')) ?? 0.0) * 0.453592;

      if (altura.length == 3 && altura.endsWith('10')) {
        final feet = int.tryParse(altura.substring(0, 1)) ?? 0;
        final inches = 10;
        final totalInches = (feet * 12) + inches;
        alturaCm = totalInches * 2.54;
      } else {
        String alt = altura
            .replaceAll("ft", "'")
            .replaceAll("in", "")
            .replaceAll("\"", "")
            .replaceAll("’", "'")
            .replaceAll(" ", "")
            .trim();

        int totalInches = 0;

        if (alt.contains("'")) {
          final partes = alt.split("'");
          final feet = int.tryParse(partes[0].trim()) ?? 0;
          final inches =
              partes.length > 1 ? int.tryParse(partes[1].trim()) ?? 0 : 0;
          totalInches = (feet * 12) + inches;
        } else {
          totalInches = int.tryParse(alt) ?? 0;
        }

        alturaCm = totalInches * 2.54;
      }
    } else {
      pesoKg = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
      alturaCm = double.tryParse(altura.replaceAll(',', '.')) ?? 0.0;
    }

    double idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? 0.0;

    if (pesoKg == 0.0 || alturaCm == 0.0 || idadeAnos == 0.0) {
      return '-';
    }

    double pesoIdeal;

    if (idadeAnos < (1 / 30)) {
      pesoIdeal = 3.5;
    } else if (idadeAnos >= (1 / 30) && idadeAnos < 2) {
      pesoIdeal = 4 + (idadeAnos * 4);
    } else if (idadeAnos >= 2 && idadeAnos <= 10) {
      pesoIdeal = (idadeAnos * 2) + 8;
    } else if (idadeAnos > 10 && idadeAnos < 18) {
      pesoIdeal = idadeAnos * 3;
    } else {
      if (sexo.toLowerCase() == 'masculino') {
        pesoIdeal = 50 + 0.91 * (alturaCm - 152.4);
      } else {
        pesoIdeal = 45.5 + 0.91 * (alturaCm - 152.4);
      }
    }

    if (pesoIdeal <= 0) return '-';

    double percentual = (pesoKg / pesoIdeal) * 100;

    return '${percentual.toStringAsFixed(1)} %';
  } catch (e) {
    return '-';
  }
}

String calcularPesoEsperado(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    double idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? 0.0;
    if (idadeAnos == 0.0) return '-';

    final masculino = sexo.toLowerCase() == 'masculino';
    double p50;

    if (idadeAnos < (1 / 30)) {
      p50 = masculino ? 3.5 : 3.4;
    } else if (idadeAnos < 2) {
      p50 = masculino ? 10.0 : 9.5;
    } else if (idadeAnos <= 10) {
      p50 = masculino ? (idadeAnos * 2) + 8 : (idadeAnos * 2) + 7;
    } else if (idadeAnos <= 18) {
      p50 = masculino ? idadeAnos * 3.0 : idadeAnos * 2.7;
    } else {
      p50 = masculino ? 70.0 : 60.0;
    }

    double p5 = p50 * 0.85;
    double p95 = p50 * 1.15;

    if (isImperial) {
      double p5Lb = p5 / 0.453592;
      double p95Lb = p95 / 0.453592;
      return '${p5Lb.toStringAsFixed(1)} lb - ${p95Lb.toStringAsFixed(1)} lb';
    } else {
      return '${p5.toStringAsFixed(1)} kg - ${p95.toStringAsFixed(1)} kg';
    }
  } catch (e) {
    return '-';
  }
}

String calcularAlturaEsperada(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    double idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? 0.0;
    if (idadeAnos == 0.0) return '-';

    final masculino = sexo.toLowerCase() == 'masculino';

    double alturaIdeal;

    if (idadeAnos < 2) {
      alturaIdeal = masculino ? 80 : 78;
    } else if (idadeAnos <= 10) {
      alturaIdeal = (idadeAnos * 6) + 77;
    } else if (idadeAnos <= 18) {
      alturaIdeal = masculino ? 170 : 160;
    } else {
      alturaIdeal = masculino ? 175 : 165;
    }

    double minAltura = alturaIdeal - 5;
    double maxAltura = alturaIdeal + 5;

    if (isImperial) {
      double minIn = minAltura / 2.54;
      double maxIn = maxAltura / 2.54;
      return '${minIn.toStringAsFixed(1)} in - ${maxIn.toStringAsFixed(1)} in';
    } else {
      return '${minAltura.toStringAsFixed(1)} cm - ${maxAltura.toStringAsFixed(1)} cm';
    }
  } catch (e) {
    return '-';
  }
}

String calcularFrequenciaCardiacaEsperada(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    // Conversão segura da idade
    double idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? 0.0;

    // Se quiser usar peso e altura futuramente:
    double? pesoKg;
    double? alturaCm;

    if (isImperial) {
      pesoKg = (double.tryParse(peso.replaceAll(',', '.')) ?? 0.0) * 0.453592;

      if (altura.length == 3 && altura.endsWith('10')) {
        final feet = int.tryParse(altura.substring(0, 1)) ?? 0;
        final inches = 10;
        final totalInches = (feet * 12) + inches;
        alturaCm = totalInches * 2.54;
      } else {
        String alt = altura
            .replaceAll("ft", "'")
            .replaceAll("in", "")
            .replaceAll("\"", "")
            .replaceAll("’", "'")
            .replaceAll(" ", "")
            .trim();

        int totalInches = 0;
        if (alt.contains("'")) {
          final partes = alt.split("'");
          final feet = int.tryParse(partes[0].trim()) ?? 0;
          final inches =
              partes.length > 1 ? int.tryParse(partes[1].trim()) ?? 0 : 0;
          totalInches = (feet * 12) + inches;
        } else {
          totalInches = int.tryParse(alt) ?? 0;
        }

        alturaCm = totalInches * 2.54;
      }
    } else {
      pesoKg = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
      alturaCm = double.tryParse(altura.replaceAll(',', '.')) ?? 0.0;
    }

    if (idadeAnos == 0.0) return '-';

    // Faixas de frequência cardíaca (bpm)
    if (idadeAnos < (1 / 12)) {
      return '110 - 160 bpm';
    } else if (idadeAnos < 1) {
      return '100 - 160 bpm';
    } else if (idadeAnos < 3) {
      return '90 - 150 bpm';
    } else if (idadeAnos < 6) {
      return '80 - 140 bpm';
    } else if (idadeAnos < 12) {
      return '75 - 120 bpm';
    } else {
      return '60 - 100 bpm';
    }
  } catch (e) {
    return '-';
  }
}

String calcularPressaoArterialEsperada(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    final idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? 0.0;
    if (idadeAnos == 0.0) return '-';

    // Conversão futura se quiser usar peso/altura:
    double? pesoKg;
    double? alturaCm;

    if (isImperial) {
      pesoKg = (double.tryParse(peso.replaceAll(',', '.')) ?? 0.0) * 0.453592;

      if (altura.length == 3 && altura.endsWith('10')) {
        final feet = int.tryParse(altura.substring(0, 1)) ?? 0;
        final inches = 10;
        final totalInches = (feet * 12) + inches;
        alturaCm = totalInches * 2.54;
      } else {
        String alt = altura
            .replaceAll("ft", "'")
            .replaceAll("in", "")
            .replaceAll("\"", "")
            .replaceAll("’", "'")
            .replaceAll(" ", "")
            .trim();

        int totalInches = 0;
        if (alt.contains("'")) {
          final partes = alt.split("'");
          final feet = int.tryParse(partes[0].trim()) ?? 0;
          final inches =
              partes.length > 1 ? int.tryParse(partes[1].trim()) ?? 0 : 0;
          totalInches = (feet * 12) + inches;
        } else {
          totalInches = int.tryParse(alt) ?? 0;
        }

        alturaCm = totalInches * 2.54;
      }
    } else {
      pesoKg = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
      alturaCm = double.tryParse(altura.replaceAll(',', '.')) ?? 0.0;
    }

    // Faixas por idade
    if (idadeAnos < (1 / 12)) {
      return '60–90 / 20–60 mmHg';
    } else if (idadeAnos < 1) {
      return '75–100 / 50–70 mmHg';
    } else if (idadeAnos < 3) {
      return '80–105 / 55–70 mmHg';
    } else if (idadeAnos < 6) {
      return '90–110 / 55–75 mmHg';
    } else if (idadeAnos < 12) {
      return '95–115 / 60–75 mmHg';
    } else {
      return '110–130 / 70–85 mmHg';
    }
  } catch (e) {
    return '-';
  }
}

String calcularVolumePlasmatico(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    double pesoKg;

    if (isImperial) {
      pesoKg = (double.tryParse(peso.replaceAll(',', '.')) ?? 0.0) * 0.453592;
    } else {
      pesoKg = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
    }

    if (pesoKg == 0.0) return '-';

    final masculino = sexo.toLowerCase().trim() == 'masculino';
    final fator = masculino ? 40 : 35;

    final volume = pesoKg * fator;

    return '${volume.toStringAsFixed(0)} ml';
  } catch (e) {
    return '-';
  }
}

String calcularVolumeDiarioInfusao(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
) {
  try {
    double pesoKg;

    if (isImperial) {
      pesoKg = (double.tryParse(peso.replaceAll(',', '.')) ?? 0.0) * 0.453592;
    } else {
      pesoKg = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
    }

    if (pesoKg == 0.0) return '-';

    double volumeTotal;

    if (pesoKg <= 10) {
      volumeTotal = pesoKg * 100;
    } else if (pesoKg <= 20) {
      volumeTotal = 1000 + ((pesoKg - 10) * 50);
    } else {
      volumeTotal = 1500 + ((pesoKg - 20) * 20);
    }

    return '${volumeTotal.toStringAsFixed(0)} ml/dia';
  } catch (e) {
    return '-';
  }
}

String calcularTempoReperfusaoCapilar(
  String peso,
  String altura,
  String idade,
  String sexo,
  String language,
) {
  final lang = language.toLowerCase().trim();

  if (lang == 'english') {
    return '1–2 sec';
  } else if (lang == 'espanõl' || lang == 'español') {
    return '1–2 seg';
  } else {
    return '1 seg – 2 seg';
  }
}

String calcularMascaraFacialEsperada(
  String peso,
  String altura,
  String idade,
  String sexo,
  String language,
) {
  final lang = language.toLowerCase().trim();
  final idadeAnos = double.tryParse(idade.replaceAll(',', '.')) ?? -1;

  if (idadeAnos < 0) return '-';

  String categoria;

  if (idadeAnos < 1) {
    categoria = {
          'português': 'RN (Recém-Nascido)',
          'english': 'Newborn (Neonate)',
          'espanõl': 'RN (Recién Nacido)',
          'español': 'RN (Recién Nacido)',
        }[lang] ??
        'RN (Recém-Nascido)';
  } else if (idadeAnos < 5) {
    categoria = {
          'português': 'Infantil Pequena',
          'english': 'Small Child',
          'espanõl': 'Niño Pequeño',
          'español': 'Niño Pequeño',
        }[lang] ??
        'Infantil Pequena';
  } else if (idadeAnos < 12) {
    categoria = {
          'português': 'Infantil Grande',
          'english': 'Large Child',
          'espanõl': 'Niño Grande',
          'español': 'Niño Grande',
        }[lang] ??
        'Infantil Grande';
  } else {
    categoria = {
          'português': 'Adulto',
          'english': 'Adult',
          'espanõl': 'Adulto',
          'español': 'Adulto',
        }[lang] ??
        'Adulto';
  }

  return categoria;
}

String calcularCanulaOrofaringeaEsperada(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  final lang = language.toLowerCase().trim();
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));

  if (idadeAnos == null) return '-';

  final tamanhosEmMm = [50, 60, 70, 80, 90];
  int tamanhoPrincipal = 0;

  if (idadeAnos < 1) {
    tamanhoPrincipal = 0;
  } else if (idadeAnos < 5) {
    tamanhoPrincipal = 1;
  } else if (idadeAnos < 10) {
    tamanhoPrincipal = 2;
  } else if (idadeAnos < 14) {
    tamanhoPrincipal = 3;
  } else {
    tamanhoPrincipal = 4;
  }

  int menor = math.max(0, tamanhoPrincipal - 1);
  int maior = math.min(tamanhosEmMm.length - 1, tamanhoPrincipal + 1);

  final conector = {
        'português': 'ou',
        'english': 'or',
        'espanõl': 'o',
        'español': 'o',
      }[lang] ??
      'ou';

  return '${tamanhosEmMm[menor]} mm $conector ${tamanhosEmMm[maior]} mm';
}

String calcularCanulaNasofaringeaEsperada(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  final lang = language.toLowerCase().trim();
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));
  if (idadeAnos == null) return '-';

  final conector = {
        'português': 'ou',
        'english': 'or',
        'espanõl': 'o',
        'español': 'o',
      }[lang] ??
      'ou';

  String resultado;

  if (idadeAnos < 1) {
    resultado = '3.5 mm $conector 4.0 mm';
  } else if (idadeAnos < 5) {
    resultado = '4.0 mm $conector 5.0 mm';
  } else if (idadeAnos < 10) {
    resultado = '5.0 mm $conector 6.0 mm';
  } else if (idadeAnos < 14) {
    resultado = '6.0 mm $conector 6.5 mm';
  } else {
    resultado = '6.5 mm $conector 7.0 mm';
  }

  return resultado;
}

String calcularCombituboEsperado(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  final lang = language.toLowerCase().trim();

  double? alturaCm;

  if (isImperial) {
    // Converter ft ou ft'in" para cm
    String alt = altura
        .replaceAll("ft", "'")
        .replaceAll("in", "")
        .replaceAll("\"", "")
        .replaceAll("’", "'")
        .replaceAll(" ", "")
        .trim();

    int totalInches = 0;

    if (alt.contains("'")) {
      final partes = alt.split("'");
      final feet = int.tryParse(partes[0]) ?? 0;
      final inches = partes.length > 1 ? int.tryParse(partes[1]) ?? 0 : 0;
      totalInches = (feet * 12) + inches;
    } else {
      totalInches = int.tryParse(alt) ?? 0;
    }

    alturaCm = totalInches * 2.54;
  } else {
    alturaCm = double.tryParse(altura.replaceAll(',', '.'));
  }

  if (alturaCm == null) return '-';

  if (alturaCm >= 168) {
    return {
          'português': 'Combitubo 41 Fr',
          'english': 'Combitube 41 Fr',
          'espanõl': 'Combitubo 41 Fr',
          'español': 'Combitubo 41 Fr',
        }[lang] ??
        'Combitubo 41 Fr';
  } else if (alturaCm >= 120) {
    return {
          'português': 'Combitubo 37 Fr',
          'english': 'Combitube 37 Fr',
          'espanõl': 'Combitubo 37 Fr',
          'español': 'Combitubo 37 Fr',
        }[lang] ??
        'Combitubo 37 Fr';
  } else {
    return {
          'português': 'Altura incompatível com uso de Combitubo',
          'english': 'Height incompatible with Combitube use',
          'espanõl': 'Altura incompatible con el uso del Combitubo',
          'español': 'Altura incompatible con el uso del Combitubo',
        }[lang] ??
        'Altura incompatível com uso de Combitubo';
  }
}

String calcularMascaraLaringeaEsperada(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  final lang = language.toLowerCase().trim();
  double? pesoKg = double.tryParse(peso.replaceAll(',', '.'));

  if (pesoKg == null) return '-';

  if (isImperial) {
    pesoKg = pesoKg * 0.453592;
  }

  String base;

  if (lang == 'english') {
    base = 'Laryngeal Mask #';
  } else if (lang == 'espanõl' || lang == 'español') {
    base = 'Máscara Laríngea nº ';
  } else {
    base = 'Máscara Laríngea nº ';
  }

  String numero;

  if (pesoKg < 5) {
    numero = '1';
  } else if (pesoKg <= 10) {
    numero = '1.5';
  } else if (pesoKg <= 20) {
    numero = '2';
  } else if (pesoKg <= 30) {
    numero = '2.5';
  } else if (pesoKg <= 50) {
    numero = '3';
  } else if (pesoKg <= 70) {
    numero = '4';
  } else if (pesoKg <= 100) {
    numero = '5';
  } else {
    numero = '6';
  }

  return '$base$numero';
}

String calcularLaringoscopioReto(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));

  if (idadeAnos == null) return '-';

  if (idadeAnos < 1) {
    return '0 - 1';
  } else if (idadeAnos < 5) {
    return '1 - 2';
  } else if (idadeAnos < 10) {
    return '2 - 3';
  } else {
    return '3 - 4';
  }
}

String calcularLaringoscopioCurvo(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));

  if (idadeAnos == null) return '-';

  if (idadeAnos < 1) {
    return '0 - 1';
  } else if (idadeAnos < 5) {
    return '1 - 2';
  } else if (idadeAnos < 10) {
    return '2 - 3';
  } else {
    return '3 - 4';
  }
}

String calcularTuboOrotraquealComCuff(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));
  if (idadeAnos == null) return '-';

  final lang = language.toLowerCase().trim();
  final sufixo = 'mm'; // universal para todos idiomas

  String resultado;

  if (idadeAnos >= 18) {
    final masculino = sexo.toLowerCase() == 'masculino';
    resultado =
        masculino ? '7.5 $sufixo - 8.0 $sufixo' : '7.0 $sufixo - 7.5 $sufixo';
  } else {
    double tubo = (idadeAnos / 4) + 3.5;
    double menor = double.parse((tubo - 0.25).toStringAsFixed(1));
    double maior = double.parse((tubo + 0.25).toStringAsFixed(1));
    resultado = '$menor $sufixo - $maior $sufixo';
  }

  return resultado;
}

String calcularTuboOrotraquealSemCuff(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));
  if (idadeAnos == null || idadeAnos >= 8) return '-';

  final sufixo = 'mm'; // padrão universal para tubos

  double tubo = (idadeAnos / 4) + 4.0;
  double menor = double.parse((tubo - 0.25).toStringAsFixed(1));
  double maior = double.parse((tubo + 0.25).toStringAsFixed(1));

  return '$menor $sufixo - $maior $sufixo';
}

String calcularAlturaFixacaoTubo(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));
  if (idadeAnos == null) return '-';

  String unidade = 'cm'; // universal

  if (idadeAnos < 1) {
    return '8 - 9 $unidade';
  } else if (idadeAnos < 2) {
    return '10 - 11 $unidade';
  } else if (idadeAnos < 4) {
    return '12 - 13 $unidade';
  } else if (idadeAnos < 6) {
    return '14 - 15 $unidade';
  } else if (idadeAnos < 10) {
    return '16 - 17 $unidade';
  } else if (idadeAnos < 14) {
    return '18 - 20 $unidade';
  } else {
    return '20 - 24 $unidade';
  }
}

String calcularCanulaTraqueostomia(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));
  if (idadeAnos == null) return '-';

  String unidade = 'mm'; // universal

  if (idadeAnos < 1) {
    return '3.0 $unidade';
  } else if (idadeAnos < 5) {
    return '3.5 $unidade - 4.5 $unidade';
  } else if (idadeAnos < 10) {
    return '4.5 $unidade - 6.0 $unidade';
  } else if (idadeAnos < 14) {
    return '6.0 $unidade - 7.0 $unidade';
  } else {
    return '7.0 $unidade - 9.0 $unidade';
  }
}

String calcularFrequenciaRespiratoria(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade.replaceAll(',', '.'));
  if (idadeAnos == null) return '-';

  final lang = language.toLowerCase().trim();
  final unidade = (lang == 'português') ? 'irpm' : 'rpm';

  if (idadeAnos < 1) {
    return '30 - 60 $unidade';
  } else if (idadeAnos < 3) {
    return '24 - 40 $unidade';
  } else if (idadeAnos < 6) {
    return '22 - 34 $unidade';
  } else if (idadeAnos < 12) {
    return '18 - 30 $unidade';
  } else {
    return '12 - 20 $unidade';
  }
}

String calcularVolumeCorrente(
  String altura,
  bool isImperial,
  String language,
) {
  altura = altura.trim(); // remove espaços

  double? alturaNum = double.tryParse(altura.replaceAll(',', '.'));
  if (alturaNum == null) return '-';

  double alturaM = isImperial ? alturaNum * 0.0254 : alturaNum;

  // Conversão de cm para metros se necessário
  if (alturaM > 3) {
    alturaM = alturaM / 100;
  }

  if (alturaM <= 0) return '-';

  double imcEsperado = 23;
  double pesoPredito = imcEsperado * math.pow(alturaM, 2).toDouble();

  int vcMin = (pesoPredito * 6).round();
  int vcMax = (pesoPredito * 8).round();

  return '$vcMin ml - $vcMax ml';
}

String calcularVolumePorMinuto(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? pesoNum = double.tryParse(peso.replaceAll(',', '.'));
  if (pesoNum == null) return '-';

  double pesoKg = isImperial ? pesoNum * 0.453592 : pesoNum;

  int vmMin = (pesoKg * 6 * 12).round(); // 12 incursões por minuto (baixa)
  int vmMax = (pesoKg * 8 * 20).round(); // 20 incursões por minuto (alta)

  return '$vmMin ml/min - $vmMax ml/min';
}

String calcularRelacaoIE(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  // Retorno padrão clínico universal
  return '1:2';
}

String calcularEspacoMorto(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? pesoNum = double.tryParse(peso.replaceAll(',', '.'));
  if (pesoNum == null) return '-';

  double pesoKg = isImperial ? pesoNum * 0.453592 : pesoNum;

  int espacoMorto = (pesoKg * 2.2).round();

  return '$espacoMorto ml';
}

String calcularPressaoDePico(
  String peso,
  String altura,
  String idade,
  String sexo,
) {
  return '18 - 25 cmH₂O';
}

String calcularPEEPSugerida(
  String peso,
  String altura,
  String idade,
  String sexo,
) {
  return '5 cmH₂O - 10 cmH₂O';
}

String calcularSondaVesicalDemora(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade);
  if (idadeAnos == null) return '-';

  String sexoNorm = sexo.toLowerCase();

  if (idadeAnos < 1) {
    return '6 Fr - 8 Fr';
  } else if (idadeAnos < 3) {
    return '8 Fr - 10 Fr';
  } else if (idadeAnos < 6) {
    return '10 Fr - 12 Fr';
  } else if (idadeAnos < 12) {
    return '12 Fr - 14 Fr';
  } else if (idadeAnos < 18) {
    return sexoNorm == 'masculino' ? '14 Fr - 16 Fr' : '12 Fr - 14 Fr';
  } else {
    return sexoNorm == 'masculino' ? '16 Fr - 18 Fr' : '14 Fr - 16 Fr';
  }
}

String calcularDrenoKehr(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade);
  if (idadeAnos == null) return '-';

  if (idadeAnos < 12) {
    return '6 Fr - 10 Fr';
  } else if (idadeAnos < 18) {
    return '8 Fr - 12 Fr';
  } else {
    return '10 Fr - 14 Fr';
  }
}

String calcularSondaNasogastrica(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade);
  if (idadeAnos == null) return '-';

  if (idadeAnos < 1) {
    return '6 Fr - 8 Fr';
  } else if (idadeAnos < 3) {
    return '8 Fr - 10 Fr';
  } else if (idadeAnos < 6) {
    return '10 Fr - 12 Fr';
  } else if (idadeAnos < 12) {
    return '12 Fr - 14 Fr';
  } else if (idadeAnos < 18) {
    return '14 Fr - 16 Fr';
  } else {
    return '14 Fr - 18 Fr';
  }
}

String calcularFixacaoSNG(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade);
  if (idadeAnos == null) return '-';

  if (idadeAnos < 1) {
    return '16 cm - 18 cm';
  } else if (idadeAnos < 3) {
    return '22 cm - 26 cm';
  } else if (idadeAnos < 5) {
    return '26 cm - 30 cm';
  } else if (idadeAnos < 12) {
    return '30 cm - 40 cm';
  } else {
    return '50 cm - 60 cm';
  }
}

String calcularSondaNasoenterica(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade);
  if (idadeAnos == null) return '-';

  if (idadeAnos < 1) {
    return '6 Fr - 8 Fr';
  } else if (idadeAnos < 6) {
    return '8 Fr - 10 Fr';
  } else if (idadeAnos < 12) {
    return '10 Fr - 12 Fr';
  } else {
    return '12 Fr - 14 Fr';
  }
}

String calcularFixacaoSNE(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade);
  if (idadeAnos == null) return '-';

  if (idadeAnos < 1) {
    return '20 cm - 30 cm';
  } else if (idadeAnos < 5) {
    return '40 cm - 60 cm';
  } else if (idadeAnos < 12) {
    return '60 cm - 80 cm';
  } else {
    return '100 cm - 120 cm';
  }
}

String calcularAcessoCentral(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade);
  if (idadeAnos == null) return '-';

  if (idadeAnos < 1) {
    return '3.5 Fr - 5 Fr (umbilical)';
  } else if (idadeAnos < 5) {
    return '4 Fr - 5 Fr ou 22G - 20G';
  } else if (idadeAnos < 12) {
    return '5 Fr - 6 Fr ou 20G - 18G';
  } else {
    return '7 Fr - 9 Fr ou 16G - 14G';
  }
}

String calcularCateterShilley(
  String peso,
  String altura,
  String idade,
  String sexo,
  bool isImperial,
  String language,
) {
  double? idadeAnos = double.tryParse(idade);
  if (idadeAnos == null) return '-';

  if (idadeAnos < 12) {
    return '6.5 Fr - 8.5 Fr';
  } else if (idadeAnos < 18) {
    return '10 Fr - 11.5 Fr';
  } else {
    return '12 Fr - 14 Fr';
  }
}

String calcularDoseTotalMg(
  double doseMgKg,
  String pesoKgStr,
  double concentracaoMgMl,
) {
  double pesoKg = double.tryParse(pesoKgStr.replaceAll(',', '.')) ?? 0.0;
  double doseTotalMg = doseMgKg * pesoKg;
  double volumeTotalMl = doseTotalMg / concentracaoMgMl;

  final doseFormatada = doseTotalMg.toStringAsFixed(2).replaceAll('.', ',');
  final volumeFormatada = volumeTotalMl.toStringAsFixed(2).replaceAll('.', ',');

  return '$doseFormatada mg / $volumeFormatada mL';
}

String calcularDoseMg(
  String pesoKg,
  double doseMgKg,
) {
  final peso = double.tryParse(pesoKg.replaceAll(',', '.')) ?? 0.0;
  final doseTotalMg = doseMgKg * peso;
  final formatado = NumberFormat("0.0#").format(doseTotalMg);
  return "$formatado mg";
}

String calcularVolumeMlComPeso(
  double doseMgKg,
  double concentracaoMgMl,
  String pesoKg,
) {
  final peso = double.tryParse(pesoKg.replaceAll(',', '.')) ?? 0;
  if (peso == 0 || doseMgKg == 0 || concentracaoMgMl == 0) return '0.0 mL';

  final doseTotal = peso * doseMgKg;
  final volume = doseTotal / concentracaoMgMl;

  final volumeFormatado = NumberFormat('0.0#').format(volume);

  return '$volumeFormatado mL';
}

String? limparTelefone(String telefoneComMascara) {
  final regex = RegExp(r'\D');

  // Substitui tudo que não for número por uma string vazia ""
  return telefoneComMascara.replaceAll(regex, '');
}

String? calculateVolumeOrFlow(
  double dose,
  String weightString,
  double concentration,
  bool isLbs,
  String unidade,
) {
  if (dose == null || dose <= 0) return "Selecione a dose";
  if (concentration == null || concentration <= 0) return "Erro na conc.";
  if (weightString == null || weightString.isEmpty) return "Digite o peso";
  if (unidade == null) return "--";

  // --- 2. Tratamento do Peso ---
  String cleanWeight = weightString.replaceAll(',', '.');
  double? weight = double.tryParse(cleanWeight);
  if (weight == null || weight <= 0) return "Peso inválido";

  if (isLbs) {
    weight = weight / 2.20462; // Converte lbs para kg
  }

  // --- 3. Inteligência da Unidade (O Pulo do Gato) ---

  // Verifica se a dose usa o peso do paciente (tem "kg" na unidade?)
  // Ex: "g/h" não usa peso, mas "mg/kg/h" usa.
  bool usaPeso = unidade.contains("kg");

  // Verifica se é baseada em tempo (Infusão) ou Bolus
  bool temMinutos = unidade.contains("min"); // Ex: mcg/kg/min
  bool temHoras = unidade.contains("/h"); // Ex: mg/kg/h
  bool ehInfusao = temMinutos || temHoras;

  // --- 4. O Cálculo Matemático ---

  double doseTotal;

  // Se a unidade tem "kg" (ex: mg/kg), multiplicamos pelo peso.
  // Se for apenas "g/h" ou "UI/min", usamos a dose pura do slider.
  if (usaPeso) {
    doseTotal = dose * weight;
  } else {
    doseTotal = dose;
  }

  // Calcula o volume inicial (baseado na concentração)
  double resultado = doseTotal / concentration;

  // Ajuste de Tempo para Bomba de Infusão (mL/h)
  if (temMinutos) {
    // Se está em minutos, multiplica por 60 para virar Horas (bomba)
    resultado = resultado * 60;
  }
  // Se for "/h", o resultado já está em mL/h, não faz nada.
  // Se não tiver tempo (Bolus), o resultado é o volume final em mL.

  // --- 5. Formatação do Texto ---

  String valorFormatado = resultado.toStringAsFixed(1);

  if (ehInfusao) {
    return "Vazão: $valorFormatado mL/h";
  } else {
    return "Volume: $valorFormatado mL";
  }
}

String? calcularResultadoMestre(
  List<dynamic> listaItens,
  double sliderValue,
  String pesoString,
  String nomeOpcaoSelecionada,
  String? unidadePeso,
) {
// 1. Validações
  print('🔍 CALCULO: Recebeu ${listaItens.length} itens');
  print(
      '🔍 CALCULO: Primeiro item tipo: ${listaItens.isNotEmpty ? listaItens[0].runtimeType : "vazio"}');
  print(
      '🔍 CALCULO: Primeiro item: ${listaItens.isNotEmpty ? listaItens[0] : "vazio"}');
  print('🔍 CALCULO: Dropdown selecionado: $nomeOpcaoSelecionada');
  print('🔍 CALCULO: Slider value: $sliderValue');

  if (listaItens.isEmpty) return "Carregando...";
  if (pesoString.isEmpty) return "Digite o peso";
  if (sliderValue <= 0) return "Ajuste a dose";

  double? peso = double.tryParse(pesoString.replaceAll(',', '.'));
  if (peso == null || peso <= 0) return "Peso inválido";

  // 2. DEFINIR CONCENTRAÇÃO
  double concentracao = 0.0;
  String? unidadeConcentracao; // Armazena a unidade da concentração (mg, mcg, mEq)

  // ESTRATÉGIA A: Tenta pegar número direto (Se o dropdown enviar "0.2")
  if (nomeOpcaoSelecionada != null) {
    double? v = double.tryParse(nomeOpcaoSelecionada.replaceAll(',', '.'));
    if (v != null && v > 0) concentracao = v;
  }

  // ESTRATÉGIA B: Leitura Inteligente do Texto (EXTRAÇÃO POR REGEX) 🚨 NOVO!
  // Se o texto for "100mEq... (0,2mEq/mL)", nós extraímos o "0,2".
  if (concentracao == 0 && nomeOpcaoSelecionada != null) {
    // Procura um padrão de número logo antes de "mEq/mL" ou "mg/mL" ou "mcg/mL"
    // Ex: (0,2mEq/mL) -> captura 0,2 e mEq
    RegExp regExp = RegExp(r'\((\d+[.,]?\d*)\s*(mEq|mg|mcg)/mL\)');
    Match? match = regExp.firstMatch(nomeOpcaoSelecionada);

    if (match != null) {
      String numeroString = match.group(1)!.replaceAll(',', '.');
      unidadeConcentracao = match.group(2); // Captura a unidade (mg, mcg, mEq)
      double? extraido = double.tryParse(numeroString);
      if (extraido != null && extraido > 0) {
        concentracao = extraido;
        print('🔍 CALCULO: Concentração extraída: $concentracao $unidadeConcentracao/mL');
      }
    }
  }

  // ESTRATÉGIA C: Varredura no Banco (Fallback)
  String unidadeEncontrada = "";
  bool unidadeDefinida = false; // Flag para parar de sobrescrever

  for (var item in listaItens) {
    Map<String, dynamic>? dados;
    if (item is Map<String, dynamic>) {
      print('🔍 CALCULO: Item é Map, keys: ${item.keys}');
      if (item.containsKey('dados_calculo')) {
        dados = item['dados_calculo'];
        print('🔍 CALCULO: dados_calculo tipo: ${dados.runtimeType}');
        print('🔍 CALCULO: dados_calculo conteúdo: $dados');
      } else if (item.containsKey('unidade')) {
        dados = item;
        print('🔍 CALCULO: Usando item direto (tem unidade)');
      }
    } else {
      print('⚠️ CALCULO: Item NÃO é Map, é ${item.runtimeType}');
    }

    if (dados == null) {
      print('⚠️ CALCULO: dados é null, pulando item');
      continue;
    }

    // Tenta achar no mapa do JSON se a regex falhou
    if (concentracao == 0 &&
        nomeOpcaoSelecionada != null &&
        dados['opcoesConcentracoes'] != null) {
      var mapa = dados['opcoesConcentracoes'];
      print('🔍 CALCULO: opcoesConcentracoes encontrado: $mapa');
      print('🔍 CALCULO: Chaves disponíveis: ${mapa.keys.toList()}');
      print('🔍 CALCULO: Procurando por: "$nomeOpcaoSelecionada"');

      if (mapa[nomeOpcaoSelecionada] != null) {
        var val = mapa[nomeOpcaoSelecionada];
        print('✅ CALCULO: Encontrou valor para "$nomeOpcaoSelecionada": $val');
        if (val is num)
          concentracao = val.toDouble();
        else if (val is String) concentracao = double.tryParse(val) ?? 0.0;
        print('✅ CALCULO: Concentração definida: $concentracao');
      } else {
        print('⚠️ CALCULO: "$nomeOpcaoSelecionada" não encontrado no mapa');
        print('⚠️ CALCULO: Tentando buscar com trim...');
        // Tenta com trim e comparação case-insensitive
        for (var key in mapa.keys) {
          if (key.toString().trim() == nomeOpcaoSelecionada.trim()) {
            var val = mapa[key];
            print('✅ CALCULO: Encontrou com trim! Valor: $val');
            if (val is num)
              concentracao = val.toDouble();
            else if (val is String) concentracao = double.tryParse(val) ?? 0.0;
            break;
          }
        }
      }
    } else {
      if (concentracao == 0)
        print('⚠️ CALCULO: Não tem opcoesConcentracoes ou já tem concentração');
    }

    // Último recurso: Concentração padrão
    if (concentracao == 0 && dados['concentracao'] != null) {
      var c = dados['concentracao'];
      if (c is num) concentracao = c.toDouble();
    }

    // Busca Unidade - APENAS do item que tem slideInput ou opcoesConcentracoes
    if (!unidadeDefinida && dados['unidade'] != null) {
      // Verifica se este item é o item principal (tem slideInput ou opcoesConcentracoes)
      bool isItemPrincipal = dados.containsKey('slideInput') ||
          dados.containsKey('opcoesConcentracoes');

      String u = dados['unidade'].toString();
      print(
          '🔍 CALCULO: Unidade encontrada: "$u", atual: "$unidadeEncontrada", isPrincipal: $isItemPrincipal');

      if (isItemPrincipal) {
        // Se é o item principal, usa a unidade dele e marca como definida
        unidadeEncontrada = u;
        unidadeDefinida = true;
        print('✅ CALCULO: Unidade PRINCIPAL definida: "$unidadeEncontrada"');
      } else if (unidadeEncontrada.isEmpty &&
          (u.contains("min") || u.contains("/h"))) {
        // Fallback: se ainda não tem unidade e encontrou uma com min/h
        unidadeEncontrada = u;
        print('⚠️ CALCULO: Unidade fallback definida: "$unidadeEncontrada"');
      }
    }
  }

  if (concentracao == 0) return "Selecione a diluição";
  if (unidadeEncontrada.isEmpty) unidadeEncontrada = "mg/kg";

  // 3. CÁLCULO
  double doseTotal = sliderValue;
  if (unidadeEncontrada.contains("kg")) {
    doseTotal = sliderValue * peso;
  }

  // 4. CONVERSÃO DE UNIDADES - CRÍTICO!
  // Se a dose está em mcg mas a concentração está em mg, precisa converter
  // 1 mg = 1000 mcg
  double concentracaoConvertida = concentracao;
  
  // Detecta a unidade da dose (mcg, mg, mEq)
  bool doseEmMcg = unidadeEncontrada.toLowerCase().contains('mcg');
  bool doseEmMg = unidadeEncontrada.toLowerCase().contains('mg') && !doseEmMcg;
  bool doseEmMeq = unidadeEncontrada.toLowerCase().contains('meq');
  
  // Detecta a unidade da concentração
  bool concEmMcg = (unidadeConcentracao != null && unidadeConcentracao!.toLowerCase() == 'mcg');
  bool concEmMg = (unidadeConcentracao != null && unidadeConcentracao!.toLowerCase() == 'mg');
  bool concEmMeq = (unidadeConcentracao != null && unidadeConcentracao!.toLowerCase() == 'meq');
  
  // Se a dose está em mcg mas a concentração está em mg/mL, converte concentração para mcg/mL
  if (doseEmMcg && concEmMg) {
    concentracaoConvertida = concentracao * 1000; // mg/mL -> mcg/mL
    print('🔍 CALCULO: Convertendo concentração: $concentracao mg/mL = $concentracaoConvertida mcg/mL');
  }
  // Se a dose está em mg mas a concentração está em mcg/mL, converte concentração para mg/mL
  else if (doseEmMg && concEmMcg) {
    concentracaoConvertida = concentracao / 1000; // mcg/mL -> mg/mL
    print('🔍 CALCULO: Convertendo concentração: $concentracao mcg/mL = $concentracaoConvertida mg/mL');
  }
  // Se não detectou unidade da concentração, tenta inferir do texto do dropdown
  else if (unidadeConcentracao == null && nomeOpcaoSelecionada != null) {
    // Tenta detectar se o dropdown menciona mg ou mcg
    String dropdownLower = nomeOpcaoSelecionada.toLowerCase();
    if (doseEmMcg && (dropdownLower.contains('mg/ml') || dropdownLower.contains('mg/100ml'))) {
      // Dose em mcg, mas dropdown mostra mg/mL -> converte
      concentracaoConvertida = concentracao * 1000;
      print('🔍 CALCULO: Inferindo conversão: dose em mcg, dropdown em mg -> $concentracao mg/mL = $concentracaoConvertida mcg/mL');
    }
  }

  double resultado = doseTotal / concentracaoConvertida;

  // 5. AJUSTES FINAIS
  if (unidadeEncontrada.contains("min")) {
    resultado = resultado * 60;
  }

  // Correção de Escala (para Bicarbonato/Sulfato com erro de cadastro antigo)
  // REMOVIDO - não é mais necessário com a conversão correta de unidades

  String formatado = resultado.toStringAsFixed(1);

  print(
      '🎯 CALCULO FINAL: concentracao=$concentracao, doseTotal=$doseTotal, resultado=$resultado, unidade=$unidadeEncontrada');

  if (unidadeEncontrada.contains("min") || unidadeEncontrada.contains("/h")) {
    print('✅ RETORNO: Vazão: $formatado mL/h');
    return "Vazão: $formatado mL/h";
  } else {
    print('✅ RETORNO: Volume: $formatado mL');
    return "Volume: $formatado mL";
  }
}

double getSliderParam(
  List<dynamic> listaItens,
  String? param,
) {
// 1. Segurança se a lista vier vazia
  if (listaItens.isEmpty) {
    if (param == "doseMax") return 1.0;
    return 0.0;
  }

  // 2. Varredura Inteligente
  for (var item in listaItens) {
    Map<String, dynamic>? dados;

    // Verifica se o item é um Mapa válido
    if (item is Map<String, dynamic>) {
      // CASO A: Você mandou a LINHA do banco (que contém 'dados_calculo')
      if (item.containsKey('dados_calculo') && item['dados_calculo'] != null) {
        dados = item['dados_calculo'];
      }
      // CASO B: Você mandou o JSON DIRETO (O que você fez na imagem!)
      else if (item.containsKey('slideInput') || item.containsKey('doseMax')) {
        dados = item;
      }
    }

    // Se achamos dados válidos, vamos processar
    if (dados != null) {
      // Verifica se é a linha do Slider
      bool isSlider = dados['slideInput'] == true ||
          dados['slideInput'].toString().toLowerCase() == 'true';

      if (isSlider) {
        // Tenta pegar o valor (doseMin ou doseMax)
        if (dados[param] != null) {
          var valor = dados[param];

          // --- CORREÇÃO DO ERRO VERMELHO (Int vs Double) ---
          if (valor is num) {
            return valor.toDouble(); // Converte 20 para 20.0 automaticamente
          }
          if (valor is String) {
            return double.tryParse(valor.replaceAll(',', '.')) ?? 0.0;
          }
        }
      }
    }
  }

  // 3. Valores padrão se não achar nada
  if (param == "doseMax") return 1.0;
  return 0.0;
}

List<String> getDropdownLabels(List<dynamic> listaItens) {
  for (var item in listaItens) {
    // Como você já mapeou para 'dados_calculo', o 'item' JÁ É o JSON.
    // Não precisamos procurar 'dados_calculo' dentro dele.

    if (item != null && item is Map) {
      if (item['opcoesConcentracoes'] != null) {
        Map<String, dynamic> opcoes = item['opcoesConcentracoes'];
        return opcoes.keys.toList();
      }
    }
  }

  return [];
}

List<String> getDropdownValues(List<dynamic> listaItens) {
  for (var item in listaItens) {
    // Mesma lógica: O item já é o JSON direto
    if (item != null && item is Map) {
      if (item['opcoesConcentracoes'] != null) {
        Map<String, dynamic> opcoes = item['opcoesConcentracoes'];
        return opcoes.values.map((v) => v.toString()).toList();
      }
    }
  }

  return [];
}
