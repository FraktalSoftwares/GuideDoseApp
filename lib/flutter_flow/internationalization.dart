import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['pt', 'en', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? ptText = '',
    String? enText = '',
    String? esText = '',
  }) =>
      [ptText, enText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // recepcao
  {
    'rantp8qz': {
      'pt': 'Boas-vindas!',
      'en': 'Welcome!',
      'es': '¡Bienvenido!',
    },
    'qefl46v7': {
      'pt': 'Como deseja prosseguir?',
      'en': 'How would you like to proceed?',
      'es': '¿Cómo desea proceder?',
    },
    'uxadt7uj': {
      'pt': 'Cadastrar uma Conta',
      'en': 'Register an Account',
      'es': 'Crea una cuenta',
    },
    'qph342gp': {
      'pt': 'Não leva mais que 2 minutos!',
      'en': 'It takes no more than 2 minutes!',
      'es': '¡No te llevará más de 2 minutos!',
    },
    'sxrobz8k': {
      'pt': 'Já sou cadastrado',
      'en': 'I\'m already registered.',
      'es': 'Ya estoy registrado.',
    },
    'woa5xv0a': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // cadastro
  {
    '3fo6hf9b': {
      'pt': 'Cadastro',
      'en': 'Register',
      'es': 'Registro',
    },
    'ag33gstr': {
      'pt': 'E-mail ou telefone',
      'en': 'Email or phone',
      'es': 'Correo electrónico o teléfono',
    },
    'ejz08m2s': {
      'pt': 'Senha',
      'en': 'Password',
      'es': 'Contraseña',
    },
    'c0gq54x3': {
      'pt': 'Ao criar uma conta, você concorda com os ',
      'en': 'By creating an account, you agree to the',
      'es': 'Al crear una cuenta, aceptas los términos y condiciones.',
    },
    'f3ilpdmg': {
      'pt': 'Termos de Uso ',
      'en': 'Terms of Use',
      'es': 'Condiciones de uso',
    },
    '5pnkwhxb': {
      'pt': ' e ',
      'en': 'and',
      'es': 'y',
    },
    'tljoyeex': {
      'pt': 'Política de Privacidade',
      'en': 'Privacy Policy',
      'es': 'política de privacidad',
    },
    'j72taus7': {
      'pt': 'Finalizar Cadastro',
      'en': 'Complete Registration',
      'es': 'Completar el registro',
    },
    'pqvlqv8i': {
      'pt': 'Já é cadastrado?',
      'en': 'Are you already registered?',
      'es': '¿Ya estás registrado?',
    },
    '1g6xnnpp': {
      'pt': 'Acessar minha Conta',
      'en': 'Access my Account',
      'es': 'Acceder a mi cuenta',
    },
    '9bzvwarv': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // login
  {
    'u1qd1o1b': {
      'pt': 'Entrar',
      'en': 'To enter',
      'es': 'Para entrar',
    },
    '4z0ytdub': {
      'pt': 'E-mail ou telefone',
      'en': 'Email or phone',
      'es': 'Correo electrónico o teléfono',
    },
    'oswxbxaj': {
      'pt': 'Senha',
      'en': 'Password',
      'es': 'Contraseña',
    },
    'c7d5bpqx': {
      'pt': 'Ao entrar, você concorda com os ',
      'en': 'By entering, you agree to the',
      'es': 'Al ingresar, aceptas los términos y condiciones.',
    },
    'dcfgpe87': {
      'pt': 'Termos de Uso ',
      'en': 'Terms of Use',
      'es': 'Condiciones de uso',
    },
    'wrha06yt': {
      'pt': ' e ',
      'en': 'and',
      'es': 'y',
    },
    '23lduxqh': {
      'pt': 'Política de Privacidade',
      'en': 'Privacy Policy',
      'es': 'política de privacidad',
    },
    'rkojeo3i': {
      'pt': 'Acessar minha Conta',
      'en': 'Access my Account',
      'es': 'Acceder a mi cuenta',
    },
    'xk0e8pz9': {
      'pt': 'Senha ou e-mail incorretos',
      'en': 'Incorrect password or email address.',
      'es': 'Contraseña o dirección de correo electrónico incorrectas.',
    },
    '9u8i3v84': {
      'pt': 'Esqueci minha senha',
      'en': 'I forgot my password.',
      'es': 'Olvidé mi contraseña.',
    },
    'asjegl85': {
      'pt': 'Senha is required',
      'en': 'Password is required.',
      'es': 'Se requiere contraseña.',
    },
    'hkrtoupe': {
      'pt': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'ledsqs84': {
      'pt': 'E-mail ou telefone is required',
      'en': 'Email or phone number is required.',
      'es': 'Se requiere correo electrónico o número de teléfono.',
    },
    'f7oca6yw': {
      'pt': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    '7fczdclr': {
      'pt': 'Ainda não possui conta?',
      'en': 'Don\'t have an account yet?',
      'es': '¿Aún no tienes una cuenta?',
    },
    '3zwkvmce': {
      'pt': 'Cadastrar uma Conta',
      'en': 'Register an Account',
      'es': 'Crea una cuenta',
    },
    'hlta9hpe': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // redefinicao
  {
    '8e2oel3t': {
      'pt': 'Problemas para entrar?',
      'en': 'Having trouble logging in?',
      'es': '¿Tienes problemas para iniciar sesión?',
    },
    'pdy3hkpq': {
      'pt':
          'Insira o seu e-mail ou telefone cadastrado e enviaremos um código para que você possa redefinir a sua senha.',
      'en':
          'Enter your registered email or phone number and we will send you a code so you can reset your password.',
      'es':
          'Introduce tu correo electrónico o número de teléfono registrado y te enviaremos un código para que puedas restablecer tu contraseña.',
    },
    'o9tpyrsy': {
      'pt': 'E-mail',
      'en': 'E-mail',
      'es': 'Correo electrónico',
    },
    'p4ppxwha': {
      'pt': 'Enviar Link',
      'en': 'Send Link',
      'es': 'Enviar enlace',
    },
    'hozdfpmi': {
      'pt': 'Erro no envio do e-mail.',
      'en': 'Error sending email.',
      'es': 'Error al enviar el correo electrónico.',
    },
    'vg9n9kic': {
      'pt': 'Informe o código',
      'en': 'Enter the code.',
      'es': 'Introduce el código.',
    },
    'x9dj3yof': {
      'pt':
          'Insira o código de autenticação para avançar para a próxima etapa.',
      'en': 'Enter the authentication code to proceed to the next step.',
      'es':
          'Introduce el código de autenticación para pasar al siguiente paso.',
    },
    '389jt0vu': {
      'pt': 'Ex.: 06930',
      'en': 'Ex.: 06930',
      'es': 'Ej.: 06930',
    },
    'imw92wjl': {
      'pt': 'Verificar',
      'en': 'To check',
      'es': 'Para comprobar',
    },
    'kk3j64lh': {
      'pt': 'Ainda não possui conta?',
      'en': 'Don\'t have an account yet?',
      'es': '¿Aún no tienes una cuenta?',
    },
    'eipuueff': {
      'pt': 'Cadastrar uma Conta',
      'en': 'Register an Account',
      'es': 'Crea una cuenta',
    },
    'meckm3hd': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // resetPassword
  {
    'oopf122t': {
      'pt': 'Alterar senha',
      'en': 'Change password',
      'es': 'Cambiar la contraseña',
    },
    'tx3uryvu': {
      'pt': 'Informe uma nova senha',
      'en': 'Enter a new password.',
      'es': 'Introduce una nueva contraseña.',
    },
    'q9klq1o7': {
      'pt': 'Informações faltando!',
      'en': 'Information is missing!',
      'es': '¡Falta información!',
    },
    'rgnwgh8k': {
      'pt':
          '- Deve conter pelo menos um caractere especial \n- Deve incluir pelo menos uma letra maiúscula\n- Deve incluir pelo menos uma letra minúscula\n- Deve conter pelo menos um número\n- Deve conter no mínimo 8 caracteres',
      'en':
          '- Must contain at least one special character\n\n- Must include at least one uppercase letter\n- Must include at least one lowercase letter\n- Must contain at least one number\n- Must contain at least 8 characters',
      'es':
          '- Debe contener al menos un carácter especial\n\n- Debe incluir al menos una letra mayúscula\n- Debe incluir al menos una letra minúscula\n- Debe contener al menos un número\n- Debe contener al menos 8 caracteres',
    },
    'ae26ahd4': {
      'pt': 'Confirme sua senha',
      'en': 'Confirm your password.',
      'es': 'Confirma tu contraseña.',
    },
    'sgkploma': {
      'pt': 'Informações faltando!',
      'en': 'Information is missing!',
      'es': '¡Falta información!',
    },
    'q1muyb0c': {
      'pt': 'Senha is required',
      'en': 'Password is required.',
      'es': 'Se requiere contraseña.',
    },
    '0sxh6nef': {
      'pt': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    '4xzu8lf4': {
      'pt': 'E-mail ou telefone is required',
      'en': 'Email or phone number is required.',
      'es': 'Se requiere correo electrónico o número de teléfono.',
    },
    'vnpd8pen': {
      'pt': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'yx6qrpc6': {
      'pt': 'Confirmar Senha',
      'en': 'Confirm Password',
      'es': 'confirmar Contraseña',
    },
    'i2bg36vf': {
      'pt': 'Erro ao redefinir sua senha ou código expirado.',
      'en': 'Error resetting your password or expired code.',
      'es': 'Error al restablecer tu contraseña o código caducado.',
    },
    'tdx8t00b': {
      'pt': 'Sua senha foi alterada com sucesso!',
      'en': 'Error resetting your password or expired code.',
      'es': 'Error al restablecer tu contraseña o código caducado.',
    },
    'xp046tb3': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // painel
  {
    'nti91vts': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // p_checkout
  {
    'o0i8y934': {
      'pt': 'Voltar',
      'en': 'To go back',
      'es': 'Para regresar',
    },
    '5rqtvy31': {
      'pt': 'Com MC Guidedose você tem:',
      'en': 'With MC Guidedose you get:',
      'es': 'Con MC Guidedose obtienes:',
    },
    'gj2ghrck': {
      'pt': 'Calculadora de medicamentos',
      'en': 'Medication calculator',
      'es': 'Calculadora de medicamentos',
    },
    'g8bicziz': {
      'pt': 'Parâmetros fisiológicos',
      'en': 'Physiological parameters',
      'es': 'Parámetros fisiológicos',
    },
    'guf1r561': {
      'pt': 'Doses de indução',
      'en': 'Induction doses',
      'es': 'Dosis de inducción',
    },
    'p3y10ire': {
      'pt': 'Planos Disponíveis',
      'en': 'Available Plans',
      'es': 'Planes disponibles',
    },
    '466j1zv4': {
      'pt': 'Todos os planos têm',
      'en': 'All plans have',
      'es': 'Todos los planes tienen',
    },
    'zwnojd48': {
      'pt': ' 7 dias gratuitos!',
      'en': '7 free days!',
      'es': '¡7 días gratis!',
    },
    'q78408j8': {
      'pt': 'Anual',
      'en': 'Annual',
      'es': 'Anual',
    },
    '3hcv48p2': {
      'pt': 'Melhor Valor',
      'en': 'Best Value',
      'es': 'Mejor relación calidad-precio',
    },
    'xt9wi80u': {
      'pt': 'R\$ ',
      'en': 'R\$',
      'es': 'R\$',
    },
    'lueuxqyh': {
      'pt': '00,00',
      'en': '00.00',
      'es': '00.00',
    },
    'cffwfdpw': {
      'pt': '/ano',
      'en': '/year',
      'es': '/año',
    },
    '7qlsyy9n': {
      'pt': 'Reconomize 15% anualmente',
      'en': 'Save 15% annually',
      'es': 'Ahorra un 15% anualmente',
    },
    'kcu6jlq9': {
      'pt': 'R\$00,00',
      'en': 'R\$00.00',
      'es': 'R\$00.00',
    },
    'dv1c0atq': {
      'pt': 'Mensal',
      'en': 'Monthly',
      'es': 'Mensual',
    },
    'arn04dr4': {
      'pt': 'R\$ ',
      'en': 'R\$',
      'es': 'R\$',
    },
    '8ems5isn': {
      'pt': '00,00',
      'en': '00.00',
      'es': '00.00',
    },
    'he5lf032': {
      'pt': '/mês',
      'en': '/month',
      'es': '/mes',
    },
    'kqi5glbf': {
      'pt': 'Renova Mensalmente',
      'en': 'Renews Monthly',
      'es': 'Se renueva mensualmente',
    },
    '51usjw2c': {
      'pt': 'R\$00,00',
      'en': 'R\$00.00',
      'es': 'R\$00.00',
    },
    '2j9ze2hr': {
      'pt':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
    },
    '2hzbukpf': {
      'pt': 'Experimentar 7 Dias Grátis',
      'en': 'Try it free for 7 days.',
      'es': 'Pruébalo gratis durante 7 días.',
    },
  },
  // p_header
  {
    '38rl7scl': {
      'pt': 'Idade',
      'en': 'Age',
      'es': 'Edad',
    },
    '2ezzlc7r': {
      'pt': 'Peso',
      'en': 'Weight',
      'es': 'Peso',
    },
    '1103wgzu': {
      'pt': 'Altura',
      'en': 'Height',
      'es': 'Altura',
    },
    'bg656e88': {
      'pt': 'Faixa',
      'en': 'Range',
      'es': 'Rango',
    },
    'iw5gt8i1': {
      'pt': 'Sexo',
      'en': 'Sex',
      'es': 'Sexo',
    },
  },
  // p_feedback
  {
    '3k8m55oh': {
      'pt': 'Feedback',
      'en': 'Feedback',
      'es': 'Comentario',
    },
    'lg30yc8p': {
      'pt': 'Está sentindo falta de algo?',
      'en': 'Are you missing something?',
      'es': '¿Te estás perdiendo de algo?',
    },
    'mqojusf2': {
      'pt':
          'Críticas, opiniões, recomendações são muito bem-vindas. Contribua com nosso aplicativo!',
      'en':
          'Criticisms, opinions, and recommendations are very welcome. Contribute to our app!',
      'es':
          'Agradecemos sus críticas, opiniones y recomendaciones. ¡Contribuya a nuestra aplicación!',
    },
    'sftxmuy5': {
      'pt': 'Enviar meu Feedback',
      'en': 'Send my feedback',
      'es': 'Envíame tus comentarios',
    },
  },
  // p_redirect_feedback
  {
    '0639gy7y': {
      'pt': 'Está gostando do aplicativo?',
      'en': 'Are you enjoying the app?',
      'es': '¿Te está gustando la aplicación?',
    },
    'pum51zr8': {
      'pt':
          'Considere deixar sua avaliação na loja de aplicativos. Nos ajuda muito!',
      'en':
          'Please consider leaving a review in the app store. It helps us a lot!',
      'es':
          'Por favor, considera dejar una reseña en la tienda de aplicaciones. ¡Nos ayuda muchísimo!',
    },
    '6vd016bk': {
      'pt': 'Avaliar agora',
      'en': 'Rate now',
      'es': 'Califica ahora',
    },
    'wlb1prjj': {
      'pt': 'Deixar para depois',
      'en': 'Leave it for later',
      'es': 'Déjalo para después.',
    },
  },
  // p_empty
  {
    '0ryjaukn': {
      'pt': 'Ainda sem resultados...',
      'en': 'Still no results...',
      'es': 'Aún no hay resultados...',
    },
    '7s5mc3w2': {
      'pt': 'Fale Conosco!',
      'en': 'Contact us!',
      'es': '¡Contáctanos!',
    },
  },
  // p_conta
  {
    'vw8f4v1j': {
      'pt': 'Conta',
      'en': 'Account',
      'es': 'Cuenta',
    },
    'h9ixty1v': {
      'pt': 'Editar',
      'en': 'Edit',
      'es': 'Editar',
    },
    'qck01rmu': {
      'pt': 'Salvar Alterações',
      'en': 'Save Changes',
      'es': 'Guardar cambios',
    },
    'tjj0tcns': {
      'pt': 'Dados Pessoais',
      'en': 'Personal Data',
      'es': 'Datos personales',
    },
    'o8nbtsqj': {
      'pt': 'Telefone',
      'en': 'Telephone',
      'es': 'Teléfono',
    },
    '3up460ba': {
      'pt': '(00) 0 0000-0000',
      'en': '(00) 0 0000-0000',
      'es': '(00) 0 0000-0000',
    },
    'y44yrsob': {
      'pt': 'E-mail',
      'en': 'E-mail',
      'es': 'Correo electrónico',
    },
    'gzmix5zz': {
      'pt': 'anacsilva@gmail.com',
      'en': 'anacsilva@gmail.com',
      'es': 'anacsilva@gmail.com',
    },
    'zt56bq9s': {
      'pt': 'Senha',
      'en': 'Password',
      'es': 'Contraseña',
    },
    'u51x6dsb': {
      'pt': '********',
      'en': '********',
      'es': '********',
    },
    '672py2su': {
      'pt': 'País/Região',
      'en': 'Country/Region',
      'es': 'País/Región',
    },
    'rkncaht5': {
      'pt': 'Assinatura',
      'en': 'Signature',
      'es': 'Firma',
    },
    'szvtnhpe': {
      'pt': 'Plano Atual',
      'en': 'Current Plan',
      'es': 'Plan actual',
    },
    'd9d8yz2q': {
      'pt': 'Mudar Plano',
      'en': 'Change Plan',
      'es': 'Plan de cambio',
    },
    '2rn6xk6o': {
      'pt': 'Mensal',
      'en': 'Monthly',
      'es': 'Mensual',
    },
    'd92jrlcs': {
      'pt': 'R\$ ',
      'en': 'R\$',
      'es': 'R\$',
    },
    'wt4d0hhh': {
      'pt': '00,00',
      'en': '00.00',
      'es': '00.00',
    },
    'lgiy8zsq': {
      'pt': '/mês',
      'en': '/month',
      'es': '/mes',
    },
    'nr4pv56d': {
      'pt': 'Próxima cobrança: 25/07/25',
      'en': 'Next payment due: July 25, 2025',
      'es': 'Próximo pago: 25 de julio de 2025',
    },
    'zw4wyur8': {
      'pt': 'Cancelar plano',
      'en': 'Cancel plan',
      'es': 'Cancelar plan',
    },
    '2vz2k6g7': {
      'pt': 'Configurações',
      'en': 'Settings',
      'es': 'Ajustes',
    },
    'to7checn': {
      'pt': 'Idioma',
      'en': 'Language',
      'es': 'Idioma',
    },
    'vub1piut': {
      'pt': 'Unidade de Medida de Altura',
      'en': 'Unit of Measurement for Height',
      'es': 'Unidad de medida de la altura',
    },
    'lyue2yfk': {
      'pt': 'Selecione',
      'en': 'Select',
      'es': 'Seleccionar',
    },
    'n8z5xpqe': {
      'pt': 'Search...',
      'en': 'Search...',
      'es': 'Buscar...',
    },
    '02mrkgjo': {
      'pt': 'Centímetros (cm)',
      'en': 'Centimeters (cm)',
      'es': 'Centímetros (cm)',
    },
    'lwkwqvdl': {
      'pt': 'Polegadas (ft)',
      'en': 'Inches (ft)',
      'es': 'pulgadas (pies)',
    },
    'tlumpin0': {
      'pt': 'Unidade de Medida de Peso',
      'en': 'Unit of Measurement for Weight',
      'es': 'Unidad de medida del peso',
    },
    '4cs8y2wp': {
      'pt': 'Selecione',
      'en': 'Select',
      'es': 'Seleccionar',
    },
    '0crf9m8q': {
      'pt': 'Search...',
      'en': 'Search...',
      'es': 'Buscar...',
    },
    'ycysm2e3': {
      'pt': 'Quilogramas (kg)',
      'en': 'Kilograms (kg)',
      'es': 'Kilogramos (kg)',
    },
    'z59dzdt5': {
      'pt': 'Libras (lb)',
      'en': 'Pounds (lb)',
      'es': 'Libras (lb)',
    },
    'qntxm0yy': {
      'pt': 'Sua opinião importa!',
      'en': 'Your opinion matters!',
      'es': '¡Tu opinión importa!',
    },
    'bbu8nhcj': {
      'pt': 'Enviar meu Feedback',
      'en': 'Send my feedback',
      'es': 'Envíame tus comentarios',
    },
    'edvmp5fc': {
      'pt': 'Opções',
      'en': 'Options',
      'es': 'Opciones',
    },
    '3qckljhz': {
      'pt': 'Acesse nosso site',
      'en': 'Visit our website',
      'es': 'Visita nuestro sitio web',
    },
    '09dh27g7': {
      'pt': 'Termos de Uso',
      'en': 'Terms of Use',
      'es': 'Condiciones de uso',
    },
    '9mmniaop': {
      'pt': 'Política de Privacidade',
      'en': 'Privacy Policy',
      'es': 'política de privacidad',
    },
    '4cr3437y': {
      'pt': 'Termo de Consentimento',
      'en': 'Consent Form',
      'es': 'Formulario de consentimiento',
    },
    'p5eg93uy': {
      'pt': 'TERMO DE CONSENTIMENTO',
      'en': 'CONSENT FORM',
      'es': 'FORMULARIO DE CONSENTIMIENTO',
    },
    'likfdgt5': {
      'pt':
          'TERMO DE CONSENTIMENTO E RESPONSABILIDADE DE USO DO APLICATIVO MedCalcATENÇÃO: LEIA COM ATENÇÃO ANTES DE UTILIZAR ESTE APLICATIVO. AO PROSSEGUIR, VOCÊ DECLARA CIÊNCIA E CONCORDÂNCIA INTEGRAL COM TODOS OS TERMOS AQUI ESTABELECIDOS.1.⁠ ⁠DESTINAÇÃO E FINALIDADEEste aplicativo destina-se exclusivamente a profissionais de saúde devidamente habilitados, com formação e competência técnica legalmente reconhecida. Seu conteúdo tem finalidade estritamente informativa, educativa e de apoio à tomada de decisão clínica, não se constituindo como protocolo, diretriz oficial ou recomendação normativa.2.⁠ ⁠LIMITAÇÕES DO CONTEÚDOAs informações fornecidas, ainda que baseadas em literatura técnico-científica, não substituem:•⁠  ⁠julgamento clínico individualizado;•⁠  ⁠avaliação médica presencial;•⁠  ⁠protocolos institucionais ou regulamentações locais;•⁠  ⁠parecer de especialistas com maior domínio na matéria em questão.3.⁠ ⁠RESPONSABILIDADE INDIVIDUALO profissional usuário é o único e exclusivo responsável por suas condutas clínicas, diagnósticas, terapêuticas, prescritivas, anestésicas ou cirúrgicas, sendo este aplicativo meramente um recurso auxiliar e consultivo. A utilização incorreta, fora de contexto ou sem o devido conhecimento técnico poderá gerar consequências graves para o paciente, sendo vedada sua aplicação por leigos.4.⁠ ⁠ISENÇÃO DE RESPONSABILIDADE DO DESENVOLVEDORO(s) desenvolvedor(es), mantenedor(es), contribuidor(es) e patrocinador(es) do aplicativo não assumem qualquer responsabilidade civil, penal, ética ou administrativa por eventuais danos, prejuízos, perdas, omissões, falhas terapêuticas ou qualquer consequência decorrente do uso das informações disponibilizadas.5.⁠ ⁠PLATAFORMAS DE DISTRIBUIÇÃOApple Inc. (App Store) e Google LLC (Play Store), enquanto plataformas de hospedagem, não participam do desenvolvimento ou validação do conteúdo clínico e estão integralmente isentas de qualquer responsabilidade técnica, ética ou legal sobre o uso, interpretações ou decisões clínicas derivadas deste aplicativo.6.⁠ ⁠CONFIDENCIALIDADE E DADOSO MedSuspense não realiza coleta, armazenamento ou compartilhamento de informações pessoais, sensíveis, clínico-assistenciais ou de pacientes. O uso é anônimo e todas as preferências locais são armazenadas exclusivamente no dispositivo.7.⁠ ⁠ATUALIZAÇÕES E ALTERAÇÕESO conteúdo do aplicativo poderá ser alterado, atualizado ou removido a qualquer tempo e sem necessidade de aviso prévio, a critério exclusivo dos responsáveis técnicos. A versão vigente do termo de consentimento será sempre considerada válida a partir da data de seu aceite.8.⁠ ⁠VIGÊNCIA, IRREVOGABILIDADE E IRRETRATABILIDADEEste termo possui validade por tempo indeterminado, e o aceite digital realizado de forma voluntária, informada e inequívoca é considerado juridicamente vinculante. O aceite implica a renúncia de qualquer alegação futura de desconhecimento dos riscos ou das limitações técnicas e legais aqui descritas.9.⁠ ⁠RECOMENDAÇÃO FINALEm caso de dúvida sobre qualquer conteúdo, conduta clínica ou risco terapêutico, o usuário deve buscar *imediatamente orientação de um profissional mais experiente ou especialista na área correspondente.*SE VOCÊ NÃO CONCORDA COM QUALQUER UM DOS ITENS ACIMA, RECOMENDA-SE QUE INTERROMPA O USO DESTE APLICATIVO IMEDIATAMENTE.Este é um termo de adesão eletrônico, com pleno valor jurídico, e seu aceite representa ciência, concordância e responsabilidade profissional.',
      'en':
          'TERMS OF CONSENT AND RESPONSIBILITY FOR USE OF THE MedCalc APPLICATION ATTENTION: READ CAREFULLY BEFORE USING THIS APPLICATION. BY PROCEEDING, YOU DECLARE THAT YOU ARE AWARE OF AND FULLY AGREE WITH ALL THE TERMS ESTABLISHED HEREIN. 1. PURPOSE AND DESTINATION This application is intended exclusively for duly qualified healthcare professionals with legally recognized training and technical competence. Its content is strictly for informational, educational, and clinical decision-making support purposes, and does not constitute a protocol, official guideline, or normative recommendation. 2. CONTENT LIMITATIONS The information provided, even if based on technical and scientific literature, does not replace: • individualized clinical judgment; • In-person medical evaluation; • Institutional protocols or local regulations; • Opinion of specialists with greater expertise in the subject matter. 3. INDIVIDUAL RESPONSIBILITY The professional user is solely and exclusively responsible for their clinical, diagnostic, therapeutic, prescriptive, anesthetic, or surgical conduct, this application being merely an auxiliary and consultative resource. Incorrect use, out of context, or without the necessary technical knowledge may generate serious consequences for the patient, and its use by laypersons is prohibited. 4. DEVELOPER DISCLAIMER The developer(s), maintainer(s), contributor(s), and sponsor(s) of the application assume no civil, criminal, ethical, or administrative liability for any damages, losses, omissions, therapeutic failures, or any consequence arising from the use of the information provided. 5. DISTRIBUTION PLATFORMS Apple Inc. (App Store) and Google LLC (Play Store), as hosting platforms, do not participate in the development or validation of the clinical content and are fully exempt from any technical, ethical, or legal responsibility for the use, interpretations, or clinical decisions derived from this application. 6. CONFIDENTIALITY AND DATA MedSuspense does not collect, store, or share personal, sensitive, clinical-assistance, or patient information. The use is anonymous and all local preferences are stored exclusively on the device. 7. UPDATES AND CHANGES The content of the application may be changed, updated or removed at any time and without prior notice, at the sole discretion of the technical managers. The current version of the consent agreement will always be considered valid from the date of its acceptance. 8. VALIDITY, IRREVOCABILITY AND IRRETRATABILITY This agreement is valid indefinitely, and the digital acceptance made voluntarily, informedly and unequivocally is considered legally binding. Acceptance implies the waiver of any future claim of ignorance of the risks or technical and legal limitations described herein. 9. FINAL RECOMMENDATION In case of doubt regarding any content, clinical conduct, or therapeutic risk, the user should *immediately seek guidance from a more experienced professional or specialist in the corresponding area.* IF YOU DO NOT AGREE WITH ANY OF THE ABOVE ITEMS, IT IS RECOMMENDED THAT YOU IMMEDIATELY DISCONTINUE USING THIS APPLICATION. This is an electronic terms of agreement, with full legal value, and its acceptance represents knowledge, agreement, and professional responsibility.',
      'es':
          'CONDICIONES DE CONSENTIMIENTO Y RESPONSABILIDAD PARA EL USO DE LA APLICACIÓN MedCalc. ATENCIÓN: LEA ATENTAMENTE ANTES DE UTILIZAR ESTA APLICACIÓN. AL CONTINUAR, USTED DECLARA QUE CONOCE Y ACEPTA PLENAMENTE TODOS LOS TÉRMINOS ESTABLECIDOS EN EL PRESENTE DOCUMENTO. 1. PROPÓSITO Y DESTINO. Esta aplicación está destinada exclusivamente a profesionales sanitarios debidamente cualificados con formación y competencia técnica legalmente reconocidas. Su contenido tiene fines estrictamente informativos, educativos y de apoyo a la toma de decisiones clínicas, y no constituye un protocolo, una guía oficial ni una recomendación normativa. 2. LIMITACIONES DEL CONTENIDO. La información proporcionada, incluso si se basa en literatura técnica y científica, no reemplaza: • el criterio clínico individualizado; • la evaluación médica presencial; • los protocolos institucionales ni la normativa local; • la opinión de especialistas con mayor experiencia en la materia. 3. RESPONSABILIDAD INDIVIDUAL. El usuario profesional es el único y exclusivo responsable de su conducta clínica, diagnóstica, terapéutica, prescriptiva, anestésica o quirúrgica, siendo esta aplicación un mero recurso auxiliar y de consulta. El uso incorrecto, fuera de contexto o sin los conocimientos técnicos necesarios puede acarrear graves consecuencias para el paciente, y su uso por personas no especializadas está prohibido. 4. EXENCIÓN DE RESPONSABILIDAD DEL DESARROLLADOR. El/los desarrollador(es), mantenedor(es), colaborador(es) y patrocinador(es) de la aplicación no asumen ninguna responsabilidad civil, penal, ética ni administrativa por daños, pérdidas, omisiones, fallos terapéuticos ni ninguna consecuencia derivada del uso de la información proporcionada. 5. PLATAFORMAS DE DISTRIBUCIÓN. Apple Inc. (App Store) y Google LLC (Play Store), como plataformas de alojamiento, no participan en el desarrollo ni en la validación del contenido clínico y están totalmente exentas de cualquier responsabilidad técnica, ética o legal por el uso, las interpretaciones o las decisiones clínicas derivadas de esta aplicación. 6. CONFIDENCIALIDAD Y DATOS MedSuspense no recopila, almacena ni comparte información personal, sensible, de asistencia clínica ni de pacientes. El uso es anónimo y todas las preferencias locales se almacenan exclusivamente en el dispositivo. 7. ACTUALIZACIONES Y CAMBIOS El contenido de la aplicación puede modificarse, actualizarse o eliminarse en cualquier momento y sin previo aviso, a la entera discreción de los responsables técnicos. La versión vigente del acuerdo de consentimiento se considerará válida a partir de la fecha de su aceptación. 8. VALIDEZ, IRREVOCABILIDAD E IRRETRATABILIDAD Este acuerdo tiene vigencia indefinida, y la aceptación digital realizada de forma voluntaria, informada e inequívoca se considera jurídicamente vinculante. La aceptación implica la renuncia a cualquier reclamación futura por desconocimiento de los riesgos o limitaciones técnicas y legales aquí descritos. 9. RECOMENDACIÓN FINAL En caso de duda sobre cualquier contenido, conducta clínica o riesgo terapéutico, el usuario deberá *buscar inmediatamente orientación de un profesional o especialista con más experiencia en el área correspondiente.* SI NO ESTÁ DE ACUERDO CON ALGUNO DE LOS PUNTOS ANTERIORES, SE RECOMIENDA QUE DEJE DE USAR ESTA APLICACIÓN DE INMEDIATO. Este es un acuerdo electrónico de términos y condiciones, con plena validez legal, y su aceptación implica conocimiento, conformidad y responsabilidad profesional.',
    },
    'p3yb3asm': {
      'pt': 'Excluir minha conta e todos os dados da plataforma',
      'en': 'Delete my account and all data from the platform.',
      'es': 'Eliminar mi cuenta y todos mis datos de la plataforma.',
    },
    'ysl1d6ml': {
      'pt': 'Desconectar',
      'en': 'Disconnect',
      'es': 'Desconectar',
    },
  },
  // p_excluir_conta
  {
    'zwbiei5q': {
      'pt': 'Tem certeza de que quer ir?',
      'en': 'Are you sure you want to go?',
      'es': '¿Estás seguro de que quieres ir?',
    },
    '8siu99m9': {
      'pt': 'Sem MC Guidedose você deixa de ter segurança nas aplicações',
      'en': 'Without MC Guidedose, you lose the security of your applications.',
      'es': 'Sin MC Guidedose, pierdes la seguridad de tus aplicaciones.',
    },
    '85zer3a3': {
      'pt': 'Continuar conosco',
      'en': 'Continue with us',
      'es': 'Continúa con nosotros',
    },
    'tn1fqvwd': {
      'pt': 'Não ter mais segurança nas doses',
      'en': 'No longer having confidence in the doses.',
      'es': 'Ya no confío en las dosis.',
    },
  },
  // p_politica
  {
    'wjsk08cp': {
      'pt': 'Voltar',
      'en': 'To go back',
      'es': 'Para regresar',
    },
    'e9fqmibe': {
      'pt': 'Politica de privacidade e termos de condições e uso',
      'en': 'Privacy policy and terms of use.',
      'es': 'Política de privacidad y condiciones de uso.',
    },
    'pyvl9xz7': {
      'pt':
          'TERMO DE CONSENTIMENTO E ISENÇÃO DE RESPONSABILIDADE – GUIDE DOSE\n\nPelo presente instrumento, o(a) usuário(a), doravante denominado(a) PROFISSIONAL MÉDICO(A), declara ter plena ciência, compreensão e concordância com as disposições abaixo descritas, assumindo integralmente a responsabilidade ética, técnica, científica e legal por toda e qualquer conduta clínica ou terapêutica adotada no exercício da Medicina, em conformidade com o disposto no Código de Ética Médica (CFM, Resolução n.º 2.217/2018) e demais normativas vigentes.\n\n1. NATUREZA E FINALIDADE DO APLICATIVO\n\nO Guide Dose é uma ferramenta de caráter meramente ilustrativo, educativo e de apoio acadêmico, destinada exclusivamente a profissionais médicos legalmente habilitados e registrados nos Conselhos Regionais de Medicina (CRMs).\nO aplicativo não constitui, em hipótese alguma, instrumento de prescrição, diagnóstico, tomada de decisão clínica ou substituto da análise médica individualizada.\n\nSua utilização fora do contexto profissional médico é expressamente vedada, sendo terminantemente contraindicado o uso por estudantes, profissionais de outras áreas da saúde, técnicos, paramédicos ou qualquer indivíduo não habilitado à prática médica.\n\n2. RESPONSABILIDADE PROFISSIONAL\n\nToda e qualquer conduta médica, terapêutica, farmacológica ou intervencionista adotada com base em informações oriundas do Guide Dose é de inteira, exclusiva e intransferível responsabilidade do(a) PROFISSIONAL MÉDICO(A).\n\nO Guide Dose não detém, em nenhuma hipótese, poder de prescrição ou conduta clínica, não sendo a sua utilização justificativa, atenuante ou excludente de responsabilidade em processos administrativos, éticos, civis ou criminais.\n\nO(a) PROFISSIONAL MÉDICO(A) declara, ainda, estar ciente de que toda informação fornecida deve ser confrontada, criticamente analisada e validada segundo a literatura científica atualizada, protocolos institucionais, diretrizes nacionais e internacionais, e sua experiência clínica pessoal.\n\n3. ISENÇÃO DE RESPONSABILIDADE E LIMITAÇÃO DE GARANTIAS\n\nA organização mantenedora do aplicativo Guide Dose, seus representantes legais, desenvolvedores, mantenedores técnicos e parceiros comerciais, bem como as plataformas distribuidoras e publicadoras (Apple Inc. e Google LLC), não se responsabilizam, direta ou indiretamente, por quaisquer danos, prejuízos, eventos adversos, complicações clínicas, desfechos terapêuticos ou consequências legais decorrentes do uso, mau uso ou interpretação das informações apresentadas no aplicativo, sejam estes de natureza positiva, negativa, intencional ou acidental.\n\nAo aceitar este termo, o(a) PROFISSIONAL MÉDICO(A) reconhece que qualquer ato médico praticado com base em dados, cálculos, estimativas ou sugestões exibidas pelo Guide Dose é de sua inteira deliberação e responsabilidade, eximindo integralmente o aplicativo, seus criadores, mantenedores, patrocinadores e plataformas de publicação de qualquer ônus, reclamação ou ação judicial correlata.\n\n4. OBRIGAÇÃO DE COMUNICAÇÃO E COLABORAÇÃO\n\nCaso o(a) PROFISSIONAL MÉDICO(A) identifique inconsistência, imprecisão, erro técnico, desatualização ou discrepância nas informações disponibilizadas pelo aplicativo, compromete-se a comunicar prontamente a equipe responsável pelo Guide Dose, a fim de que sejam adotadas as providências técnicas cabíveis.\n\n5. PROTEÇÃO DE DADOS E PRIVACIDADE (LGPD)\n\nO aplicativo Guide Dose atua em estrita conformidade com a Lei nº 13.709/2018 (Lei Geral de Proteção de Dados – LGPD), assegurando que nenhum dado pessoal, sensível ou identificável de pacientes seja coletado, processado, armazenado ou compartilhado, direta ou indiretamente.\nToda a utilização da ferramenta ocorre em ambiente anônimo e sem retenção de registros que permitam a identificação de indivíduos ou de suas condições clínicas.\n\n6. CONSENTIMENTO LIVRE E ESCLARECIDO\n\nAo prosseguir com o uso do aplicativo, o(a) PROFISSIONAL MÉDICO(A) declara, sob as penas da lei, ter lido integralmente este termo, compreendido seu teor em sua completude e consentido de forma livre, informada, inequívoca e voluntária com todas as cláusulas aqui expressas, reconhecendo que:\n\t•\tO aplicativo não substitui o raciocínio clínico, o julgamento profissional ou a autonomia médica;\n\t•\tToda conduta, prescrição, decisão ou ato clínico é de sua exclusiva competência e responsabilidade;\n\t•\tA empresa desenvolvedora e as plataformas distribuidoras encontram-se integralmente isentas de qualquer responsabilidade ética, civil, penal ou administrativa decorrente de desfechos clínicos relacionados, direta ou indiretamente, ao uso da ferramenta.',
      'en':
          'CONSENT AND LIABILITY WAIVER FORM – GUIDE DOSE\n\nBy this instrument, the user, hereinafter referred to as the MEDICAL PROFESSIONAL, declares to have full knowledge, understanding and agreement with the provisions described below, assuming full ethical, technical, scientific and legal responsibility for any and all clinical or therapeutic conduct adopted in the practice of Medicine, in accordance with the provisions of the Medical Code of Ethics (CFM, Resolution No. 2.217/2018) and other applicable regulations.\n\n1. NATURE AND PURPOSE OF THE APPLICATION\n\nGuide Dose is a purely illustrative, educational and academic support tool, intended exclusively for legally qualified medical professionals registered with the Regional Medical Councils (CRMs).\n\nThe application does not constitute, under any circumstances, an instrument for prescription, diagnosis, clinical decision-making or a substitute for individualized medical analysis.\n\nIts use outside of a professional medical context is expressly prohibited, and its use by students, professionals from other health fields, technicians, paramedics, or any individual not qualified to practice medicine is strictly contraindicated.\n\n2. PROFESSIONAL RESPONSIBILITY\n\nAny and all medical, therapeutic, pharmacological, or interventional conduct adopted based on information from Guide Dose is the sole, exclusive, and non-transferable responsibility of the MEDICAL PROFESSIONAL.\n\nGuide Dose does not, under any circumstances, have the power to prescribe or conduct clinically, and its use does not justify, mitigate, or exclude liability in administrative, ethical, civil, or criminal proceedings.\n\nThe MEDICAL PROFESSIONAL also declares that they are aware that all information provided must be confronted, critically analyzed, and validated according to current scientific literature, institutional protocols, national and international guidelines, and their personal clinical experience.\n\n3. DISCLAIMER OF LIABILITY AND LIMITATION OF WARRANTIES\n\nThe organization maintaining the Guide Dose application, its legal representatives, developers, technical maintainers, and business partners, as well as the distribution and publishing platforms (Apple Inc. and Google LLC), are not liable, directly or indirectly, for any damages, losses, adverse events, clinical complications, therapeutic outcomes, or legal consequences arising from the use, misuse, or interpretation of the information presented in the application, whether positive, negative, intentional, or accidental.\n\nBy accepting this term, the MEDICAL PROFESSIONAL acknowledges that any medical act performed based on data, calculations, estimates, or suggestions displayed by Guide Dose is entirely their own decision and responsibility, fully exempting the application, its creators, maintainers, sponsors, and publishing platforms from any related liability, claim, or legal action.\n\n4. OBLIGATION TO COMMUNICATE AND COLLABORATE\n\nIf the MEDICAL PROFESSIONAL identifies any inconsistency, inaccuracy, technical error, outdated information, or discrepancy in the information provided by the application, they agree to promptly notify the Guide Dose team so that appropriate technical measures can be taken.\n\n5. DATA PROTECTION AND PRIVACY (LGPD)\n\nThe Guide Dose application operates in strict compliance with Law No. 13.709/2018 (General Data Protection Law – LGPD), ensuring that no personal, sensitive, or identifiable patient data is collected, processed, stored, or shared, directly or indirectly.\n\nAll use of the tool occurs in an anonymous environment and without retention of records that allow the identification of individuals or their clinical conditions.\n\n6. FREE AND INFORMED CONSENT\n\nBy continuing to use the application, the MEDICAL PROFESSIONAL declares, under penalty of law, to have read this term in its entirety, understood its content completely, and freely, informedly, unequivocally, and voluntarily consented to all the clauses expressed herein, acknowledging that:\n\n• The application does not replace clinical reasoning, professional judgment, or medical autonomy;\n\n• All conduct, prescription, decision, or clinical act is the sole responsibility of the medical professional;\n\n• The developing company and the distributing platforms are fully exempt from any ethical, civil, criminal, or administrative liability arising from clinical outcomes related, directly or indirectly, to the use of the tool.',
      'es':
          'FORMULARIO DE CONSENTIMIENTO Y EXENCIÓN DE RESPONSABILIDAD – DOSIS GUÍA\n\nMediante este instrumento, el usuario, en adelante denominado PROFESIONAL MÉDICO, declara tener pleno conocimiento, comprensión y conformidad con las disposiciones que se describen a continuación, asumiendo la plena responsabilidad ética, técnica, científica y legal por toda conducta clínica o terapéutica adoptada en el ejercicio de la Medicina, de conformidad con lo dispuesto en el Código de Ética Médica (CFM, Resolución N° 2.217/2018) y demás normativa aplicable.\n\n1. NATURALEZA Y FINALIDAD DE LA APLICACIÓN\n\nDosis Guía es una herramienta meramente ilustrativa, educativa y de apoyo académico, destinada exclusivamente a profesionales médicos legalmente habilitados e inscritos en los Colegios Médicos Regionales (CMR).\n\nLa aplicación no constituye, bajo ninguna circunstancia, un instrumento para la prescripción, el diagnóstico, la toma de decisiones clínicas ni un sustituto del análisis médico individualizado.\n\nQueda expresamente prohibido su uso fuera del ámbito médico profesional, y su uso por estudiantes, profesionales de otros campos de la salud, técnicos, paramédicos o cualquier persona no cualificada para ejercer la medicina está estrictamente contraindicado.\n\n2. RESPONSABILIDAD PROFESIONAL\n\nToda conducta médica, terapéutica, farmacológica o intervencionista adoptada con base en la información de Guide Dose es responsabilidad exclusiva e intransferible del PROFESIONAL MÉDICO.\n\nGuide Dose no tiene, bajo ninguna circunstancia, la facultad de prescribir ni de realizar procedimientos clínicos, y su uso no justifica, atenúa ni excluye la responsabilidad en procedimientos administrativos, éticos, civiles o penales.\n\nEl PROFESIONAL MÉDICO declara, además, que es consciente de que toda la información proporcionada debe ser contrastada, analizada críticamente y validada de acuerdo con la literatura científica actual, los protocolos institucionales, las guías nacionales e internacionales y su propia experiencia clínica.\n\n3. EXENCIÓN DE RESPONSABILIDAD Y LIMITACIÓN DE GARANTÍAS\n\nLa organización que mantiene la aplicación Guide Dose, sus representantes legales, desarrolladores, personal técnico y socios comerciales, así como las plataformas de distribución y publicación (Apple Inc. y Google LLC), no son responsables, directa ni indirectamente, de ningún daño, pérdida, evento adverso, complicación clínica, resultado terapéutico ni consecuencia legal que surja del uso, mal uso o interpretación de la información presentada en la aplicación, ya sea positiva, negativa, intencional o accidental.\n\nAl aceptar este término, el PROFESIONAL MÉDICO reconoce que cualquier acto médico realizado con base en los datos, cálculos, estimaciones o sugerencias mostrados por Guide Dose es de su exclusiva responsabilidad, eximiendo completamente a la aplicación, sus creadores, responsables, patrocinadores y plataformas de publicación de cualquier responsabilidad, reclamación o acción legal relacionada.\n\n4. OBLIGACIÓN DE COMUNICACIÓN Y COLABORACIÓN\n\nSi el PROFESIONAL MÉDICO detecta alguna inconsistencia, inexactitud, error técnico, información desactualizada o discrepancia en la información proporcionada por la aplicación, se compromete a notificarlo de inmediato al equipo de Guide Dose para que se puedan tomar las medidas técnicas pertinentes.\n\n5. PROTECCIÓN DE DATOS Y PRIVACIDAD (LGPD)\n\nLa aplicación Guide Dose opera en estricto cumplimiento con la Ley N° 13.709/2018 (Ley General de Protección de Datos - LGPD), garantizando que no se recopile, procese, almacene ni comparta, directa o indirectamente, ningún dato personal, sensible o identificable del paciente.\n\nEl uso de la herramienta se realiza en un entorno anónimo y sin conservar registros que permitan la identificación de personas o sus condiciones clínicas.\n\n6. CONSENTIMIENTO LIBRE E INFORMADO\n\nAl continuar utilizando la aplicación, el PROFESIONAL MÉDICO declara, bajo pena de ley, haber leído este término en su totalidad, haber comprendido su contenido por completo y haber consentido libre, informado, inequívocamente y voluntariamente todas las cláusulas aquí expresadas, reconociendo que:\n\n• La aplicación no sustituye el razonamiento clínico, el juicio profesional ni la autonomía médica;\n\n• Toda conducta, prescripción, decisión o acto clínico es responsabilidad exclusiva del profesional médico;\n\n• La empresa desarrolladora y las plataformas de distribución están totalmente exentas de cualquier responsabilidad ética, civil, penal o administrativa derivada de los resultados clínicos relacionados, directa o indirectamente, con el uso de la herramienta.',
    },
  },
  // p_consentimento
  {
    '2wtf2njk': {
      'pt': 'Voltar',
      'en': 'To go back',
      'es': 'Para regresar',
    },
    'f1zxbrso': {
      'pt': 'TERMO DE CONSENTIMENTO',
      'en': 'CONSENT FORM',
      'es': 'FORMULARIO DE CONSENTIMIENTO',
    },
    '7td28qv0': {
      'pt':
          'TERMO DE CONSENTIMENTO E RESPONSABILIDADE DE USO DO APLICATIVO MedCalc\n\nATENÇÃO: LEIA COM ATENÇÃO ANTES DE UTILIZAR ESTE APLICATIVO. AO PROSSEGUIR, VOCÊ DECLARA CIÊNCIA E CONCORDÂNCIA INTEGRAL COM TODOS OS TERMOS AQUI ESTABELECIDOS.\n\n1.⁠ ⁠DESTINAÇÃO E FINALIDADE\nEste aplicativo destina-se exclusivamente a profissionais de saúde devidamente habilitados, com formação e competência técnica legalmente reconhecida. Seu conteúdo tem finalidade estritamente informativa, educativa e de apoio à tomada de decisão clínica, não se constituindo como protocolo, diretriz oficial ou recomendação normativa.\n\n2.⁠ ⁠LIMITAÇÕES DO CONTEÚDO\nAs informações fornecidas, ainda que baseadas em literatura técnico-científica, não substituem:\n•⁠  ⁠julgamento clínico individualizado;\n•⁠  ⁠avaliação médica presencial;\n•⁠  ⁠protocolos institucionais ou regulamentações locais;\n•⁠  ⁠parecer de especialistas com maior domínio na matéria em questão.\n\n3.⁠ ⁠RESPONSABILIDADE INDIVIDUAL\nO profissional usuário é o único e exclusivo responsável por suas condutas clínicas, diagnósticas, terapêuticas, prescritivas, anestésicas ou cirúrgicas, sendo este aplicativo meramente um recurso auxiliar e consultivo. A utilização incorreta, fora de contexto ou sem o devido conhecimento técnico poderá gerar consequências graves para o paciente, sendo vedada sua aplicação por leigos.\n\n4.⁠ ⁠ISENÇÃO DE RESPONSABILIDADE DO DESENVOLVEDOR\nO(s) desenvolvedor(es), mantenedor(es), contribuidor(es) e patrocinador(es) do aplicativo não assumem qualquer responsabilidade civil, penal, ética ou administrativa por eventuais danos, prejuízos, perdas, omissões, falhas terapêuticas ou qualquer consequência decorrente do uso das informações disponibilizadas.\n\n5.⁠ ⁠PLATAFORMAS DE DISTRIBUIÇÃO\nApple Inc. (App Store) e Google LLC (Play Store), enquanto plataformas de hospedagem, não participam do desenvolvimento ou validação do conteúdo clínico e estão integralmente isentas de qualquer responsabilidade técnica, ética ou legal sobre o uso, interpretações ou decisões clínicas derivadas deste aplicativo.\n\n6.⁠ ⁠CONFIDENCIALIDADE E DADOS\nO MedSuspense não realiza coleta, armazenamento ou compartilhamento de informações pessoais, sensíveis, clínico-assistenciais ou de pacientes. O uso é anônimo e todas as preferências locais são armazenadas exclusivamente no dispositivo.\n\n7.⁠ ⁠ATUALIZAÇÕES E ALTERAÇÕES\nO conteúdo do aplicativo poderá ser alterado, atualizado ou removido a qualquer tempo e sem necessidade de aviso prévio, a critério exclusivo dos responsáveis técnicos. A versão vigente do termo de consentimento será sempre considerada válida a partir da data de seu aceite.\n\n8.⁠ ⁠VIGÊNCIA, IRREVOGABILIDADE E IRRETRATABILIDADE\nEste termo possui validade por tempo indeterminado, e o aceite digital realizado de forma voluntária, informada e inequívoca é considerado juridicamente vinculante. O aceite implica a renúncia de qualquer alegação futura de desconhecimento dos riscos ou das limitações técnicas e legais aqui descritas.\n\n9.⁠ ⁠RECOMENDAÇÃO FINAL\nEm caso de dúvida sobre qualquer conteúdo, conduta clínica ou risco terapêutico, o usuário deve buscar *imediatamente orientação de um profissional mais experiente ou especialista na área correspondente.*\n\nSE VOCÊ NÃO CONCORDA COM QUALQUER UM DOS ITENS ACIMA, RECOMENDA-SE QUE INTERROMPA O USO DESTE APLICATIVO IMEDIATAMENTE.\n\nEste é um termo de adesão eletrônico, com pleno valor jurídico, e seu aceite representa ciência, concordância e responsabilidade profissional.\n',
      'en':
          'TERMS OF CONSENT AND RESPONSIBILITY FOR USE OF THE MedCalc APPLICATION\n\nATTENTION: READ CAREFULLY BEFORE USING THIS APPLICATION. BY PROCEEDING, YOU DECLARE THAT YOU ARE AWARE OF AND FULLY AGREE TO ALL THE TERMS ESTABLISHED HEREIN.\n\n1. PURPOSE AND INTENDED USE\n\nThis application is intended exclusively for duly qualified healthcare professionals with legally recognized training and technical competence. Its content is strictly for informational, educational, and clinical decision-making support purposes, and does not constitute a protocol, official guideline, or normative recommendation.\n\n2. CONTENT LIMITATIONS\n\nThe information provided, even if based on technical and scientific literature, does not replace:\n\n• individualized clinical judgment;\n\n• in-person medical evaluation;\n\n• institutional protocols or local regulations;\n\n• opinion of specialists with greater expertise in the subject matter.\n\n3. INDIVIDUAL RESPONSIBILITY\nThe professional user is solely and exclusively responsible for their clinical, diagnostic, therapeutic, prescriptive, anesthetic, or surgical conduct, this application being merely an auxiliary and consultative resource. Incorrect use, out of context, or without the necessary technical knowledge may generate serious consequences for the patient, and its use by laypersons is prohibited.\n\n4. DEVELOPER DISCLAIMER\nThe developer(s), maintainer(s), contributor(s), and sponsor(s) of the application assume no civil, criminal, ethical, or administrative liability for any damages, losses, omissions, therapeutic failures, or any consequence arising from the use of the information provided.\n\n5. DISTRIBUTION PLATFORMS\nApple Inc. (App Store) and Google LLC (Play Store), as hosting platforms, do not participate in the development or validation of the clinical content and are fully exempt from any technical, ethical, or legal responsibility for the use, interpretations, or clinical decisions derived from this application.\n\n6. CONFIDENTIALITY AND DATA\nMedSuspense does not collect, store, or share personal, sensitive, clinical-assistance, or patient information. The use is anonymous and all local preferences are stored exclusively on the device.\n\n7. UPDATES AND CHANGES\nThe application content may be changed, updated, or removed at any time without prior notice, at the sole discretion of the technical staff. The current version of the consent agreement will always be considered valid from the date of its acceptance.\n\n8. VALIDITY, IRREVOCABILITY AND IRRETRATABILITY\nThis agreement is valid indefinitely, and the voluntary, informed, and unequivocal digital acceptance is considered legally binding. Acceptance implies the waiver of any future claim of ignorance of the risks or technical and legal limitations described herein.\n\n9. FINAL RECOMMENDATION\nIn case of doubt regarding any content, clinical conduct, or therapeutic risk, the user should *immediately seek guidance from a more experienced professional or specialist in the corresponding area.*\n\nIF YOU DO NOT AGREE WITH ANY OF THE ABOVE ITEMS, IT IS RECOMMENDED THAT YOU IMMEDIATELY DISCONTINUE USING THIS APPLICATION.\n\nThis is an electronic terms of agreement, with full legal value, and its acceptance represents knowledge, agreement, and professional responsibility.',
      'es':
          'CONDICIONES DE CONSENTIMIENTO Y RESPONSABILIDAD PARA EL USO DE LA APLICACIÓN MedCalc\n\nATENCIÓN: LEA ATENTAMENTE ANTES DE UTILIZAR ESTA APLICACIÓN. AL CONTINUAR, USTED DECLARA QUE CONOCE Y ACEPTA PLENAMENTE TODAS LAS CONDICIONES ESTABLECIDAS EN EL PRESENTE DOCUMENTO.\n\n1. PROPÓSITO Y USO PREVISTO\n\nEsta aplicación está destinada exclusivamente a profesionales sanitarios debidamente cualificados con formación y competencia técnica legalmente reconocidas. Su contenido tiene fines estrictamente informativos, educativos y de apoyo a la toma de decisiones clínicas, y no constituye un protocolo, una guía oficial ni una recomendación normativa.\n\n2. LIMITACIONES DEL CONTENIDO\n\nLa información proporcionada, incluso si se basa en literatura técnica y científica, no sustituye:\n\n• el criterio clínico individualizado;\n\n• la evaluación médica presencial;\n\n• los protocolos institucionales o la normativa local;\n\n• la opinión de especialistas con mayor experiencia en la materia.\n\n3. RESPONSABILIDAD INDIVIDUAL\nEl usuario profesional es el único y exclusivo responsable de su conducta clínica, diagnóstica, terapéutica, prescriptiva, anestésica o quirúrgica. Esta aplicación es meramente un recurso auxiliar y de consulta. El uso incorrecto, fuera de contexto o sin los conocimientos técnicos necesarios puede acarrear graves consecuencias para el paciente, y se prohíbe su uso por personas no especializadas.\n\n4. EXENCIÓN DE RESPONSABILIDAD DEL DESARROLLADOR\nEl/los desarrollador/es, mantenedor/es, colaborador/es y patrocinador/es de la aplicación no asumen ninguna responsabilidad civil, penal, ética ni administrativa por daños, pérdidas, omisiones, fallos terapéuticos ni ninguna consecuencia derivada del uso de la información proporcionada.\n\n5. PLATAFORMAS DE DISTRIBUCIÓN\nApple Inc. (App Store) y Google LLC (Play Store), como plataformas de alojamiento, no participan en el desarrollo ni en la validación del contenido clínico y están totalmente exentas de cualquier responsabilidad técnica, ética o legal por el uso, las interpretaciones o las decisiones clínicas derivadas de esta aplicación.\n\n6. CONFIDENCIALIDAD Y DATOS\n\nMedSuspense no recopila, almacena ni comparte información personal, sensible, de asistencia clínica ni de pacientes. El uso es anónimo y todas las preferencias locales se almacenan exclusivamente en el dispositivo.\n\n7. ACTUALIZACIONES Y CAMBIOS\n\nEl contenido de la aplicación puede modificarse, actualizarse o eliminarse en cualquier momento sin previo aviso, a la entera discreción del personal técnico. La versión vigente del acuerdo de consentimiento se considerará válida a partir de la fecha de su aceptación.\n\n8. VALIDEZ, IRREVOCABILIDAD E IRRETRACTIFICACIÓN\n\nEste acuerdo tiene validez indefinida, y la aceptación digital voluntaria, informada e inequívoca se considera jurídicamente vinculante. La aceptación implica la renuncia a cualquier reclamación futura por desconocimiento de los riesgos o las limitaciones técnicas y legales aquí descritas.\n\n9. RECOMENDACIÓN FINAL\n\nEn caso de duda sobre cualquier contenido, conducta clínica o riesgo terapéutico, el usuario deberá *buscar inmediatamente orientación de un profesional o especialista con más experiencia en el área correspondiente.*\n\nSI NO ESTÁ DE ACUERDO CON ALGUNO DE LOS PUNTOS ANTERIORES, SE RECOMIENDA QUE DEJE DE USAR ESTA APLICACIÓN DE INMEDIATO.\n\nEste es un acuerdo electrónico de términos y condiciones, con plena validez legal, y su aceptación implica conocimiento, conformidad y responsabilidad profesional.',
    },
  },
  // p_calc
  {
    'ywayng77': {
      'pt': 'Dados do Paciente',
      'en': 'Patient Data',
      'es': 'Datos del paciente',
    },
    'fihkzw3n': {
      'pt': 'Peso (kg)',
      'en': 'Weight (kg)',
      'es': 'Peso (kg)',
    },
    '6ni9o2qp': {
      'pt': 'Altura (cm)',
      'en': 'Height (cm)',
      'es': 'Altura (cm)',
    },
    'inp4cydv': {
      'pt': 'Idade',
      'en': 'Age',
      'es': 'Edad',
    },
    'f9bzb865': {
      'pt': 'Anos',
      'en': 'Select',
      'es': 'Seleccionar',
    },
    '485filqv': {
      'pt': 'Search...',
      'en': 'Search...',
      'es': 'Buscar...',
    },
    'vhzirs1o': {
      'pt': 'Anos',
      'en': 'Years',
      'es': 'Años',
    },
    '6w8mlsv1': {
      'pt': 'Meses',
      'en': 'Months',
      'es': 'Meses',
    },
    'ayfamx9d': {
      'pt': 'Sexo',
      'en': 'Sex',
      'es': 'Sexo',
    },
    'vhivaboz': {
      'pt': 'Feminino',
      'en': 'Feminine',
      'es': 'Femenino',
    },
    '7c829le5': {
      'pt': 'Masculino',
      'en': 'Masculine',
      'es': 'Masculino',
    },
    '3xxut51p': {
      'pt': 'Calcular',
      'en': 'Calculate',
      'es': 'Calcular',
    },
  },
  // p_medicamentos
  {
    '7oed41mu': {
      'pt': 'Pesquisar remédios',
      'en': 'Search for remedies',
      'es': 'Buscar remedios',
    },
  },
  // p_detalhe_medicamento
  {
    '5lz4atxf': {
      'pt': 'Bula do Medicamento',
      'en': 'Drug Information Leaflet',
      'es': 'Prospecto informativo del medicamento',
    },
    'vu9emtce': {
      'pt': 'Princípio Ativo',
      'en': 'Active ingredient',
      'es': 'Ingrediente activo',
    },
    'p1zuxw19': {
      'pt': 'Nome comercial',
      'en': 'Trade name',
      'es': 'Nombre comercial',
    },
    '2jvoryw1': {
      'pt': 'Classificação',
      'en': 'Classification',
      'es': 'Clasificación',
    },
    'uumhnsw1': {
      'pt': 'Mecanismo de ação',
      'en': 'Mechanism of action',
      'es': 'Mecanismo de acción',
    },
    'lh8f86y0': {
      'pt': 'Farmacocinética',
      'en': 'Pharmacokinetics',
      'es': 'Farmacocinética',
    },
    'z9u68bhr': {
      'pt': 'Indicações',
      'en': 'Indications',
      'es': 'Indicaciones',
    },
    'f313byc4': {
      'pt': 'Posologia',
      'en': 'Dosage',
      'es': 'Dosificación',
    },
    'ir2bjznl': {
      'pt': 'Administração',
      'en': 'Administration',
      'es': 'Administración',
    },
    'fgg0kgm1': {
      'pt': 'Dose Máxima',
      'en': 'Maximum Dose',
      'es': 'Dosis máxima',
    },
    'jvsk4u8c': {
      'pt': 'Dose mínima',
      'en': 'Minimum dose',
      'es': 'Dosis mínima',
    },
    'u56c63gj': {
      'pt': 'Reações adversas',
      'en': 'Adverse reactions',
      'es': 'Reacciones adversas',
    },
    'oit2o30c': {
      'pt': 'Risco gravidez',
      'en': 'Pregnancy risk',
      'es': 'Riesgo del embarazo',
    },
    'wktwinhv': {
      'pt': 'Risco lactação',
      'en': 'Lactation risk',
      'es': 'Riesgo de lactancia',
    },
    '27crkti0': {
      'pt': 'Ajuste Renal',
      'en': 'Kidney Adjustment',
      'es': 'Ajuste renal',
    },
    'sl73ufmd': {
      'pt': 'Ajuste Hepático',
      'en': 'Liver Adjustment',
      'es': 'Ajuste hepático',
    },
    '2peccn6y': {
      'pt': 'Contra Indicações',
      'en': 'Contraindications',
      'es': 'Contraindicaciones',
    },
    'phuszhkn': {
      'pt': 'Interação Medicamento',
      'en': 'Drug Interaction',
      'es': 'Interacción farmacológica',
    },
    'm2zpuphb': {
      'pt': 'Apresentação',
      'en': 'Presentation',
      'es': 'Presentación',
    },
    '2s3xeif1': {
      'pt': 'Preparo',
      'en': 'Preparation',
      'es': 'Preparación',
    },
    '6cr7qlur': {
      'pt': 'Soluções compatíveis',
      'en': 'Compatible solutions',
      'es': 'Soluciones compatibles',
    },
    '8ieyxvhz': {
      'pt': 'Amarzenamento',
      'en': 'Storage',
      'es': 'Almacenamiento',
    },
    'w28qurgy': {
      'pt': 'Cuidados Médicos',
      'en': 'Medical Care',
      'es': 'Atención médica',
    },
    '6gd9tklu': {
      'pt': 'Cuidados Farmacêuticos ',
      'en': 'Pharmaceutical Care',
      'es': 'Atención farmacéutica',
    },
    '1txq4qfg': {
      'pt': 'Cuidados Enfermagem',
      'en': 'Nursing Care',
      'es': 'Cuidados de enfermería',
    },
    'u6jxezpo': {
      'pt': 'Início Ação',
      'en': 'Home Action',
      'es': 'Inicio Acción',
    },
    'al0o5c4u': {
      'pt': 'Tempo Pico',
      'en': 'Peak Time',
      'es': 'Hora punta',
    },
    'eej74okp': {
      'pt': 'Meia Vida',
      'en': 'Half Life',
      'es': 'Vida media',
    },
    'toux1a9i': {
      'pt': 'Efeito Clínico',
      'en': 'Clinical Effect',
      'es': 'Efecto clínico',
    },
    'kiph06kq': {
      'pt': 'Via Eliminação',
      'en': 'Via Elimination',
      'es': 'Vía eliminación',
    },
    'bw9gabwb': {
      'pt': 'Estabilidade Pós Diluição',
      'en': 'Post-Dilution Stability',
      'es': 'Estabilidad posterior a la dilución',
    },
    '0yna7hv7': {
      'pt': 'Precauções Específicas',
      'en': 'Specific Precautions',
      'es': 'Precauciones específicas',
    },
    'umo90p52': {
      'pt': 'Bibliografia',
      'en': 'Bibliography',
      'es': 'Bibliografía',
    },
  },
  // p_accordeon_medicamento
  {
    '86ehoge5': {
      'pt': 'Preparo',
      'en': 'Preparation',
      'es': 'Preparación',
    },
    'qxvq84ir': {
      'pt': 'Indicação e doses',
      'en': 'Indications and dosages',
      'es': 'Indicaciones y dosis',
    },
    '7hb7xx6k': {
      'pt': 'Indicação e doses',
      'en': 'Indications and dosages',
      'es': 'Indicaciones y dosis',
    },
    'q8ad2f5g': {
      'pt': 'Selecione',
      'en': 'Select',
      'es': 'Seleccionar',
    },
    '21sfmf0a': {
      'pt': 'Search...',
      'en': 'Search...',
      'es': 'Buscar...',
    },
    'ub0xgbyf': {
      'pt': '500mg/100mL (5mg/mL)',
      'en': '1mg/250mL (4mcg/mL)',
      'es': '1 mg/250 ml (4 mcg/ml)',
    },
    'v86iik2t': {
      'pt': '250mg/100mL (2,5mg/mL)',
      'en': '',
      'es': '',
    },
  },
  // p_aviso
  {
    '4lrtny8f': {
      'pt': 'Fechar',
      'en': 'To close',
      'es': 'Para cerrar',
    },
  },
  // p_emptyList
  {
    'ob3k9h6u': {
      'pt': 'Ainda sem resultados...',
      'en': 'Still no results...',
      'es': 'Aún no hay resultados...',
    },
  },
  // comp_bep
  {
    'ww6qsqp2': {
      'pt': 'Fechar',
      'en': 'To close',
      'es': 'Para cerrar',
    },
  },
  // comp_senha
  {
    'ic7wpy4h': {
      'pt': 'Fechar',
      'en': 'To close',
      'es': 'Para cerrar',
    },
  },
  // p_inducao
  {
    '28yxphn6': {
      'pt': 'Pesquisar condição clínica',
      'en': 'Search for a clinical condition',
      'es': 'Búsqueda de una condición clínica',
    },
  },
  // p_detalhe_inducao
  {
    'dfxk0njl': {
      'pt': 'Informativo da Condição',
      'en': 'Condition Information',
      'es': 'Información sobre la condición',
    },
    'x08xbjwe': {
      'pt': 'Definição',
      'en': 'Definition',
      'es': 'Definición',
    },
    'd468ko0d': {
      'pt': 'Epidemiologia',
      'en': 'Epidemiology',
      'es': 'Epidemiología',
    },
    'lhgz4kwi': {
      'pt': 'Fisiopatologia',
      'en': 'Pathophysiology',
      'es': 'Fisiopatología',
    },
    'trvs9swa': {
      'pt': 'Manifestações clínicas',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    'rztpgy1x': {
      'pt': 'Sinais e Sintomas',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    'lbavv2ck': {
      'pt': 'Causas Comuns',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    '1a3q7sin': {
      'pt': 'Estratégias Anteriores ao Ato',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    't38sf6t6': {
      'pt': 'Diagnóstico Diferencial',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    'djj0oruw': {
      'pt': 'Medicamentos Mais Usados',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    'q5hs9f83': {
      'pt': 'Cuidados Pós-operatórios',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    'njghccp5': {
      'pt': 'Avaliação Pré-operatória',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    '4x1thr48': {
      'pt': 'Tratamento',
      'en': 'Clinical manifestations',
      'es': 'Manifestaciones clínicas',
    },
    'c93wnsxc': {
      'pt': 'Diagnóstico',
      'en': 'Diagnosis',
      'es': 'Diagnóstico',
    },
    'a1nwuqcr': {
      'pt': 'Indicações para suporte ventilatório',
      'en': 'Indications for ventilatory support',
      'es': 'Indicaciones de soporte ventilatorio',
    },
    'g7rgr19j': {
      'pt': 'Conduta geral',
      'en': 'General conduct',
      'es': 'Conducta general',
    },
    '9jdis6ct': {
      'pt': 'Prognóstico',
      'en': 'Prognosis',
      'es': 'Pronóstico',
    },
    'yew5ktsq': {
      'pt': 'Medicamentos Comuns',
      'en': 'Common Medications',
      'es': 'Medicamentos comunes',
    },
    '1y172o1g': {
      'pt': 'Monitorização',
      'en': 'Monitoring',
      'es': 'Escucha',
    },
    'uhfhbt3r': {
      'pt': 'Cuidados',
      'en': 'Care',
      'es': 'Cuidado',
    },
    '87f9af8s': {
      'pt': 'Contra Indicações',
      'en': 'Contraindications',
      'es': 'Contraindicaciones',
    },
    '7phop7fv': {
      'pt': 'Notas adicionais',
      'en': 'Additional notes',
      'es': 'Notas adicionales',
    },
    '12e8pzce': {
      'pt': 'Bibliografia',
      'en': 'Bibliography',
      'es': 'Bibliografía',
    },
  },
  // comp_menu
  {
    't9510bew': {
      'pt': 'Indução',
      'en': 'Induction',
      'es': 'Inducción',
    },
    'rzwvtr0f': {
      'pt': 'Fisiologia',
      'en': 'Physiology',
      'es': 'Fisiología',
    },
    'lgw78d5m': {
      'pt': 'Remédios',
      'en': 'Drugs',
      'es': 'Drogas',
    },
    'xzmt37qj': {
      'pt': 'Conta',
      'en': 'Account',
      'es': 'Cuenta',
    },
  },
  // c_fisiologia
  {
    'xt5gxa26': {
      'pt': 'Dados Antropométricos',
      'en': 'Anthropometric Data',
      'es': 'Datos antropométricos',
    },
    '1ya4snte': {
      'pt': 'Peso Ideal',
      'en': 'Ideal Weight',
      'es': 'Peso ideal',
    },
    'so17t0z5': {
      'pt': 'Superfície Corporal Ajustada',
      'en': 'Adjusted Body Surface Area',
      'es': 'Área de superficie corporal ajustada',
    },
    'keij7ic5': {
      'pt': 'Peso Corrigido',
      'en': 'Corrected Weight',
      'es': 'Peso corregido',
    },
    'kbknocq6': {
      'pt': 'IMC',
      'en': 'BMI',
      'es': 'IMC',
    },
    '4kfqwvg9': {
      'pt': 'Percentual em relação ao peso ideal',
      'en': 'Percentage in relation to ideal weight',
      'es': 'Porcentaje en relación al peso ideal',
    },
    'lk8l52z4': {
      'pt': 'Peso em relação à altura',
      'en': 'Weight in relation to height',
      'es': 'Peso en relación a la altura',
    },
    'tmyccfn7': {
      'pt': 'Peso esperado',
      'en': 'Expected weight',
      'es': 'Peso esperado',
    },
    'zs4h7uhq': {
      'pt': 'Altura esperada',
      'en': 'Expected height',
      'es': 'Altura esperada',
    },
    '058rve72': {
      'pt': 'IMC esperado',
      'en': 'Expected BMI',
      'es': 'IMC esperado',
    },
    'f0mui9wj': {
      'pt': 'Parâmetros Circulatórios',
      'en': 'Circulatory Parameters',
      'es': 'Parámetros circulatorios',
    },
    'fc53s3y8': {
      'pt': 'Frequência cardíaca',
      'en': 'Heart rate',
      'es': 'Frecuencia cardíaca',
    },
    'nkbo77w8': {
      'pt': 'Pressão arterial',
      'en': 'Blood pressure',
      'es': 'Presión arterial',
    },
    'bu60ko5x': {
      'pt': 'Volume plasmático',
      'en': 'Plasma volume',
      'es': 'Volumen plasmático',
    },
    'z6ar8ght': {
      'pt': 'Volume diário de infusão',
      'en': 'Daily infusion volume',
      'es': 'Volumen de infusión diaria',
    },
    'i3fo2wjw': {
      'pt': 'Tempo de reperfusão capilar',
      'en': 'Capillary reperfusion time',
      'es': 'Tiempo de reperfusión capilar',
    },
    'f1cctf0z': {
      'pt': 'Parâmetros Ventilatórios',
      'en': 'Ventilatory Parameters',
      'es': 'Parámetros ventilatorios',
    },
    'fp360dqd': {
      'pt': 'Máscara facial',
      'en': 'Face mask',
      'es': 'Mascarilla',
    },
    'jxc2psgz': {
      'pt': 'Cânula orofaríngea',
      'en': 'Oropharyngeal airway',
      'es': 'Vía aérea orofaríngea',
    },
    'r2sxzmx8': {
      'pt': 'Cânula nasofaríngea',
      'en': 'Nasopharyngeal cannula',
      'es': 'Cánula nasofaríngea',
    },
    'hnotsrfg': {
      'pt': 'Combitubo',
      'en': 'Combitube',
      'es': 'Tubo combinado',
    },
    '5457q7mk': {
      'pt': 'Máscara laríngea',
      'en': 'Laryngeal mask airway',
      'es': 'Vía aérea con mascarilla laríngea',
    },
    'd6j7l1z2': {
      'pt': 'Laringoscópio reto',
      'en': 'Straight laryngoscope',
      'es': 'Laringoscopio recto',
    },
    '9m560rgh': {
      'pt': 'Laringoscópio curvo',
      'en': 'Curved laryngoscope',
      'es': 'Laringoscopio curvo',
    },
    '03q3z8vw': {
      'pt': 'Tubo orotraqueal com cuff',
      'en': 'Orotracheal tube with cuff',
      'es': 'Tubo orotraqueal con balón',
    },
    '3vjxuiex': {
      'pt': 'Tubo orotraqueal sem cuff',
      'en': 'Cuffless endotracheal tube',
      'es': 'Tubo endotraqueal sin balón',
    },
    'fhnzxxmg': {
      'pt': 'Altura da fixação',
      'en': 'Fixation height',
      'es': 'Altura de fijación',
    },
    '8uwzdrhu': {
      'pt': 'Cânula de traqueostomia',
      'en': 'Tracheostomy cannula',
      'es': 'Cánula de traqueotomía',
    },
    '3j0a8cyr': {
      'pt': 'Parâmetros Respiratórios',
      'en': 'Respiratory Parameters',
      'es': 'Parámetros respiratorios',
    },
    'po68v56z': {
      'pt': 'Frequência respiratória',
      'en': 'Respiratory rate',
      'es': 'frecuencia respiratoria',
    },
    '2npynzk8': {
      'pt': 'Volume corrente',
      'en': 'Tidal volume',
      'es': 'Volumen corriente',
    },
    '1u4xwv7c': {
      'pt': 'Volume por minuto',
      'en': 'Volume per minute',
      'es': 'Volumen por minuto',
    },
    '7udaidpd': {
      'pt': 'Relação I:E',
      'en': 'I:E Ratio',
      'es': 'Relación I:E',
    },
    '7d97tsqn': {
      'pt': 'Espaço morto',
      'en': 'Dead space',
      'es': 'Espacio muerto',
    },
    'kkyq6s04': {
      'pt': 'Pressão de pico',
      'en': 'Peak pressure',
      'es': 'Presión máxima',
    },
    '6znxusqo': {
      'pt': 'PEEP sugerida',
      'en': 'Suggested PEEP',
      'es': 'PEEP sugerida',
    },
    'riwu4lxz': {
      'pt': 'Cálculos extra',
      'en': 'Extra calculations',
      'es': 'Cálculos adicionales',
    },
    'ufcq8mwh': {
      'pt': 'Sonda vesical de demora',
      'en': 'Indwelling urinary catheter',
      'es': 'Sonda urinaria permanente',
    },
    'hhaq3cin': {
      'pt': 'Dreno de Kehr',
      'en': 'Kehr drain',
      'es': 'Drenaje Kehr',
    },
    '0vswtk4d': {
      'pt': 'Sonda nasogástrica (SNG)',
      'en': 'Nasogastric tube (NGT)',
      'es': 'Sonda nasogástrica (SNG)',
    },
    's6sndf7p': {
      'pt': 'Fixação da SNG',
      'en': 'SNG Fixation',
      'es': 'Fijación de SNG',
    },
    'unr1ovao': {
      'pt': 'Sonda nasoentérica (SNE)',
      'en': 'Nasoenteric tube (NET)',
      'es': 'Sonda nasoentérica (SNE)',
    },
    '5re66hri': {
      'pt': 'Fixação da SNE',
      'en': 'SNE Fixation',
      'es': 'Fijación del SNE',
    },
    '43uk05ms': {
      'pt': 'Acesso central',
      'en': 'Central access',
      'es': 'Acceso central',
    },
    '5hkzrjzu': {
      'pt': 'Cateter de Shilley',
      'en': 'Shilley catheter',
      'es': 'Catéter de Shilley',
    },
  },
  // p_accordeon_inducao
  {
    'dmpev9uc': {
      'pt': 'Medicamento',
      'en': 'Medication',
      'es': 'Medicamento',
    },
    'fpv73ho7': {
      'pt': 'Dose / Volume',
      'en': 'Dose/Volume',
      'es': 'Dosis/Volumen',
    },
  },
  // p_country
  {
    'k704bg29': {
      'pt': 'Selecione um país/região',
      'en': 'Select a country/region',
      'es': 'Seleccione un país/región',
    },
  },
  // Miscellaneous
  {
    'zzuxmfr6': {
      'pt': 'Cadastrar uma Conta',
      'en': 'Register an Account',
      'es': 'Crea una cuenta',
    },
    '0c2olt3z': {
      'pt': 'Já sou Cadastrado',
      'en': 'I\'m already registered.',
      'es': 'Ya estoy registrado.',
    },
    '619wcefg': {
      'pt': 'e-mail ou telefone',
      'en': 'email or phone',
      'es': 'correo electrónico o teléfono',
    },
    'q76tipg7': {
      'pt': 'Voltar',
      'en': 'To go back',
      'es': 'Para regresar',
    },
    'a5pnuzz2': {
      'pt': 'Experimentar 7 Dias Grátis',
      'en': 'Try it free for 7 days.',
      'es': 'Pruébalo gratis durante 7 días.',
    },
    'd3c8m0jb': {
      'pt': 'Informação',
      'en': 'Information',
      'es': 'Información',
    },
    'hzzrzxy1': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'fkh1a5gq': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'odw4j3t4': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '8lvubqj2': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'rynm35w2': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'qrj46ra5': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'nog1dpwf': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '95in18y5': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'epaah1qy': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'ljm8fdd0': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '8j6tm4uy': {
      'pt': '',
      'en': '',
      'es': '',
    },
    's1t4zn75': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '5jz963pp': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'zj8do3ey': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'bcq75oth': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '07kvqspt': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '7c5dc81r': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '2sf44a5r': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'z77r5eaq': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'q5l6l8d9': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '2t79m0ro': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'x4p73bju': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'paatp5e4': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'ymg03mky': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '66oj7vje': {
      'pt': '',
      'en': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
