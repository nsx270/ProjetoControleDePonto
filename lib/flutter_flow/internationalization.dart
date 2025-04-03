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
  // Login
  {
    '1374rjp1': {
      'pt': 'Bem vindo de volta',
      'en': 'Welcome back',
      'es': 'Bienvenido de nuevo',
    },
    't9nbghov': {
      'pt': 'Entre com seu email e senha cadastrados',
      'en': 'Enter your registered email and password',
      'es': 'Inicie sesión con su correo electrónico registrado y contraseña',
    },
    'yz680hmc': {
      'pt': 'Email',
      'en': 'E-mail',
      'es': 'Correo electrónico',
    },
    '88jkkgnz': {
      'pt': 'Senha',
      'en': 'Password',
      'es': 'Contraseña',
    },
    'x3yfud9r': {
      'pt': 'Entrar',
      'en': 'Log In',
      'es': 'Entrar',
    },
    'wogzn3p1': {
      'pt': 'Por favor, utilize sua biometria cadastrada',
      'en': 'Please use your registered biometrics',
      'es': 'Utilice sus datos biométricos registrados',
    },
    '0xoduewm': {
      'pt': 'Não possuí uma conta?',
      'en': 'Don\'t have an account?',
      'es': '¿No tienes una cuenta?',
    },
    'qzjexmd6': {
      'pt': ' Cadastrar',
      'en': 'Register',
      'es': 'Registro',
    },
    'rfzv4y4s': {
      'pt': 'Esqueceu sua senha?',
      'en': 'Forgot your password?',
      'es': '¿Olvidaste tu contraseña?',
    },
    'a3usu2jr': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Registrar
  {
    'rmgn5rxk': {
      'pt': 'Crie sua conta',
      'en': 'Create your account',
      'es': 'Crea tu cuenta',
    },
    'na861rhd': {
      'pt': 'Utilize seu email e crie uma senha',
      'en': 'Use your email and create a password',
      'es': 'Utilice su correo electrónico y cree una contraseña',
    },
    '3ob0r0x2': {
      'pt': 'Email',
      'en': 'Email',
      'es': 'Email',
    },
    '6tky7886': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'wrpxgg7q': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'bxsr4gyy': {
      'pt': 'Repita seu email',
      'en': 'Repeat your email',
      'es': 'Repite tu correo electrónico',
    },
    '0tghtn1l': {
      'pt': 'Telefone',
      'en': 'Telephone',
      'es': 'Teléfono',
    },
    'drdbpo83': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'lb0tcgw4': {
      'pt': 'Senha',
      'en': 'Password',
      'es': 'Contraseña',
    },
    's87xzwau': {
      'pt': 'Confirmar senha',
      'en': 'Confirm password',
      'es': 'Confirmar Contraseña',
    },
    'd31gzhxh': {
      'pt': 'Continuar',
      'en': 'Continue',
      'es': 'Continuar',
    },
    '7wbhq5qe': {
      'pt': 'Já possuí uma conta na HELP? ',
      'en': 'Do you already have a HELP account?',
      'es': '¿Ya tienes una cuenta de HELP?',
    },
    'jmi0uk75': {
      'pt': 'Entrar',
      'en': 'Log In',
      'es': 'Entrar',
    },
    '9qbi962a': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // PagInicial
  {
    'uza9hurk': {
      'pt': 'Junte se a milhares de autônomos!',
      'en': 'Join thousands of freelancers!',
      'es': '¡Únete a miles de autónomos!',
    },
    'k83lxoyw': {
      'pt': 'Criar uma conta',
      'en': 'Create an account',
      'es': 'Crea una cuenta',
    },
    'hyjqqret': {
      'pt': 'Ja possuí uma conta? ',
      'en': 'Already have an account?',
      'es': '¿Ya tienes una cuenta?',
    },
    '9ik71btu': {
      'pt': 'Entrar!',
      'en': 'Log In!',
      'es': '¡Para entrar!',
    },
    '7z3sdh8v': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // EsqueceuSenha
  {
    'dbjx4p7i': {
      'pt': 'Back',
      'en': 'Back',
      'es': 'Back',
    },
    'wbnpnfcl': {
      'pt': 'Redefinir senha',
      'en': 'Reset password',
      'es': 'Restablecer contraseña',
    },
    'obsutrst': {
      'pt':
          'Vamos enviar um email com um link para você redefinir sua senha. Por favor insira seu email abaixo.',
      'en':
          'We will send you an email with a link to reset your password. Please enter your email address below.',
      'es':
          'Le enviaremos un correo electrónico con un enlace para restablecer su contraseña. Por favor ingrese su correo electrónico a continuación.',
    },
    'kxfsqnys': {
      'pt': 'Insira seu email',
      'en': 'Enter your email',
      'es': 'Introduce tu correo electrónico',
    },
    'mczfn2g5': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'hkb4g77s': {
      'pt': 'Enviar link',
      'en': 'Send link',
      'es': 'Enviar enlace',
    },
    'mxd39eji': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // EmailEnviado
  {
    'y3l5yrnm': {
      'pt': 'Back',
      'en': 'Back',
      'es': 'Atrás',
    },
    'qqgu3c5f': {
      'pt': 'Redefinir senha',
      'en': 'Reset password',
      'es': 'Restablecer contraseña',
    },
    'c6a5pxo2': {
      'pt':
          'Um email foi enviado para você com instruções para redefinir sua senha. Caso não encontre o email verifique sua caixa de spam.',
      'en':
          'An email has been sent to you with instructions on how to reset your password. If you can\'t find the email, check your spam folder.',
      'es':
          'Se le ha enviado un correo electrónico con instrucciones para restablecer su contraseña. Si no puede encontrar el correo electrónico, revise su carpeta de spam.',
    },
    '2r1yqn7v': {
      'pt': 'Voltar a tela de login',
      'en': 'Return to login screen',
      'es': 'Volver a la pantalla de inicio de sesión',
    },
    'g120cxuq': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // CadastroCliente
  {
    'ypoft0qg': {
      'pt': 'Insira seus dados pessoais',
      'en': 'Enter your personal details',
      'es': 'Introduce tus datos personales',
    },
    'x5142c5k': {
      'pt': 'Nome completo',
      'en': 'Full name',
      'es': 'nombre completo',
    },
    'dkneveej': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'dboaa2am': {
      'pt': 'CPF',
      'en': 'CPF',
      'es': 'CPF',
    },
    's4loc53w': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'eyjcqyd2': {
      'pt': 'Data de nascimento',
      'en': 'Date of birth',
      'es': 'Fecha de nacimiento',
    },
    'uqinf97y': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'vb6lrrkb': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'xca53nm7': {
      'pt': 'Gênero',
      'en': 'Gender',
      'es': 'Género',
    },
    'rzqbgleo': {
      'pt': 'Search...',
      'en': 'Search...',
      'es': 'Buscar...',
    },
    'tlevhuyc': {
      'pt': 'Masculino',
      'en': 'Masculine',
      'es': 'Masculino',
    },
    'erou39wl': {
      'pt': 'Feminino',
      'en': 'Feminine',
      'es': 'Femenino',
    },
    'z5tl1esm': {
      'pt': 'Prefiro não responder',
      'en': 'I prefer not to answer',
      'es': 'Prefiero no responder',
    },
    'jgpvo2fk': {
      'pt': 'Insira seu endereço',
      'en': 'Enter your address',
      'es': 'Introduce tu dirección',
    },
    '1smzmfpl': {
      'pt': 'CEP',
      'en': 'CEP',
      'es': 'CEP',
    },
    '6m3pgzek': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'kf7e0w0t': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'wqypsk5a': {
      'pt': 'Estado',
      'en': 'State',
      'es': 'Estado',
    },
    'c507so8u': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '4l1bekbm': {
      'pt': 'Acre',
      'en': 'Acre',
      'es': 'Acre',
    },
    '3ha76qax': {
      'pt': 'Alagoas',
      'en': 'Alagoas',
      'es': 'Alagoas',
    },
    '1kjtc619': {
      'pt': 'Amapá',
      'en': 'Amapá',
      'es': 'Amapá',
    },
    '2u2t5jok': {
      'pt': 'Amazonas',
      'en': 'Amazonas',
      'es': 'Amazonas',
    },
    'o8h09ols': {
      'pt': 'Bahia',
      'en': 'Bahia',
      'es': 'Bahía',
    },
    'zh0yieaw': {
      'pt': 'Ceará',
      'en': 'Ceará',
      'es': 'Ceará',
    },
    'qhb8cjnt': {
      'pt': 'Distrito Federal',
      'en': 'Distrito Federal',
      'es': 'Distrito Federal',
    },
    'kwvg9a4j': {
      'pt': 'Espírito Santo',
      'en': 'Espírito Santo',
      'es': 'Espírito Santo',
    },
    'jay4jr8n': {
      'pt': 'Goiás',
      'en': 'Goiás',
      'es': 'Goiás',
    },
    'r7l3vnh7': {
      'pt': 'Maranhão',
      'en': 'Maranhão',
      'es': 'Maranhão',
    },
    'a0k8gz26': {
      'pt': 'Mato Grosso',
      'en': 'Mato Grosso',
      'es': 'Mato Grosso',
    },
    'k88nlrn2': {
      'pt': 'Mato Grosso do Sul',
      'en': 'Mato Grosso do Sul',
      'es': 'Mato Grosso do Sul',
    },
    'jqwxoxep': {
      'pt': 'Minas Gerais',
      'en': 'Minas Gerais',
      'es': 'Minas Gerais',
    },
    '56r2wzqh': {
      'pt': 'Pará',
      'en': 'Pará',
      'es': 'Pará',
    },
    '13t9jdi8': {
      'pt': 'Paraíba',
      'en': 'Paraíba',
      'es': 'Paraíba',
    },
    'vv79sk70': {
      'pt': 'Paraná',
      'en': 'Paraná',
      'es': 'Paraná',
    },
    'q7ka5bgt': {
      'pt': 'Pernambuco',
      'en': 'Pernambuco',
      'es': 'Pernambuco',
    },
    'ii04wmpa': {
      'pt': 'Piauí',
      'en': 'Piauí',
      'es': 'Piauí',
    },
    'qpave7re': {
      'pt': 'Rio  de Janeiro',
      'en': 'Rio de Janeiro',
      'es': 'Río de Janeiro',
    },
    '6povw4v7': {
      'pt': 'Rio Grande do Norte',
      'en': 'Rio Grande do Norte',
      'es': 'Río Grande do Norte',
    },
    'o3yjcjma': {
      'pt': 'Rio Grande do Sul',
      'en': 'Rio Grande do Sul',
      'es': 'Río Grande do Sul',
    },
    '84s5dgym': {
      'pt': 'Rondônia',
      'en': 'Rondônia',
      'es': 'Rondônia',
    },
    'nsty5am8': {
      'pt': 'Roraima',
      'en': 'Roraima',
      'es': 'Roraima',
    },
    'frc88483': {
      'pt': 'Santa Catarina',
      'en': 'Santa Catarina',
      'es': 'Santa Catarina',
    },
    'kcstnffv': {
      'pt': 'São Paulo',
      'en': 'São Paulo',
      'es': 'São Paulo',
    },
    'x00ptqph': {
      'pt': 'Sergipe',
      'en': 'Sergipe',
      'es': 'Sergipe',
    },
    'wkjrl8t8': {
      'pt': 'Tocantins',
      'en': 'Tocantins',
      'es': 'Tocantins',
    },
    '5vh5twt3': {
      'pt': 'Cidade',
      'en': 'City',
      'es': 'Ciudad',
    },
    'ylzqnl69': {
      'pt': 'Endereço',
      'en': 'Address',
      'es': 'Dirección',
    },
    '9y478gj7': {
      'pt': 'Número',
      'en': 'Number',
      'es': 'Número',
    },
    'qw3gddk1': {
      'pt': 'Complemento',
      'en': 'Complement',
      'es': 'Complementar',
    },
    'alecxf6z': {
      'pt': 'Ponto de referência',
      'en': 'Reference point',
      'es': 'Punto de referencia',
    },
    'y16jj99b': {
      'pt': 'Declaro que li concordo com os\n',
      'en': 'I declare that I have read and agree with the',
      'es': 'Declaro que he leído y estoy de acuerdo con las',
    },
    'zewaryes': {
      'pt': 'termos e condições ',
      'en': 'terms and conditions',
      'es': 'Términos y condiciones',
    },
    '5tjbf2sc': {
      'pt': 'da HELP',
      'en': 'from HELP',
      'es': 'de HELP',
    },
    'd7izf1m2': {
      'pt': 'Criar conta',
      'en': 'Create account',
      'es': 'Crear una cuenta',
    },
    '57wg22s2': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // Premium
  {
    '0xrt24iu': {
      'pt': 'Vire HELP!',
      'en': 'Turn HELP!',
      'es': 'Gire ¡HELP!',
    },
    'yvmq48or': {
      'pt': 'Plano mensal',
      'en': 'Monthly plan',
      'es': 'Plan mensual',
    },
    '9g8m9850': {
      'pt': 'Pacote mensal',
      'en': 'Monthly package',
      'es': 'Paquete mensual',
    },
    '5lzauquy': {
      'pt': 'R\$ 15.99/mês',
      'en': 'R\$ 15.99/month',
      'es': 'R\$ 15,99/mes',
    },
    'unq29ecq': {
      'pt':
          'Obtenha acesso ilimitado a todos os conteúdos que temos para oferecer! ',
      'en': 'Get unlimited access to all the content we have to offer!',
      'es':
          '¡Obtén acceso ilimitado a todo el contenido que tenemos para ofrecer!',
    },
    '981tjx4r': {
      'pt': 'Plano anual',
      'en': 'Annual plan',
      'es': 'Plan anual',
    },
    '2ty3zn8i': {
      'pt': 'Pacote anual (Economize R\$ 12)',
      'en': 'Annual Package (Save R\$12)',
      'es': 'Paquete anual (Ahorre R\$12)',
    },
    '9qgckkfu': {
      'pt': 'R\$ 180/ano',
      'en': 'R\$ 180/year',
      'es': 'R\$ 180/año',
    },
    'tatxb270': {
      'pt':
          'Obtenha acesso ilimitado a todos os conteúdos que temos para oferecer! ',
      'en': 'Get unlimited access to all the content we have to offer!',
      'es':
          '¡Obtén acceso ilimitado a todo el contenido que tenemos para ofrecer!',
    },
    'lhkchi0n': {
      'pt': 'Ou então',
      'en': 'Or else',
      'es': 'Si no',
    },
    '2a3lw344': {
      'pt': 'Continue grátis',
      'en': 'Continue for free',
      'es': 'Mantente libre',
    },
    'jcxgf5be': {
      'pt':
          'Continue usando a plataforma sem custos. Haverá limitações e propagandas que atendem melhor a sua experiência!',
      'en':
          'Continue using the platform at no cost. There will be limitations and advertisements that better suit your experience!',
      'es':
          'Continúe usando la plataforma de forma gratuita. ¡Habrá limitaciones y anuncios que mejor se adapten a tu experiencia!',
    },
    'nlriufjt': {
      'pt': 'Mudar plano',
      'en': 'Change plan',
      'es': 'Cambiar de plan',
    },
    'xkueyyv4': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // Suporte
  {
    '7afu317d': {
      'pt': 'Suporte',
      'en': 'Support',
      'es': 'Apoyo',
    },
    'ziz8s7w4': {
      'pt': 'Como podemos te ajudar?',
      'en': 'How can we help you?',
      'es': '¿Cómo podemos ayudarte?',
    },
    'oxltgv7v': {
      'pt': 'Ligue',
      'en': 'Call',
      'es': 'Llamar',
    },
    'jwnlbds3': {
      'pt': 'Enviar Email',
      'en': 'Send Email',
      'es': 'Enviar correo electrónico',
    },
    'dq7xg053': {
      'pt': ' FAQs',
      'en': 'FAQs',
      'es': 'Preguntas frecuentes',
    },
    '5ju7nm7t': {
      'pt': 'Perguntas frequentes',
      'en': 'Frequently Asked Questions',
      'es': 'Preguntas frecuentes',
    },
    '8wkmz7m3': {
      'pt': 'Como se tornar Help Premium?',
      'en': 'How to become Help Premium?',
      'es': '¿Cómo convertirse en Help Premium?',
    },
    'ca4x6i47': {
      'pt':
          'Para se tornar premium é necessário assinar o nosso plano premium. Clique para conhecer nossos planos.',
      'en':
          'To become premium you need to subscribe to our premium plan. Click to learn more about our plans.',
      'es':
          'Para convertirse en premium debe suscribirse a nuestro plan premium. Haz clic para ver nuestros planes.',
    },
    's5nluk27': {
      'pt': 'Como enviar um bug encontrado?',
      'en': 'How to submit a found bug?',
      'es': '¿Cómo enviar un error encontrado?',
    },
    'im9lwceb': {
      'pt': 'Calma que eu ja te explico!',
      'en': 'Calm down, I\'ll explain it to you!',
      'es': '¡No te preocupes, te lo explicaré!',
    },
    'echuhyp1': {
      'pt': 'Como eu baixo códigos?',
      'en': 'How do I download codes?',
      'es': '¿Cómo descargo códigos?',
    },
    'axdwietb': {
      'pt': 'Calma que eu ja te explico!',
      'en': 'Calm down, I\'ll explain it to you!',
      'es': '¡No te preocupes, te lo explicaré!',
    },
    'apyw15k7': {
      'pt': 'Criar ticket',
      'en': 'Create ticket',
      'es': 'Crear ticket',
    },
    'tygzifpw': {
      'pt': 'Conversar por chat',
      'en': 'Chat',
      'es': 'Charlar',
    },
    'el4d87fq': {
      'pt': 'Central  de atendimento',
      'en': 'Call center',
      'es': 'Centro de llamadas',
    },
    'zi8n471w': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // Avaliations
  {
    '90dvxlg0': {
      'pt': '2,503',
      'en': '2,503',
      'es': '2.503',
    },
    'feptuduq': {
      'pt': 'Avaliações',
      'en': 'Reviews',
      'es': 'Reseñas',
    },
    'hie689lq': {
      'pt': '4.6',
      'en': '4.6',
      'es': '4.6',
    },
    'owzh2fky': {
      'pt': 'Estrelas',
      'en': 'Stars',
      'es': 'Estrellas',
    },
    'xuu029dl': {
      'pt': 'Pedrão CRUD',
      'en': 'CRUD Pedro',
      'es': 'Pedro CRUD',
    },
    'bhw6fzph': {
      'pt': 'Eu tenho uma estratégia!',
      'en': 'I have a strategy!',
      'es': '¡Tengo una estrategia!',
    },
    't3cqrq0p': {
      'pt': 'Alexandre Henrique',
      'en': 'Alexander Henry',
      'es': 'Alexandre Henrique',
    },
    'xrwwaki0': {
      'pt':
          'Horrível esse aplicativo! Tudo bugado e sem suporte! Liguei ontem na central e inguém me atendeu.',
      'en':
          'This app is horrible! Everything is buggy and there is no support! I called the center yesterday and no one answered me.',
      'es':
          '¡Esta aplicación es horrible! ¡Todo tiene errores y no es compatible! Llamé ayer al centro y no contestó nadie.',
    },
    'qjsc1zbb': {
      'pt': 'Pedro Toledo',
      'en': 'Pedro Toledo',
      'es': 'Pedro Toledo',
    },
    'wsnfrnbb': {
      'pt':
          'Como voceês tem coragem de fazer um aplicativo assim, eu teria vergonha de postar isso kkkkkkkkkkkkk',
      'en':
          'How dare you make an app like this, I would be ashamed to post this lol',
      'es':
          '¿Cómo tienes el coraje de hacer una aplicación como esta? Me daría vergüenza publicar esto jajaja.',
    },
    'h64mv5xx': {
      'pt': 'Reinan Isabelense',
      'en': 'Queen Isabelense',
      'es': 'reinan isabelense',
    },
    '607xnnci': {
      'pt':
          'Eu não consegui entrar em contato com os profissionais de Santa Isabel, TÁ ENGANANDO O CLIENTE???',
      'en':
          'I couldn\'t get in touch with the professionals in Santa Isabel, ARE YOU DECEIVING THE CUSTOMER???',
      'es':
          'No pude contactar con los profesionales de Santa Isabel, ¿ESTÁS ENGAÑANDO AL CLIENTE???',
    },
    'k9gtlaa7': {
      'pt': 'Pedro Toledo',
      'en': 'Pedro Toledo',
      'es': 'pedro toledo',
    },
    'i7c8xlrp': {
      'pt':
          'Como voceês tem coragem de fazer um aplicativo assim, eu teria vergonha de postar isso kkkkkkkkkkkkk',
      'en':
          'How dare you make an app like this, I would be ashamed to post this lol',
      'es':
          '¿Cómo tienes el coraje de hacer una aplicación como esta? Me daría vergüenza publicar esto jajaja.',
    },
    'oudirisn': {
      'pt': 'Pedro Toledo',
      'en': 'Pedro Toledo',
      'es': 'pedro toledo',
    },
    'or95s72h': {
      'pt':
          'Como voceês tem coragem de fazer um aplicativo assim, eu teria vergonha de postar isso kkkkkkkkkkkkk',
      'en':
          'How dare you make an app like this, I would be ashamed to post this lol',
      'es':
          '¿Cómo tienes el coraje de hacer una aplicación como esta? Me daría vergüenza publicar esto jajaja.',
    },
    'm3mk1j7q': {
      'pt': 'Pedro Toledo',
      'en': 'Pedro Toledo',
      'es': 'pedro toledo',
    },
    'qkaqe10f': {
      'pt':
          'Como voceês tem coragem de fazer um aplicativo assim, eu teria vergonha de postar isso kkkkkkkkkkkkk',
      'en':
          'How dare you make an app like this, I would be ashamed to post this lol',
      'es':
          '¿Cómo tienes el coraje de hacer una aplicación como esta? Me daría vergüenza publicar esto jajaja.',
    },
    'qmmgbv4s': {
      'pt': 'Pedro Toledo',
      'en': 'Pedro Toledo',
      'es': 'pedro toledo',
    },
    'ik4mjmen': {
      'pt':
          'Como voceês tem coragem de fazer um aplicativo assim, eu teria vergonha de postar isso kkkkkkkkkkkkk',
      'en':
          'How dare you make an app like this, I would be ashamed to post this lol',
      'es':
          '¿Cómo tienes el coraje de hacer una aplicación como esta? Me daría vergüenza publicar esto jajaja.',
    },
    'ncqdl0k8': {
      'pt': 'Bolsonaro',
      'en': 'Bolsonaro',
      'es': 'Bolsonaro',
    },
    'i82862ba': {
      'pt': 'Obrigado ta ok',
      'en': 'Thank you, okay?',
      'es': 'gracias, vale',
    },
    'u0l203eq': {
      'pt': 'Juninho',
      'en': 'Juninho',
      'es': 'juninho',
    },
    's638lena': {
      'pt': 'Não sei',
      'en': 'I don\'t know',
      'es': 'No sé',
    },
    'wbpqt9l7': {
      'pt': 'Alexandre o Grande',
      'en': 'Alexander the Great',
      'es': 'Alejandro Magno',
    },
    'v8cmm5bs': {
      'pt': 'Muito bom! Perfeito!',
      'en': 'Very good! Perfect!',
      'es': '¡Muy bien! ¡Perfecto!',
    },
    'ifniiwri': {
      'pt': 'donald trampes',
      'en': 'Donald Trampes',
      'es': 'donald vagabundos',
    },
    'hcf0v6sk': {
      'pt': 'make help great again',
      'en': 'make help great again',
      'es': 'haz que la ayuda sea genial otra vez',
    },
    'okhgm09o': {
      'pt': 'Pedrão CRUD',
      'en': 'CRUD Pedro',
      'es': 'Pedro CRUD',
    },
    'd9hvfvmf': {
      'pt': 'CADÊ MINHA TELA?????????????????????????',
      'en': 'WHERE IS MY SCREEN?????????????????????????',
      'es': '¿DÓNDE ESTÁ MI PANTALLA????????????????????????',
    },
    'm7ho0bfh': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // TrabalhadorCliente
  {
    'r29yvzy3': {
      'pt': 'Você é um autônomo, uma empresa ou um cliente?',
      'en': 'Are you a freelancer, a company or a client?',
      'es': '¿Eres autónomo, una empresa o un cliente?',
    },
    'bq76c2h4': {
      'pt':
          'Selecione a opção que te define atualmente para prosseguimos com o cadastro. \nVocê poderá mudar isso depois',
      'en':
          'Select the option that currently defines you to continue with the registration.\n\nYou can change this later.',
      'es':
          'Selecciona la opción que te define actualmente para proceder con el registro. \nPuedes cambiar esto más tarde',
    },
    '73d73ctd': {
      'pt': 'Autônomo',
      'en': 'Self-employed',
      'es': 'Autónomo',
    },
    'rk8bjakp': {
      'pt': 'Empresa',
      'en': 'Enterprise',
      'es': 'Empresa',
    },
    'sh0u1cnb': {
      'pt': 'Cliente',
      'en': 'Customer',
      'es': 'Cliente',
    },
    '3x27c40n': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // CadastroAutonomo
  {
    '0x2w9t39': {
      'pt': 'Insira seus dados pessoais',
      'en': 'Enter your personal details',
      'es': 'Introduce tus datos personales',
    },
    'q1qigbdw': {
      'pt': 'Nome completo',
      'en': 'Full name',
      'es': 'Nombre Completo',
    },
    '7cm4pvbp': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'tywjnokk': {
      'pt': 'CPF',
      'en': 'CPF',
      'es': 'CPF',
    },
    '1dxvccoi': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '904l22fr': {
      'pt': 'CNPJ',
      'en': 'CNPJ',
      'es': 'CNPJ',
    },
    'zqryeyhr': {
      'pt': 'Data de nascimento',
      'en': 'Date of birth',
      'es': 'Fecha de nacimiento',
    },
    'srdrjojk': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'k8bbcza4': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'rvklq2wc': {
      'pt': 'Gênero',
      'en': 'Gender',
      'es': 'Género',
    },
    'e6mf7efz': {
      'pt': 'Search...',
      'en': 'Search...',
      'es': 'Buscar...',
    },
    'vovar1wm': {
      'pt': 'Masculino',
      'en': 'Masculine',
      'es': 'Masculino',
    },
    'kft3zwmb': {
      'pt': 'Feminino',
      'en': 'Feminine',
      'es': 'Femenino',
    },
    'sjpulprc': {
      'pt': 'Prefiro não responder',
      'en': 'I prefer not to answer',
      'es': 'prefiero no responder',
    },
    'w32oi1cy': {
      'pt': 'Insira seu endereço',
      'en': 'Enter your address',
      'es': 'Introduce tu dirección',
    },
    'f0cylvxm': {
      'pt': 'CEP',
      'en': 'CEP',
      'es': 'CEP',
    },
    '10hj2dti': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'r902xis7': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'tur43ezy': {
      'pt': 'Estado',
      'en': 'State',
      'es': 'Estado',
    },
    'e8m4m343': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'g4bane4c': {
      'pt': 'Acre',
      'en': 'Acre',
      'es': 'Acre',
    },
    'p7va5p13': {
      'pt': 'Alagoas',
      'en': 'Alagoas',
      'es': 'Alagoas',
    },
    'oas76cjf': {
      'pt': 'Amapá',
      'en': 'Amapá',
      'es': 'Amapá',
    },
    'u2sehwvc': {
      'pt': 'Amazonas',
      'en': 'Amazonas',
      'es': 'Amazonas',
    },
    '0qql8dne': {
      'pt': 'Bahia',
      'en': 'Bahia',
      'es': 'Bahía',
    },
    '0chyzkvn': {
      'pt': 'Ceará',
      'en': 'Ceará',
      'es': 'Ceará',
    },
    'jujnzlxs': {
      'pt': 'Distrito Federal',
      'en': 'Distrito Federal',
      'es': 'Distrito Federal',
    },
    'pmki9obg': {
      'pt': 'Espírito Santo',
      'en': 'Espírito Santo',
      'es': 'Espírito Santo',
    },
    '6xwbhr3s': {
      'pt': 'Goiás',
      'en': 'Goiás',
      'es': 'Goiás',
    },
    'egnqm1ek': {
      'pt': 'Maranhão',
      'en': 'Maranhão',
      'es': 'Maranhão',
    },
    'x3j7iya5': {
      'pt': 'Mato Grosso',
      'en': 'Mato Grosso',
      'es': 'Mato Grosso',
    },
    'kgnuextm': {
      'pt': 'Mato Grosso do Sul',
      'en': 'Mato Grosso do Sul',
      'es': 'Mato Grosso do Sul',
    },
    'yv9iwj9k': {
      'pt': 'Minas Gerais',
      'en': 'Minas Gerais',
      'es': 'Minas Gerais',
    },
    'vjufws61': {
      'pt': 'Pará',
      'en': 'Pará',
      'es': 'Pará',
    },
    '76cpln3j': {
      'pt': 'Paraíba',
      'en': 'Paraíba',
      'es': 'Paraíba',
    },
    'dvi0mnfy': {
      'pt': 'Paraná',
      'en': 'Paraná',
      'es': 'Paraná',
    },
    'hdkc5n5b': {
      'pt': 'Pernambuco',
      'en': 'Pernambuco',
      'es': 'Pernambuco',
    },
    'ei08igl3': {
      'pt': 'Piauí',
      'en': 'Piauí',
      'es': 'Piauí',
    },
    'fkvmmbd0': {
      'pt': 'Rio  de Janeiro',
      'en': 'Rio de Janeiro',
      'es': 'Río de Janeiro',
    },
    'bed4dfy7': {
      'pt': 'Rio Grande do Norte',
      'en': 'Rio Grande do Norte',
      'es': 'Rio Grande do Norte',
    },
    'oif8nsyv': {
      'pt': 'Rio Grande do Sul',
      'en': 'Rio Grande do Sul',
      'es': 'Rio Grande do Sul',
    },
    'qy6pkglo': {
      'pt': 'Rondônia',
      'en': 'Rondônia',
      'es': 'Rondônia',
    },
    'f0jw1pkl': {
      'pt': 'Roraima',
      'en': 'Roraima',
      'es': 'Roraima',
    },
    'jaj047he': {
      'pt': 'Santa Catarina',
      'en': 'Santa Catarina',
      'es': 'Santa Catarina',
    },
    'g5pl7uhy': {
      'pt': 'São Paulo',
      'en': 'São Paulo',
      'es': 'São Paulo',
    },
    '1s35pkkz': {
      'pt': 'Sergipe',
      'en': 'Sergipe',
      'es': 'Sergipe',
    },
    'jvsrfuzx': {
      'pt': 'Tocantins',
      'en': 'Tocantins',
      'es': 'Tocantins',
    },
    'vze9626b': {
      'pt': 'Cidade',
      'en': 'City',
      'es': 'Ciudad',
    },
    '4nqxe4v2': {
      'pt': 'Endereço',
      'en': 'Address',
      'es': 'Dirección',
    },
    'qn4wnikb': {
      'pt': 'Número',
      'en': 'Number',
      'es': 'Número',
    },
    'hik2ml21': {
      'pt': 'Complemento',
      'en': 'Complement',
      'es': 'Complementar',
    },
    '4upo6swg': {
      'pt': 'Ponto de referência',
      'en': 'Reference point',
      'es': 'Punto de referencia',
    },
    'ak9sofy3': {
      'pt': 'Declaro que li concordo com os\n',
      'en': 'I declare that I have read and agree with the',
      'es': 'Declaro que he leído y estoy de acuerdo con las',
    },
    'k7ldqgmg': {
      'pt': 'termos e condições ',
      'en': 'terms and conditions',
      'es': 'Términos y condiciones',
    },
    'jm69zi2s': {
      'pt': 'da HELP',
      'en': 'from HELP',
      'es': 'de HELP',
    },
    '65e7dwfm': {
      'pt': 'Criar conta',
      'en': 'Create account',
      'es': 'Crear una cuenta',
    },
    'vme9haqa': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // TermosCondicoes
  {
    't8a8rp3r': {
      'pt': 'Termos e condições',
      'en': 'Terms and conditions',
      'es': 'Términos y condiciones',
    },
    '40mt22kb': {
      'pt':
          'Ao concordar com estes termos e condições, você permite que a HELP utilize seus dados para fins comerciais de forma consciente, respeitando o anonimato e seguindo as leis brasileiras.',
      'en':
          'By agreeing to these terms and conditions, you allow HELP to use your data for commercial purposes in a conscious manner, respecting anonymity and following Brazilian laws.',
      'es':
          'Al aceptar estos términos y condiciones, permite que HELP utilice sus datos con fines comerciales de manera consciente, respetando el anonimato y siguiendo las leyes brasileñas.',
    },
    'ukvtqkwl': {
      'pt':
          '1. Introdução\n\nBem-vindo ao HELP (\"Aplicativo\"), uma plataforma desenvolvida pela HELP Tecnologia Ltda. (\"Empresa\") para conectar trabalhadores autônomos (\"Usuários\") a clientes e oportunidades de trabalho. Ao utilizar o Aplicativo, você concorda com os seguintes Termos e Condições de Uso. Leia-os atentamente antes de usar os nossos serviços.\n\n 2. Aceitação dos Termos\n\nAo se cadastrar no Aplicativo, o Usuário declara ter lido e aceito integralmente os Termos e Condições aqui estabelecidos. Caso o Usuário não concorde com qualquer cláusula, recomenda-se que interrompa o uso imediatamente.\n\n3. Cadastro e Conta do Usuário\n\nPara utilizar os serviços do Aplicativo, o Usuário deve:\n- Fornecer informações verdadeiras, completas e atualizadas.\n- Ser maior de 18 anos ou estar devidamente autorizado por seus responsáveis legais.\n- Manter a segurança e a confidencialidade de suas credenciais de acesso.\n\n4. Serviços Oferecidos\n\nO Aplicativo atua como um intermediário digital entre trabalhadores autônomos e clientes, facilitando a contratação de serviços de forma direta entre as partes. O HELP não é empregador dos Usuários e não oferece garantias quanto à qualidade ou conclusão dos serviços prestados.\n\n5. Responsabilidades dos Usuários\n\nO Usuário compromete-se a:\n- Cumprir todas as leis aplicáveis, inclusive tributárias e trabalhistas.\n- Fornecer serviços de qualidade, conforme descrito nas ofertas de trabalho.\n- Não violar os direitos de terceiros, incluindo, mas não se limitando a, direitos de propriedade intelectual e de privacidade.\n- Respeitar a privacidade e os dados pessoais dos clientes, conforme a LGPD.\n\n6. Remuneração e Pagamento\n\nO valor e as condições de pagamento dos serviços prestados serão estabelecidos diretamente entre o Usuário e o cliente. O HELP pode oferecer soluções de pagamento, mas não é responsável por inadimplência ou questões relacionadas ao pagamento.\n\n7. Proteção de Dados e Privacidade\n\nO HELP se compromete a proteger os dados pessoais dos Usuários, conforme a Lei Geral de Proteção de Dados (Lei nº 13.709/2018). A coleta e o tratamento de dados ocorrerão para fins específicos, legítimos e informados previamente ao Usuário.\n\n7.1. Finalidade do Tratamento de Dados\n\nO Aplicativo coleta e trata dados pessoais dos Usuários para:\n- Viabilizar o funcionamento da plataforma e conectar trabalhadores e clientes.\n- Realizar análises e melhorias no serviço oferecido.\n- Cumprir com obrigações legais e regulatórias.\n\n7.2. Compartilhamento de Dados\n\nOs dados pessoais do Usuário podem ser compartilhados com terceiros apenas quando necessário para a execução dos serviços ou conforme exigido por lei.\n\n7.3. Direitos dos Usuários\n\nO Usuário tem o direito de acessar, corrigir, excluir e solicitar a portabilidade dos seus dados pessoais, conforme previsto na LGPD. Para exercer esses direitos, entre em contato com nossa equipe de suporte.\n\n8. Propriedade Intelectual\n\nO conteúdo e as funcionalidades do Aplicativo, incluindo logotipos, marcas, textos e imagens, são de propriedade exclusiva da HELP Tecnologia Ltda. ou licenciados para seu uso. O uso indevido de qualquer propriedade intelectual é proibido e sujeitará o infrator às penalidades cabíveis.\n\n9. Isenção de Responsabilidade\n\nO HELP não se responsabiliza por:\n- Qualquer dano ou prejuízo resultante da relação entre o Usuário e o cliente.\n- Inadimplência ou litígios que possam surgir durante ou após a prestação de serviços.\n- Falhas técnicas que possam interromper temporariamente o funcionamento do Aplicativo.\n\n10. Legislação Aplicável e Foro\n\nEstes Termos e Condições são regidos pelas leis da República Federativa do Brasil, incluindo a Lei Geral de Proteção de Dados (LGPD) e a legislação trabalhista aplicável aos trabalhadores autônomos. Qualquer disputa relacionada ao uso do Aplicativo será submetida ao foro da Comarca de [Cidade], Estado de [Estado], com renúncia a qualquer outro, por mais privilegiado que seja.\n\n11. Alterações nos Termos\n\nA HELP Tecnologia Ltda. se reserva o direito de modificar estes Termos e Condições a qualquer momento, mediante aviso prévio ao Usuário. O uso contínuo do Aplicativo após tais alterações será considerado como aceitação das mesmas.\n\n12. Contato\n\nEm caso de dúvidas ou solicitações relacionadas a estes Termos e Condições ou à proteção de dados, o Usuário pode entrar em contato através do e-mail: [helpapp@company.com].\n',
      'en':
          '1. Introduction\n\nWelcome to HELP (\"Application\"), a platform developed by HELP Tecnologia Ltda. (\"Company\") to connect self-employed workers (\"Users\") with clients and job opportunities. By using the Application, you agree to the following Terms and Conditions of Use. Please read them carefully before using our services.\n\n2. Acceptance of Terms\n\nBy registering on the Application, the User declares to have read and fully accepted the Terms and Conditions established herein. If the User does not agree with any clause, it is recommended that they stop using it immediately.\n\n3. Registration and User Account\n\nTo use the Application services, the User must:\n\n- Provide true, complete and updated information.\n\n- Be over 18 years of age or be duly authorized by their legal guardians.\n\n- Maintain the security and confidentiality of their access credentials.\n\n4. Services Offered\n\nThe Application acts as a digital intermediary between freelancers and clients, facilitating the contracting of services directly between the parties. HELP is not an employer of Users and offers no guarantees regarding the quality or completion of the services provided.\n\n5. User Responsibilities\n\nThe User undertakes to:\n\n- Comply with all applicable laws, including tax and labor laws.\n\n- Provide quality services, as described in the job offers.\n\n- Not violate the rights of third parties, including, but not limited to, intellectual property and privacy rights.\n\n- Respect the privacy and personal data of clients, in accordance with the LGPD.\n\n6. Remuneration and Payment\n\nThe value and payment conditions for the services provided will be established directly between the User and the client. HELP may offer payment solutions, but is not responsible for default or payment-related issues.\n\n7. Data Protection and Privacy\n\nHELP is committed to protecting Users\' personal data, in accordance with the General Data Protection Law (Law No. 13,709/2018). Data collection and processing will occur for specific, legitimate purposes and previously informed to the User.\n\n7.1. Purpose of Data Processing\n\nThe Application collects and processes Users\' personal data to:\n\n- Enable the operation of the platform and connect workers and customers.\n\n- Perform analyses and improvements in the service offered.\n\n- Comply with legal and regulatory obligations.\n\n7.2. Data Sharing\n\nThe User\'s personal data may be shared with third parties only when necessary for the execution of the services or as required by law.\n\n7.3. User Rights\n\nThe User has the right to access, correct, delete and request the portability of their personal data, as provided for in the LGPD. To exercise these rights, please contact our support team.\n\n8. Intellectual Property\n\nThe content and features of the Application, including logos, brands, texts and images, are the exclusive property of HELP Tecnologia Ltda. or licensed for its use. The improper use of any intellectual property is prohibited and will subject the offender to the applicable penalties.\n\n9. Disclaimer\n\nHELP is not responsible for:\n\n- Any damage or loss resulting from the relationship between the User and the client.\n\n- Default or disputes that may arise during or after the provision of services.\n\n- Technical failures that may temporarily interrupt the operation of the Application.\n\n10. Applicable Law and Jurisdiction\n\nThese Terms and Conditions are governed by the laws of the Federative Republic of Brazil, including the General Data Protection Law (LGPD) and the labor legislation applicable to self-employed workers. Any dispute related to the use of the Application will be submitted to the jurisdiction of the District of [City], State of [State], waiving any other jurisdiction, however privileged it may be. \n\n11. Changes to the Terms \n\nHELP Tecnologia Ltda. reserves the right to modify these Terms and Conditions at any time, upon prior notice to the User. Continued use of the Application after such changes will be considered acceptance of the same. \n\n12. Contact \n\nIn case of questions or requests related to these Terms and Conditions or data protection, the User may contact us via email: [helpapp@company.com].',
      'es': '',
    },
    'vm7xiavn': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Menu
  {
    'iha171hp': {
      'pt': 'Conta',
      'en': 'Account',
      'es': 'Cuenta',
    },
    'fg32r125': {
      'pt': 'Conta',
      'en': 'Account',
      'es': 'Cuenta',
    },
    'iszfhnir': {
      'pt': 'Configurações',
      'en': 'Settings',
      'es': 'Ajustes',
    },
    '4jcxhdqa': {
      'pt': 'País',
      'en': 'Country',
      'es': 'País',
    },
    'yhf9dtph': {
      'pt': 'Configuração de notificações',
      'en': 'Notifications configuration',
      'es': 'Configuración de notificaciones',
    },
    'uu7cgim6': {
      'pt': 'Geral',
      'en': 'General',
      'es': 'General',
    },
    'e1uy561i': {
      'pt': 'Suporte',
      'en': 'Support',
      'es': 'Apoyo',
    },
    '6x66fn29': {
      'pt': 'Termos de serviço',
      'en': 'Terms of Service',
      'es': 'Términos de servicio',
    },
    'gh6fmhuf': {
      'pt': 'Convide amigos',
      'en': 'Invite friends',
      'es': 'Invitar amigos',
    },
    '89csx84h': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // Notifications
  {
    'dut2yrds': {
      'pt': 'Procurando por serviços? Clique aqui',
      'en': 'Looking for services? Click here',
      'es': '¿Busca servicios? haga clic aquí',
    },
    'mlr5jh7x': {
      'pt': '24/09/2024',
      'en': '09/24/2024',
      'es': '24/09/2024',
    },
    '6p9jrg5e': {
      'pt': 'Você possui mensagem não lidas',
      'en': 'You have unread messages',
      'es': 'Tienes mensajes sin leer',
    },
    'sht5ul8j': {
      'pt': '23/09/2024',
      'en': '09/23/2024',
      'es': '23/09/2024',
    },
    'yghsqfbf': {
      'pt': 'Adilson Miau te mandou mensagem',
      'en': 'Adilson Miau sent you a message',
      'es': 'Adilson Miau te envió un mensaje',
    },
    'sn8omagb': {
      'pt': '22/09/2024',
      'en': '09/22/2024',
      'es': '22/09/2024',
    },
    'jqqfyfty': {
      'pt': 'Temos ofertas imperdíveis',
      'en': 'We have unmissable offers',
      'es': 'Tenemos ofertas imperdibles',
    },
    'umiv8os6': {
      'pt': 'Mar 8, 2022',
      'en': 'Mar 8, 2022',
      'es': '8 de marzo de 2022',
    },
    'w3z7ofme': {
      'pt': 'Quer se tornar HELP? Clique aqui',
      'en': 'Want to become a HELP? Click here',
      'es': '¿Quieres convertirte en HELP? haga clic aquí',
    },
    '3pt4rezu': {
      'pt': 'Mar 8, 2022',
      'en': 'Mar 8, 2022',
      'es': '8 de marzo de 2022',
    },
    'uajaoay2': {
      'pt': 'Notificações',
      'en': 'Notifications',
      'es': 'Notificaciones',
    },
    'ocffzgw9': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // EditarPerfil
  {
    'g49pkwez': {
      'pt': 'Editar perfil',
      'en': 'Edit profile',
      'es': 'Editar perfil',
    },
    'if1a9uhj': {
      'pt': 'Alterar foto de perfil',
      'en': 'Change profile picture',
      'es': 'Cambiar foto de perfil',
    },
    'kegg0l7e': {
      'pt': 'Alterar suas informações',
      'en': 'Change your information',
      'es': 'Cambia tu información',
    },
    'epok1pei': {
      'pt': 'Informações da conta',
      'en': 'Account Information',
      'es': 'Información de la cuenta',
    },
    '0a80gd9p': {
      'pt': 'Endereço',
      'en': 'Address',
      'es': 'Dirección',
    },
    'v5sxwtm0': {
      'pt': 'Informações de pagamento',
      'en': 'Payment Information',
      'es': 'Información de pago',
    },
    't97pekzf': {
      'pt': 'Definições da conta',
      'en': 'Account Settings',
      'es': 'Configuraciones de la cuenta',
    },
    'tpede38x': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Chat
  {
    '1l8pvitn': {
      'pt': 'Mensagens',
      'en': 'Messages',
      'es': 'Mensajes',
    },
    'w1vzp5ts': {
      'pt': 'Pesquisar',
      'en': 'Search',
      'es': 'Buscar',
    },
    'jsb6f1st': {
      'pt': 'Pedro Henrique',
      'en': 'Pedro Henrique',
      'es': 'Pedro Henrique',
    },
    'd35uk5f2': {
      'pt': 'To te perguntando cara, cade minha....',
      'en': 'I\'m asking you man, where\'s my....',
      'es': 'Te pregunto hombre, ¿dónde está el mío?...',
    },
    'osmvcdxe': {
      'pt': 'Pedro Henrique',
      'en': 'Pedro Henrique',
      'es': 'Pedro Henrique',
    },
    'eyp7oev1': {
      'pt': 'To te perguntando cara, cade minha....',
      'en': 'I\'m asking you man, where\'s my....',
      'es': 'Te pregunto hombre, ¿dónde está el mío?...',
    },
    '6osngz0m': {
      'pt': 'Pedro Henrique',
      'en': 'Pedro Henrique',
      'es': 'Pedro Henrique',
    },
    'vw0q6b5a': {
      'pt': 'To te perguntando cara, cade minha....',
      'en': 'I\'m asking you man, where\'s my....',
      'es': 'Te pregunto hombre, ¿dónde está el mío?...',
    },
    'x22k6cd2': {
      'pt': 'Pedro Henrique',
      'en': 'Pedro Henrique',
      'es': 'Pedro Henrique',
    },
    '4gapiycg': {
      'pt': 'To te perguntando cara, cade minha....',
      'en': 'I\'m asking you man, where\'s my....',
      'es': 'Te pregunto hombre, ¿dónde está el mío?...',
    },
    '7bsmta3g': {
      'pt': 'Pedro Henrique',
      'en': 'Pedro Henrique',
      'es': 'Pedro Henrique',
    },
    'effxys1p': {
      'pt': 'To te perguntando cara, cade minha....',
      'en': 'I\'m asking you man, where\'s my....',
      'es': 'Te pregunto hombre, ¿dónde está el mío?...',
    },
    'ryp97baq': {
      'pt': 'Pedro Henrique',
      'en': 'Pedro Henrique',
      'es': 'Pedro Henrique',
    },
    '20uss8w0': {
      'pt': 'To te perguntando cara, cade minha....',
      'en': 'I\'m asking you man, where\'s my....',
      'es': 'Te pregunto hombre, ¿dónde está el mío?...',
    },
    '9d46mtqn': {
      'pt': 'Pedro Henrique',
      'en': 'Pedro Henrique',
      'es': 'Pedro Henrique',
    },
    'g3lpapdu': {
      'pt': 'To te perguntando cara, cade minha....',
      'en': 'I\'m asking you man, where\'s my....',
      'es': 'Te pregunto hombre, ¿dónde está el mío?...',
    },
    'tqmzylat': {
      'pt': 'Pedro Henrique',
      'en': 'Pedro Henrique',
      'es': 'Pedro Henrique',
    },
    'a06tsck3': {
      'pt': 'To te perguntando cara, cade minha....',
      'en': 'I\'m asking you man, where\'s my....',
      'es': 'Te pregunto hombre, ¿dónde está el mío?...',
    },
    '21yh3csv': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // Home
  {
    'jly34po3': {
      'pt': 'HELP APP',
      'en': 'HELP APP',
      'es': 'HELP APP',
    },
    '1sfbblrk': {
      'pt': 'Adilson Miau',
      'en': 'Adilson Miau',
      'es': 'Adilson Miau',
    },
    'm6h9lfx8': {
      'pt': 'Perfil',
      'en': 'Profile',
      'es': 'Perfil',
    },
    'jw4rxvor': {
      'pt': 'Avaliações',
      'en': 'Reviews',
      'es': 'Reseñas',
    },
    '3u8s2wqk': {
      'pt': 'Convidar amigos',
      'en': 'Invite friends',
      'es': 'Invitar amigos',
    },
    '0muwd7fw': {
      'pt': 'Avalie nosso app',
      'en': 'Rate our app',
      'es': 'Califica nuestra app',
    },
    'u7x2wk7j': {
      'pt': 'Termos e condições',
      'en': 'Terms and conditions',
      'es': 'Términos y condiciones',
    },
    'qzkygv7w': {
      'pt': 'Vire HELP Pro',
      'en': 'Go HELP Pro',
      'es': 'Convierte HELP Pro',
    },
    'xdregfb6': {
      'pt': 'Configurações',
      'en': 'Settings',
      'es': 'Ajustes',
    },
    'yt2e8xqn': {
      'pt': 'Suporte HELP',
      'en': 'HELP Support',
      'es': 'HELP soporte',
    },
    '9zv5tyd4': {
      'pt': 'Site oficial HELP',
      'en': 'HELP Official Website',
      'es': 'HELP sitio web oficial',
    },
    'nud6p8ef': {
      'pt': 'Selecione seu local',
      'en': 'Select your location',
      'es': 'Selecciona tu ubicación',
    },
    '82rkmoso': {
      'pt': 'Categorias mais pesquisadas',
      'en': 'Most searched categories',
      'es': 'Categorías más buscadas',
    },
    'rcl4ems1': {
      'pt': 'Eletricista',
      'en': 'Electrician',
      'es': 'Electricista',
    },
    'god5joli': {
      'pt': 'Encanador',
      'en': 'Plumber',
      'es': 'Plomero',
    },
    'rci54gof': {
      'pt': 'Mecânico',
      'en': 'Mechanic',
      'es': 'Mecánico',
    },
    'vzqj9ebj': {
      'pt': 'Limpeza',
      'en': 'Cleaning',
      'es': 'Limpieza',
    },
    '29s3wgwd': {
      'pt': 'Informática',
      'en': 'Computing',
      'es': 'Computación',
    },
    '08y6owp4': {
      'pt': 'Serviço marcado:',
      'en': 'Service scheduled:',
      'es': 'Servicio marcado:',
    },
    'j32btuvj': {
      'pt': 'Pedrão Scrum',
      'en': 'Pedro Scrum',
      'es': 'Pedro Scrum',
    },
    'pk2sup5c': {
      'pt': 'Pedreiro / Faz tudo',
      'en': 'Mason / Handyman',
      'es': 'Albañil / Manitas',
    },
    'zkav3yet': {
      'pt': 'Nov',
      'en': 'Nov',
      'es': 'Nov',
    },
    'zso3u1xw': {
      'pt': '23',
      'en': '23',
      'es': '23',
    },
    'k6kv40vy': {
      'pt': 'Serviço marcado:',
      'en': 'Service scheduled:',
      'es': 'Servicio marcado:',
    },
    'm6ieez35': {
      'pt': 'Adailton Santos',
      'en': 'Adailton Santos',
      'es': 'Adailton Santos',
    },
    '63c4sk4a': {
      'pt': 'Pedreiro / Faz tudo',
      'en': 'Mason / Handyman',
      'es': 'Albañil / Manitas',
    },
    'of0irl1h': {
      'pt': 'Mar',
      'en': 'Sea',
      'es': 'Mar',
    },
    'kfqc75ox': {
      'pt': '19',
      'en': '19',
      'es': '19',
    },
    'ypbqj82u': {
      'pt': 'Serviço marcado:',
      'en': 'Service scheduled:',
      'es': 'Servicio marcado:',
    },
    'tr1hgktv': {
      'pt': 'Ednaldo',
      'en': 'Ednaldo',
      'es': 'Ednaldo',
    },
    'ws21ojc2': {
      'pt': 'Pedreiro / Faz tudo',
      'en': 'Mason / Handyman',
      'es': 'Albañil / Manitas',
    },
    'jyi2y5my': {
      'pt': 'Nov',
      'en': 'Nov',
      'es': 'Nov',
    },
    'uzatlwcf': {
      'pt': '23',
      'en': '23',
      'es': '23',
    },
    '30g2fhoz': {
      'pt': 'Serviço marcado:',
      'en': 'Service scheduled:',
      'es': 'Servicio marcado:',
    },
    'esz1g00x': {
      'pt': 'Alexandre',
      'en': 'Alexander',
      'es': 'Alejandro',
    },
    '54kg3dy4': {
      'pt': 'Técnico de informática',
      'en': 'Computer technician',
      'es': 'técnico de TI',
    },
    '7z73xule': {
      'pt': 'Dez',
      'en': 'Dec',
      'es': 'Dic',
    },
    'h9buwydn': {
      'pt': '12',
      'en': '12',
      'es': '12',
    },
    'wpzwov2j': {
      'pt': 'Empresas patrocinadas',
      'en': 'Sponsored companies',
      'es': 'Empresas patrocinadas',
    },
    'rjcmokdt': {
      'pt': 'Autônomos patrocinados',
      'en': 'Sponsored freelancers',
      'es': 'Autónomos patrocinados',
    },
    'w8ephaw5': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // SeuPerfil
  {
    'pb90yke7': {
      'pt': 'Faz tudo',
      'en': 'Do it all',
      'es': 'Hace de todo',
    },
    'ogmof5j0': {
      'pt': 'Adilson Miau',
      'en': 'Adilson Miau',
      'es': 'Adilson Miau',
    },
    'm2d5jr3q': {
      'pt': 'sem tela',
      'en': 'no screen',
      'es': 'sin pantalla',
    },
    'bcc3h85e': {
      'pt': 'Editar seu perfil',
      'en': 'Edit your profile',
      'es': 'Edita tu perfil',
    },
    'fezpe5os': {
      'pt': 'Sua bio',
      'en': 'Your bio',
      'es': 'Tu biografía',
    },
    'nxd3l2tf': {
      'pt':
          'Adilson um renomado cientista da computação formado pela prestigiada Universidade de Mogi das Cruzes, é conhecido não apenas por suas habilidades técnicas excepcionais, mas também por um episódio particularmente cômico que se tornou lendário entre seus colegas e professores. Durante uma apresentação crucial sobre cibersegurança em uma universidade, Adilson, com sua habitual dedicação e atenção aos detalhes, preparou um projeto inovador que prometia impressionar a todos. No entanto, em um momento de distração ou talvez devido a um capricho do destino, ele se viu em uma situação inusitada: a tela de sua apresentação simplesmente desapareceu. Por horas a fio, Adilson, visivelmente confuso e um tanto desesperado, repetia incessantemente a pergunta que ecoaria pelos corredores da universidade: \"Cadê a tela?\". A cena, quase surreal, de um cientista tão brilhante perdido em busca de sua tela, arrancou risadas e se tornou uma anedota clássica, lembrada com carinho e humor por todos que tiveram o privilégio de testemunhar aquele dia memorável.',
      'en':
          'Adilson, a renowned computer scientist who graduated from the prestigious University of Mogi das Cruzes, is known not only for his exceptional technical skills, but also for a particularly comical episode that has become legendary among his colleagues and professors. During a crucial presentation on cybersecurity at a university, Adilson, with his usual dedication and attention to detail, prepared an innovative project that promised to impress everyone. However, in a moment of distraction or perhaps due to a whim of fate, he found himself in an unusual situation: the screen of his presentation simply disappeared. For hours on end, Adilson, visibly confused and somewhat desperate, incessantly repeated the question that would echo through the university corridors: \"Where is the screen?\". The almost surreal scene of such a brilliant scientist lost in search of his screen drew laughter and became a classic anecdote, remembered fondly and humorously by all who had the privilege of witnessing that memorable day.',
      'es':
          'Adilson, un reconocido informático graduado de la prestigiosa Universidad de Mogi das Cruzes, es conocido no sólo por sus excepcionales habilidades técnicas, sino también por un episodio particularmente cómico que se ha vuelto legendario entre sus colegas y profesores. Durante una presentación crucial sobre ciberseguridad en una universidad, Adilson, con su habitual dedicación y atención al detalle, preparó un proyecto innovador que prometía impresionar a todos. Sin embargo, en un momento de distracción o quizás por un capricho del destino, se encontró en una situación inusual: su pantalla de presentación simplemente desapareció. Durante horas y horas, Adilson, visiblemente confuso y algo desesperado, repetía sin cesar la pregunta que resonaba por los pasillos de la universidad: \"¿Dónde está la pantalla?\". La escena casi surrealista de tan brillante científico perdido en busca de su lienzo, provocó risas y se convirtió en una anécdota clásica, recordada con cariño y humor por todos los que tuvieron el privilegio de presenciar aquel memorable día.',
    },
    '14njnzar': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Questao1
  {
    'k22qfmu8': {
      'pt': 'Questão 1/5',
      'en': 'Question 1/5',
      'es': 'Pregunta 1/5',
    },
    '5ircv3l8': {
      'pt': 'O que achou dos temas e funções que o aplicativo oferece?',
      'en':
          'What did you think of the themes and functions that the application offers?',
      'es':
          '¿Qué te parecieron los temas y funciones que ofrece la aplicación?',
    },
    'gvi2b7py': {
      'pt': 'Todas as ferramentas e opções de uso foram úteis?',
      'en': 'Were all the tools and usage options useful?',
      'es': '¿Fueron útiles todas las herramientas y opciones de uso?',
    },
    '4qlkkfzv': {
      'pt': 'Incrível  😇',
      'en': 'Amazing 😇',
      'es': 'Increíble 😇',
    },
    'md6k67a1': {
      'pt': 'Ótimo 😃',
      'en': 'Great 😃',
      'es': 'Genial 😃',
    },
    'vfthl3x7': {
      'pt': 'Bom 🙂',
      'en': 'Good 🙂',
      'es': 'Bueno 🙂',
    },
    'w4ah5ytr': {
      'pt': 'Regular 😕',
      'en': 'Regular 😕',
      'es': 'Regular 😕',
    },
    '9gf8zl00': {
      'pt': 'Horrível 😞',
      'en': 'Horrible 😞',
      'es': 'Horrible 😞',
    },
    '1le2gmx4': {
      'pt': 'Próxima questão',
      'en': 'Next question',
      'es': 'Siguiente pregunta',
    },
    '0baq7isv': {
      'pt': 'Nos avalie!',
      'en': 'Rate us!',
      'es': '¡Califícanos!',
    },
    'fji698yv': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Questao2
  {
    'nfjfajr9': {
      'pt': 'Questão 2/5',
      'en': 'Question 2/5',
      'es': 'Pregunta 2/5',
    },
    'w7b2bt0o': {
      'pt': 'Como está sendo a sua experiência no aplicativo?',
      'en': 'How is your experience with the app?',
      'es': '¿Cómo es tu experiencia en la aplicación?',
    },
    '8g3h0yck': {
      'pt': 'Teve problemas na utilização e navegação no aplicativo?',
      'en': 'Did you have any problems using and navigating the app?',
      'es': '¿Tuviste problemas para usar y navegar por la aplicación?',
    },
    'mknhcoew': {
      'pt': 'Incrível  😇',
      'en': 'Amazing 😇',
      'es': 'Increíble 😇',
    },
    '3gq6swtl': {
      'pt': 'Ótimo 😃',
      'en': 'Great 😃',
      'es': 'Genial 😃',
    },
    'x4o0v468': {
      'pt': 'Bom 🙂',
      'en': 'Good 🙂',
      'es': 'Bueno 🙂',
    },
    'bah0yaw6': {
      'pt': 'Regular 😕',
      'en': 'Regular 😕',
      'es': 'Regular 😕',
    },
    'fbxdo6e4': {
      'pt': 'Horrível 😞',
      'en': 'Horrible 😞',
      'es': 'Horrible 😞',
    },
    'jcr148vr': {
      'pt': 'Próxima questão',
      'en': 'Next question',
      'es': 'Siguiente pregunta',
    },
    'xgoj99y7': {
      'pt': 'Nos avalie!',
      'en': 'Rate us!',
      'es': '¡Califícanos!',
    },
    '3eb2v1j4': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Questao3
  {
    '32umpowd': {
      'pt': 'Nos avalie!',
      'en': 'Rate us!',
      'es': '¡Califícanos!',
    },
    'leqe63ys': {
      'pt': 'Questão 3/5',
      'en': 'Question 3/5',
      'es': 'Pregunta 3/5',
    },
    '3rdmovda': {
      'pt': 'Como foi sua experiência com os demais usuários?',
      'en': 'How was your experience with other users?',
      'es': '¿Cómo fue tu experiencia con otros usuarios?',
    },
    'eesw74qa': {
      'pt': 'Teve problemas com os usuários?',
      'en': 'Have you had any problems with users?',
      'es': '¿Tuviste problemas con los usuarios?',
    },
    '9ebygsnp': {
      'pt': 'Incrível  😇',
      'en': 'Amazing 😇',
      'es': 'Increíble 😇',
    },
    'zw8uitm0': {
      'pt': 'Ótimo 😃',
      'en': 'Great 😃',
      'es': 'Genial 😃',
    },
    'fqee1uac': {
      'pt': 'Bom 🙂',
      'en': 'Good 🙂',
      'es': 'Bueno 🙂',
    },
    'v167vauz': {
      'pt': 'Regular 😕',
      'en': 'Regular 😕',
      'es': 'Regular 😕',
    },
    'hdtu27rz': {
      'pt': 'Horrível 😞',
      'en': 'Horrible 😞',
      'es': 'Horrible 😞',
    },
    '8gsx423r': {
      'pt': 'Próxima questão',
      'en': 'Next question',
      'es': 'Siguiente pregunta',
    },
    'y32a7wtj': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Questao4
  {
    'sb1ay3zr': {
      'pt': 'Nos avalie!',
      'en': 'Rate us!',
      'es': '¡Califícanos!',
    },
    '8yfzcy74': {
      'pt': 'Questão 4/5',
      'en': 'Question 4/5',
      'es': 'Pregunta 4/5',
    },
    'j7pjwa0v': {
      'pt':
          'Como foi sua experiência contratando/prestando serviços no aplicativo?',
      'en': 'How was your experience hiring/providing services on the app?',
      'es':
          '¿Cómo fue tu experiencia contratando/prestando servicios en la aplicación?',
    },
    '41nyjs82': {
      'pt': 'Teve problemas com contratação ou prestação de serviços?',
      'en': 'Have you had problems with hiring or providing services?',
      'es': '¿Tuviste problemas con la contratación o prestación de servicios?',
    },
    '7y1063br': {
      'pt': 'Incrível  😇',
      'en': 'Amazing 😇',
      'es': 'Increíble 😇',
    },
    'mffyqqwz': {
      'pt': 'Ótimo 😃',
      'en': 'Great 😃',
      'es': 'Genial 😃',
    },
    't5uiikk4': {
      'pt': 'Bom 🙂',
      'en': 'Good 🙂',
      'es': 'Bueno 🙂',
    },
    '2c8ummr3': {
      'pt': 'Regular 😕',
      'en': 'Regular 😕',
      'es': 'Regular 😕',
    },
    '7xxncl5z': {
      'pt': 'Horrível 😞',
      'en': 'Horrible 😞',
      'es': 'Horrible 😞',
    },
    '3tw4diho': {
      'pt': 'Próxima questão',
      'en': 'Next question',
      'es': 'Siguiente pregunta',
    },
    '49uz3bkx': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Questao5
  {
    'jpa76owp': {
      'pt': 'Nos avalie!',
      'en': 'Rate us!',
      'es': '¡Califícanos!',
    },
    'uimkmjd2': {
      'pt': 'Questão 5/5',
      'en': 'Question 5/5',
      'es': 'Pregunta 5/5',
    },
    'ur1rc3wd': {
      'pt': 'Escreva sua opinião sobre o aplicativo?',
      'en': 'Write your review about the app?',
      'es': '¿Escribe tu opinión sobre la aplicación?',
    },
    'j1lz5s8e': {
      'pt': 'Teve problemas com contratação ou prestação de serviços?',
      'en': 'Have you had problems with hiring or providing services?',
      'es': '¿Tuviste problemas con la contratación o prestación de servicios?',
    },
    'etzrhb2q': {
      'pt': 'Digite aqui',
      'en': 'Type here',
      'es': 'Escribe aquí',
    },
    'cbrutj8u': {
      'pt': 'Avançar',
      'en': 'Forward',
      'es': 'Próximo',
    },
    'ebw602ep': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Settings
  {
    '1acl1pyr': {
      'pt': 'Configurações',
      'en': 'Settings',
      'es': 'Ajustes',
    },
    'ezwi02sb': {
      'pt': 'Tutorial',
      'en': 'Tutorial',
      'es': 'Tutorial',
    },
    'x12c2uqg': {
      'pt': 'Fale conosco',
      'en': 'Contact us',
      'es': 'Contáctenos',
    },
    'reozlzev': {
      'pt': 'Ajuda',
      'en': 'Help',
      'es': 'Ayuda',
    },
    'yn4vg96a': {
      'pt': 'Política de privacidade',
      'en': 'Privacy Policy',
      'es': 'política de privacidad',
    },
    'koy27htt': {
      'pt': 'Termos e condições',
      'en': 'Terms and conditions',
      'es': 'Términos y condiciones',
    },
    '45f890ra': {
      'pt': 'Nos siga em nossas redes sociais',
      'en': 'Follow us on our social networks',
      'es': 'Síguenos en nuestras redes sociales',
    },
    'lbo9ukzi': {
      'pt': 'Selecione seu idioma',
      'en': 'Select your language',
      'es': 'Selecciona tu idioma',
    },
    'ir33g0fm': {
      'pt': 'Alterar tema',
      'en': 'Change theme',
      'es': 'Cambiar tema',
    },
    'uvme1tye': {
      'pt': 'Versão de aplicativo:',
      'en': 'App version:',
      'es': 'Versión de la aplicación:',
    },
    'bb21a40v': {
      'pt': 'HELPbeta_ver0.0.1',
      'en': 'HELPbeta_ver0.0.1',
      'es': 'HELPbeta_ver0.0.1',
    },
    'ndar4sf6': {
      'pt': 'HELP™App',
      'en': 'HELP™App',
      'es': 'Aplicación HELP™',
    },
    'fq1xjbke': {
      'pt': 'Todos os direitos reservados',
      'en': 'All rights reserved',
      'es': 'Reservados todos los derechos',
    },
    '9w0v8brg': {
      'pt': 'Sair',
      'en': 'Log Out',
      'es': 'Salir',
    },
    '1sejj6z0': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // Obrigado
  {
    '630py8kn': {
      'pt': 'Nos avalie!',
      'en': 'Rate us!',
      'es': '¡Califícanos!',
    },
    'yawqzf87': {
      'pt': 'Obrigado!',
      'en': 'Thanks!',
      'es': '¡Gracias!',
    },
    'zex7608e': {
      'pt': 'A sua opinião é muito importante para nós!',
      'en': 'Your opinion is very important to us!',
      'es': '¡Tu opinión es muy importante para nosotros!',
    },
    'tisgwcqc': {
      'pt': 'Finalizar',
      'en': 'Finish',
      'es': 'Finalizar',
    },
    'skccmt94': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // CadastroEmpresa
  {
    'juc6f49a': {
      'pt': 'Insira os dados da sua empresa',
      'en': 'Enter your company details',
      'es': 'Introduce los datos de tu empresa',
    },
    'axu1edqs': {
      'pt': 'Nome da empresa',
      'en': 'Company name',
      'es': 'Nombre de empresa',
    },
    '6no5r2zo': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'nyb1vm1f': {
      'pt': 'CNPJ',
      'en': 'CNPJ',
      'es': 'CNPJ',
    },
    't8ii1vcl': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'f3f338yk': {
      'pt': 'Categoria de serviço',
      'en': 'Service category',
      'es': 'Categoría de servicio',
    },
    '1ve7riqe': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '1q99ndc3': {
      'pt': 'Insira seu endereço',
      'en': 'Enter your address',
      'es': 'Introduce tu dirección',
    },
    '1t67gr6x': {
      'pt': 'CEP',
      'en': 'CEP',
      'es': 'código postal',
    },
    'ndkf4w92': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '5logxko5': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'zd2sb46g': {
      'pt': 'Estado',
      'en': 'State',
      'es': 'Estado',
    },
    'j4o9bxuk': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'nm9dxsp2': {
      'pt': 'Acre',
      'en': 'Acre',
      'es': 'Acre',
    },
    'd53rkx7v': {
      'pt': 'Alagoas',
      'en': 'Alagoas',
      'es': 'Alagoas',
    },
    'w8ctnma2': {
      'pt': 'Amapá',
      'en': 'Amapá',
      'es': 'Amapá',
    },
    'jkgzov44': {
      'pt': 'Amazonas',
      'en': 'Amazonas',
      'es': 'Amazonas',
    },
    'sr2622b1': {
      'pt': 'Bahia',
      'en': 'Bahia',
      'es': 'Bahía',
    },
    'zn190eqq': {
      'pt': 'Ceará',
      'en': 'Ceará',
      'es': 'Ceará',
    },
    'hpd5kixn': {
      'pt': 'Distrito Federal',
      'en': 'Distrito Federal',
      'es': 'Distrito Federal',
    },
    'buia5gg2': {
      'pt': 'Espírito Santo',
      'en': 'Espírito Santo',
      'es': 'Espírito Santo',
    },
    'nxwcn5ma': {
      'pt': 'Goiás',
      'en': 'Goiás',
      'es': 'Goiás',
    },
    'hnqbcn47': {
      'pt': 'Maranhão',
      'en': 'Maranhão',
      'es': 'Maranhão',
    },
    '230gkpe4': {
      'pt': 'Mato Grosso',
      'en': 'Mato Grosso',
      'es': 'Mato Grosso',
    },
    'nglvr6gm': {
      'pt': 'Mato Grosso do Sul',
      'en': 'Mato Grosso do Sul',
      'es': 'Mato Grosso do Sul',
    },
    'zzlmnrkm': {
      'pt': 'Minas Gerais',
      'en': 'Minas Gerais',
      'es': 'Minas Gerais',
    },
    'yheiednp': {
      'pt': 'Pará',
      'en': 'Pará',
      'es': 'Pará',
    },
    'w7rz1g0f': {
      'pt': 'Paraíba',
      'en': 'Paraíba',
      'es': 'Paraíba',
    },
    'eqt3is1q': {
      'pt': 'Paraná',
      'en': 'Paraná',
      'es': 'Paraná',
    },
    '5pv53rwo': {
      'pt': 'Pernambuco',
      'en': 'Pernambuco',
      'es': 'Pernambuco',
    },
    '82cff415': {
      'pt': 'Piauí',
      'en': 'Piauí',
      'es': 'Piauí',
    },
    '16ger76h': {
      'pt': 'Rio  de Janeiro',
      'en': 'Rio de Janeiro',
      'es': 'Río de Janeiro',
    },
    'kpy76i1r': {
      'pt': 'Rio Grande do Norte',
      'en': 'Rio Grande do Norte',
      'es': 'Río Grande del Norte',
    },
    'i0vd8r9v': {
      'pt': 'Rio Grande do Sul',
      'en': 'Rio Grande do Sul',
      'es': 'Río Grande do Sul',
    },
    '6xiruvuq': {
      'pt': 'Rondônia',
      'en': 'Rondônia',
      'es': 'Rondônia',
    },
    'cs4l396h': {
      'pt': 'Roraima',
      'en': 'Roraima',
      'es': 'Roraima',
    },
    '5yufy5my': {
      'pt': 'Santa Catarina',
      'en': 'Santa Catarina',
      'es': 'Santa Catarina',
    },
    's2wnhq52': {
      'pt': 'São Paulo',
      'en': 'São Paulo',
      'es': 'São Paulo',
    },
    'vh7ja8m7': {
      'pt': 'Sergipe',
      'en': 'Sergipe',
      'es': 'Sergipe',
    },
    'jbzqr2ke': {
      'pt': 'Tocantins',
      'en': 'Tocantins',
      'es': 'Tocantins',
    },
    '2wkmp8rz': {
      'pt': 'Cidade',
      'en': 'City',
      'es': 'Ciudad',
    },
    'iq6qzawv': {
      'pt': 'Endereço',
      'en': 'Address',
      'es': 'Dirección',
    },
    'i4cr26df': {
      'pt': 'Número',
      'en': 'Number',
      'es': 'Número',
    },
    '6upqb36p': {
      'pt': 'Complemento',
      'en': 'Complement',
      'es': 'Complementar',
    },
    'c9agfdcr': {
      'pt': 'Ponto de referência',
      'en': 'Reference point',
      'es': 'Punto de referencia',
    },
    'li0alirm': {
      'pt': 'Declaro que li concordo com os\n',
      'en': 'I declare that I have read and agree with the',
      'es': 'Declaro que he leído y estoy de acuerdo con las',
    },
    's2ka1jdt': {
      'pt': 'termos e condições ',
      'en': 'terms and conditions',
      'es': 'Términos y condiciones',
    },
    '44dpfv5f': {
      'pt': 'da HELP',
      'en': 'from HELP',
      'es': 'de HELP',
    },
    'wctgoxhc': {
      'pt': 'Criar conta',
      'en': 'Create account',
      'es': 'Crear una cuenta',
    },
    'lf8gqbsj': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Friends
  {
    '201zill5': {
      'pt': 'Amigos',
      'en': 'Friends',
      'es': 'Amigos',
    },
    'w4ghjr0h': {
      'pt': '#',
      'en': '#',
      'es': '#',
    },
    'z6985556': {
      'pt': 'Selecionado',
      'en': 'Selected',
      'es': 'Seleccionado',
    },
    'ureveck9': {
      'pt': 'Alexandre',
      'en': 'Alexandre',
      'es': 'Alexandre',
    },
    'ipngcyk2': {
      'pt': 'São Paulo, São Paulo',
      'en': 'Sao Paulo, Sao Paulo',
      'es': 'São Paulo, São Paulo',
    },
    'bwb02w8k': {
      'pt': 'Reinam',
      'en': 'Reinam',
      'es': 'Reinam',
    },
    '9i0s10fu': {
      'pt': 'Santa Isabel, São Paulo',
      'en': 'Santa Isabel, São Paulo',
      'es': 'Santa Isabel, São Paulo',
    },
    '3wphw2ko': {
      'pt': 'Eliseu Portes',
      'en': 'Eliseu Portes',
      'es': 'Eliseu Portes',
    },
    'u1voip78': {
      'pt': 'Mogi das Cruzes, São Paulo',
      'en': 'Mogi das Cruzes, Sao Paulo',
      'es': 'Mogi das Cruzes, São Paulo',
    },
    'f2bpobpf': {
      'pt': 'Pedro Fernandes',
      'en': 'Pedro Fernandes',
      'es': 'Pedro Fernandez',
    },
    'hpah26nx': {
      'pt': 'Mogi das Cruzes, São Paulo',
      'en': 'Mogi das Cruzes, Sao Paulo',
      'es': 'Mogi das Cruzes, São Paulo',
    },
    'nhuobhch': {
      'pt': 'Pedro Teixeira',
      'en': 'Pedro Teixeira',
      'es': 'Pedro Teixeira',
    },
    'l6j7so9z': {
      'pt': 'Mogi das Cruzes, São Paulo',
      'en': 'Mogi das Cruzes, Sao Paulo',
      'es': 'Mogi das Cruzes, São Paulo',
    },
    'gc0sv5fd': {
      'pt': 'Adilson',
      'en': 'Adilson',
      'es': 'Adilosn',
    },
    '0p0gc2we': {
      'pt': 'Petrolina, Pernambuco',
      'en': 'Petrolina, Pernambuco',
      'es': 'Petrolina, Pernambuco',
    },
    'wh5resul': {
      'pt': 'Ednaldo',
      'en': 'Ednaldo',
      'es': 'Ednaldo',
    },
    '7m3ir5id': {
      'pt': 'Suzano, São Paulo',
      'en': 'Suzano, Sao Paulo',
      'es': 'Suzano, São Paulo',
    },
    '94l42h7h': {
      'pt': 'Pedro Toledo',
      'en': 'Pedro Toledo',
      'es': 'Pedro Toledo',
    },
    '2fw6dvmc': {
      'pt': 'Xique-Xique, Bahia',
      'en': 'Xique-Xique, Bahia',
      'es': 'Xique-Xique, Bahía',
    },
    '5j3wp3qb': {
      'pt': 'Enviar convites',
      'en': 'Send invitations',
      'es': 'Enviar invitaciones',
    },
    '34fanvjv': {
      'pt': 'Convidar amigos',
      'en': 'Invite friends',
      'es': 'Invitar amigos',
    },
    '1ypxbwm2': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Payment
  {
    '5nyn2msg': {
      'pt': 'Pagamento Confirmado',
      'en': 'Payment Confirmed',
      'es': 'Pago confirmado',
    },
    'eeg11gbb': {
      'pt': 'R\$ 180,00',
      'en': 'R\$ 180.00',
      'es': 'R\$ 180,00',
    },
    'xkx13quq': {
      'pt':
          'O seu pagamento foi confirmado, mas pode demorar de 1-2 horas para que o seu pagamento seja efetuado e apareça na sua lista de transações.',
      'en':
          'Your payment has been confirmed, but it may take 1-2 hours for your payment to be processed and appear in your transaction list.',
      'es':
          'Su pago ha sido confirmado, pero es posible que pasen entre 1 y 2 horas antes de que se realice y aparezca en su lista de transacciones.',
    },
    'jfvdivg1': {
      'pt': 'Mastercard finalizado em 4021',
      'en': 'Mastercard finalized in 4021',
      'es': 'Mastercard finalizada en 4021',
    },
    '18qcp5rm': {
      'pt': '*******************4021',
      'en': '*******************4021',
      'es': '*******************4021',
    },
    'r5fxl367': {
      'pt': 'Voltar',
      'en': 'To go back',
      'es': 'para volver',
    },
    'ppuwl44p': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Lista_Profissionais
  {
    'yug1tuky': {
      'pt': 'Todos',
      'en': 'All',
      'es': '',
    },
    'opjk6qsu': {
      'pt': 'Pedreiro',
      'en': '',
      'es': '',
    },
    'i0r22lu5': {
      'pt': 'Tudo e mais um pouco',
      'en': 'Everything and more',
      'es': '',
    },
    'dflaczb1': {
      'pt': 'Engenheiro',
      'en': '',
      'es': '',
    },
    '2w5d6c4j': {
      'pt': 'Title',
      'en': '',
      'es': '',
    },
    'ebjp5g6i': {
      'pt': 'Eletricista',
      'en': '',
      'es': '',
    },
    '86mol8a7': {
      'pt': 'Title',
      'en': '',
      'es': '',
    },
    't8qnu6y0': {
      'pt': 'Ativos',
      'en': 'Active',
      'es': '',
    },
    'qm5alnru': {
      'pt': 'Alexandre o Grande',
      'en': '',
      'es': '',
    },
    'oq3bbgld': {
      'pt': 'Criador de Sites WEB',
      'en': 'WEB Website Builder',
      'es': '',
    },
    '14secv0t': {
      'pt': 'Inativos',
      'en': 'Inactive',
      'es': '',
    },
    'mq89o5wv': {
      'pt': 'Pedreirão',
      'en': '',
      'es': '',
    },
    'ipvfcams': {
      'pt': 'Conserto Telas',
      'en': 'Screen Repair',
      'es': '',
    },
    '8eocvmhv': {
      'pt': 'Pedreiros',
      'en': 'Masons',
      'es': '',
    },
    'j5dhzcu4': {
      'pt': '•',
      'en': '',
      'es': '',
    },
  },
  // Calendario_disponibilidade
  {
    'w0a6u44q': {
      'pt': 'Mês',
      'en': 'Month',
      'es': '',
    },
    'rdn8qw02': {
      'pt': 'Próximos agendamentos',
      'en': '',
      'es': '',
    },
    'bn9elyz5': {
      'pt': 'Agendamento com Pedrão',
      'en': 'Appointment with Pedrão',
      'es': '',
    },
    'na7d0vgl': {
      'pt': '14:20',
      'en': '2:20pm',
      'es': '',
    },
    'okl3sl8l': {
      'pt': 'Quarta-feira, 30/10/2024',
      'en': 'Wed, 30/10/2024',
      'es': '',
    },
    '3myiksda': {
      'pt': 'Agendamentos passados',
      'en': 'Past appointments',
      'es': '',
    },
    'g366wphm': {
      'pt': 'Agendamento com Xande',
      'en': 'Scheduling with Xande',
      'es': '',
    },
    'v55mf0rg': {
      'pt': '8:50',
      'en': '8:50am',
      'es': '',
    },
    '35vsmsqm': {
      'pt': 'Sexta-feira, 04/10/2024',
      'en': 'Fri, 04/10/2024',
      'es': '',
    },
    'ey22xxn4': {
      'pt': 'Semana',
      'en': 'Week',
      'es': '',
    },
    'hdfpdwu5': {
      'pt': 'Coming Up',
      'en': '',
      'es': '',
    },
    '77s9bmr8': {
      'pt': 'Agendamento com Wesley',
      'en': 'Appointment with Wesley',
      'es': '',
    },
    '408vn6es': {
      'pt': '14:20',
      'en': '2:20pm',
      'es': '',
    },
    'xr5bvbfc': {
      'pt': 'Quarta-feira, 30/10/2024',
      'en': 'Wed, 30/10/2024',
      'es': '',
    },
    'h9qa00ce': {
      'pt': 'Past Due',
      'en': '',
      'es': '',
    },
    'xa20hzoj': {
      'pt': 'Agendamento com Bia',
      'en': 'Scheduling with Bia',
      'es': '',
    },
    'y77eswf1': {
      'pt': '8:50',
      'en': '8:50am',
      'es': '',
    },
    'q71snfct': {
      'pt': 'Sexta-feira, 04/10/2024',
      'en': 'Fri, 04/10/2024',
      'es': '',
    },
    'iskk801c': {
      'pt': 'Calendário',
      'en': '',
      'es': '',
    },
    't4hgpfwo': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Pesquisador
  {
    'njcb48zb': {
      'pt': 'Pesquise por um profissional',
      'en': 'Search for a professional',
      'es': 'Buscar un profesional',
    },
    'b9iyplu9': {
      'pt': 'Todos',
      'en': 'All',
      'es': 'Todo',
    },
    'jr9ghsgo': {
      'pt': 'Categorias',
      'en': 'Categories',
      'es': 'Categorías',
    },
    'co9kfduh': {
      'pt': 'Advogado',
      'en': 'Attorney',
      'es': 'Abogado',
    },
    'geccl4ez': {
      'pt': 'Barbeiro',
      'en': 'Barber',
      'es': 'Barbero',
    },
    'q6m90dg6': {
      'pt': 'Cabeleireiro',
      'en': 'Hairdresser',
      'es': 'Peluquero',
    },
    'nt8v0tve': {
      'pt': 'Dentista',
      'en': 'Dentist',
      'es': 'Dentista',
    },
    'h2jgh0jp': {
      'pt': 'Eletricista',
      'en': 'Electrician',
      'es': 'Electricista',
    },
    'tuvfcoif': {
      'pt': 'Torneiro',
      'en': 'Turner',
      'es': 'Tornero',
    },
    'wzlr25ub': {
      'pt': 'Funileiro',
      'en': 'Tinsmith',
      'es': 'Gitano',
    },
    '6ouo4h0a': {
      'pt': 'Indicados',
      'en': 'Nominees',
      'es': 'Nominados',
    },
    'vss5nyug': {
      'pt': 'Categories',
      'en': 'Categories',
      'es': 'Categorías',
    },
    'b9702wvu': {
      'pt': 'Economista',
      'en': 'Economist',
      'es': 'Economista',
    },
    '69q74nkq': {
      'pt': 'Administrador',
      'en': 'Administrator',
      'es': 'Administrador',
    },
    'bacsbhwk': {
      'pt': 'Contabilidade',
      'en': 'Accounting',
      'es': 'Contabilidad',
    },
    'q6j5oqcj': {
      'pt': 'Técnico de informática',
      'en': 'Computer technician',
      'es': 'técnico de TI',
    },
    'azuf0jx7': {
      'pt': 'Montador de móveis',
      'en': 'Furniture assembler',
      'es': 'Montador de muebles',
    },
    'pf5aa9r2': {
      'pt': 'Mecãnico',
      'en': 'Mechanic',
      'es': 'Mecánico',
    },
    'ogg7gsy6': {
      'pt': 'Alfaiate',
      'en': 'Tailor',
      'es': 'Sastre',
    },
    '0e69ggo1': {
      'pt': 'Empresas',
      'en': 'Companies',
      'es': 'Empresas',
    },
    'rugnm7hl': {
      'pt': 'Profissionais',
      'en': 'Professionals',
      'es': 'Ventajas',
    },
    'xcxdq9cd': {
      'pt': 'Pedreiro',
      'en': 'Mason',
      'es': 'Masón',
    },
    'lnkl2kqi': {
      'pt': 'Construtora',
      'en': 'Construction company',
      'es': 'Construcción',
    },
    '9l4yy18e': {
      'pt': 'Siderurgica',
      'en': 'Steel industry',
      'es': 'Acero',
    },
    'nsk7ise4': {
      'pt': 'Papel e Celulose',
      'en': 'Pulp and Paper',
      'es': 'Papel y Celulosa',
    },
    'skvkzyav': {
      'pt': 'Mineiradora',
      'en': 'Mining company',
      'es': 'empresa minera',
    },
    'nmd3hnui': {
      'pt': 'Produtora de Textêis',
      'en': 'Textile Producer',
      'es': 'Productor textil',
    },
    'q3kcc0uj': {
      'pt': 'Agropecuária',
      'en': 'Agriculture',
      'es': 'Agricultura',
    },
    'uysp34r4': {
      'pt': 'Categorias',
      'en': 'Categories',
      'es': 'Categorías',
    },
    '5lcfkbnb': {
      'pt': 'Pesquisa',
      'en': 'Search',
      'es': 'Buscar',
    },
  },
  // Favorites
  {
    'lhsiru0h': {
      'pt': 'Contatos salvos nos favoritos',
      'en': 'Contacts saved in favorites',
      'es': '',
    },
    '9t38qzo4': {
      'pt': 'Alexandre Henrique Silva de Araújo',
      'en': '',
      'es': '',
    },
    '65t4418a': {
      'pt': 'user@randomname.com',
      'en': '',
      'es': '',
    },
    'w4ofia3e': {
      'pt': 'Benedito Reinan Cesário da Silva',
      'en': '',
      'es': '',
    },
    'ekor4idj': {
      'pt': 'user@randomname.com',
      'en': '',
      'es': '',
    },
    '0mr8dk4h': {
      'pt': 'Eliseu Portes Moura Junior',
      'en': '',
      'es': '',
    },
    '0x3mugly': {
      'pt': 'user@randomname.com',
      'en': '',
      'es': '',
    },
    'gl8048jm': {
      'pt': 'Pedro H. Leite Brito Fernandes',
      'en': '',
      'es': '',
    },
    'rvr4hq97': {
      'pt': 'user@randomname.com',
      'en': '',
      'es': '',
    },
    '42grhklp': {
      'pt': 'Pedro Henrique Martins de Toledo',
      'en': '',
      'es': '',
    },
    'ynaezhyf': {
      'pt': 'user@randomname.com',
      'en': '',
      'es': '',
    },
    'clxmi6xc': {
      'pt': 'Enviar',
      'en': '',
      'es': '',
    },
    'o02bpamj': {
      'pt': 'Adicionar',
      'en': '',
      'es': '',
    },
    '9590bdb9': {
      'pt': 'Atualizar',
      'en': '',
      'es': '',
    },
    'gr4mn4y2': {
      'pt': 'Deletar',
      'en': '',
      'es': '',
    },
    '0rs41i2i': {
      'pt': 'Favoritos',
      'en': '',
      'es': '',
    },
    '56oaifrw': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Configuration_Notifications
  {
    'b3bz1246': {
      'pt': 'Notificações',
      'en': 'Notifications',
      'es': '',
    },
    'kewqxwna': {
      'pt':
          'Escolha abaixo as notificações que você deseja receber e atualizaremos as configurações.',
      'en':
          'Choose what notifcations you want to recieve below and we will update the settings.',
      'es': '',
    },
    'qfl81f1q': {
      'pt': 'Notificações push',
      'en': 'Push Notifications',
      'es': '',
    },
    'dplwbpxm': {
      'pt':
          'Receba notificações por push do nosso aplicativo de forma semi-regular.',
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'es': '',
    },
    '4uv0ou2p': {
      'pt': 'Notificações por e-mail',
      'en': 'Email Notifications',
      'es': '',
    },
    'x9nr578a': {
      'pt':
          'Receber notificações por e-mail da nossa equipe de marketing sobre novos recursos.',
      'en':
          'Receive email notifications from our marketing team about new features.',
      'es': '',
    },
    'o1s9sq31': {
      'pt': 'Serviços de localização',
      'en': 'Location Services',
      'es': '',
    },
    'hum1tg0g': {
      'pt':
          'Permita-nos rastrear sua localização, o que ajuda a controlar os gastos e a mantê-lo seguro.',
      'en':
          'Allow us to track your location, this helps keep track of spending and keeps you safe.',
      'es': '',
    },
    'nfxews9n': {
      'pt': 'Salvar',
      'en': 'Save',
      'es': '',
    },
    'nqpilx81': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Perfil_View
  {
    '6t0in5jc': {
      'pt': 'Max Rosco',
      'en': '',
      'es': '',
    },
    'sw8no2in': {
      'pt': 'Good morning Max!',
      'en': '',
      'es': '',
    },
    'gvktuudb': {
      'pt': 'Find your task...',
      'en': '',
      'es': '',
    },
    'm8l9t60k': {
      'pt': 'Categories',
      'en': '',
      'es': '',
    },
    'gy4gxiza': {
      'pt': 'No-Code Platform Design',
      'en': '',
      'es': '',
    },
    'wduhs4uw': {
      'pt': '12 Projects',
      'en': '',
      'es': '',
    },
    'tto7wut7': {
      'pt': '30%',
      'en': '',
      'es': '',
    },
    'mex4xpdx': {
      'pt': 'Design for sample apps',
      'en': '',
      'es': '',
    },
    't39icyly': {
      'pt': '12 Projects',
      'en': '',
      'es': '',
    },
    's9ao39l9': {
      'pt': '30%',
      'en': '',
      'es': '',
    },
    'afjno4aj': {
      'pt': 'My Tasks',
      'en': '',
      'es': '',
    },
    'qihg04s0': {
      'pt': 'Today',
      'en': '',
      'es': '',
    },
    'a8zc45xa': {
      'pt': 'Design Template Screens',
      'en': '',
      'es': '',
    },
    'r0vmutcw': {
      'pt': 'Create template screen for task todo app.',
      'en': '',
      'es': '',
    },
    'cb52vhvc': {
      'pt': 'Due',
      'en': '',
      'es': '',
    },
    '2wntp1kk': {
      'pt': 'Tuesday, 10:00am',
      'en': '',
      'es': '',
    },
    '045rue9j': {
      'pt': 'In Progress',
      'en': '',
      'es': '',
    },
    'i936uf36': {
      'pt': 'Theme Collection',
      'en': '',
      'es': '',
    },
    'vf7inp3d': {
      'pt': 'Create themes for use by our users.',
      'en': '',
      'es': '',
    },
    '7qlv8oo0': {
      'pt': 'Due',
      'en': '',
      'es': '',
    },
    '3zlj4b76': {
      'pt': 'Tuesday, 10:00am',
      'en': '',
      'es': '',
    },
    'wuhs53fe': {
      'pt': 'In Progress',
      'en': '',
      'es': '',
    },
    'hxlj6a2x': {
      'pt': 'Upcoming',
      'en': '',
      'es': '',
    },
    '6n24j1uf': {
      'pt': 'Design Template Screens',
      'en': '',
      'es': '',
    },
    'vv6vluw0': {
      'pt': 'Create template screen for task todo app.',
      'en': '',
      'es': '',
    },
    'nj23g0ay': {
      'pt': 'Due',
      'en': '',
      'es': '',
    },
    '3fm2eat9': {
      'pt': 'Tuesday, 10:00am',
      'en': '',
      'es': '',
    },
    'e52grhd8': {
      'pt': 'In Progress',
      'en': '',
      'es': '',
    },
    '07y4tkaa': {
      'pt': 'Design Template Screens',
      'en': '',
      'es': '',
    },
    '2rw6ve22': {
      'pt': 'Create template screen for task todo app.',
      'en': '',
      'es': '',
    },
    'nzxrdzho': {
      'pt': 'Due',
      'en': '',
      'es': '',
    },
    'mzj25mg4': {
      'pt': 'Tuesday, 10:00am',
      'en': '',
      'es': '',
    },
    '7mbs8g5f': {
      'pt': 'In Progress',
      'en': '',
      'es': '',
    },
    '5f1yj69r': {
      'pt': 'Completed',
      'en': '',
      'es': '',
    },
    'zkf5tqwz': {
      'pt': 'Design Template Screens',
      'en': '',
      'es': '',
    },
    'flqu1x26': {
      'pt': 'Create template screen for task todo app.',
      'en': '',
      'es': '',
    },
    'hpslhyin': {
      'pt': 'Completed',
      'en': '',
      'es': '',
    },
    '40pye18k': {
      'pt': 'Tuesday, 10:00am',
      'en': '',
      'es': '',
    },
    'buxnpko7': {
      'pt': 'Complete',
      'en': '',
      'es': '',
    },
    'vcedo7hk': {
      'pt': 'Design Template Screens',
      'en': '',
      'es': '',
    },
    'c2arr80y': {
      'pt': 'Create template screen for task todo app.',
      'en': '',
      'es': '',
    },
    'ccftusa6': {
      'pt': 'Completed',
      'en': '',
      'es': '',
    },
    'leqsoihc': {
      'pt': 'Tuesday, 10:00am',
      'en': '',
      'es': '',
    },
    'i0b22ano': {
      'pt': 'Complete',
      'en': '',
      'es': '',
    },
    '429qnqa7': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Tasks
  {
    '8vdqkv85': {
      'pt': 'check.io',
      'en': '',
      'es': '',
    },
    '908qtxdy': {
      'pt': 'Platform Navigation',
      'en': '',
      'es': '',
    },
    'n43hyxxa': {
      'pt': 'Dashboard',
      'en': '',
      'es': '',
    },
    'saoxny9n': {
      'pt': 'Chats',
      'en': '',
      'es': '',
    },
    'dpi8uui1': {
      'pt': 'All Tasks',
      'en': '',
      'es': '',
    },
    'ax279u7j': {
      'pt': '12',
      'en': '',
      'es': '',
    },
    '3b7jfylc': {
      'pt': 'Projects',
      'en': '',
      'es': '',
    },
    'jji4n0r1': {
      'pt': 'Settings',
      'en': '',
      'es': '',
    },
    '35tqomdc': {
      'pt': 'Billing',
      'en': '',
      'es': '',
    },
    'cslr8yrg': {
      'pt': 'Explore',
      'en': '',
      'es': '',
    },
    '09j56xaa': {
      'pt': 'Light Mode',
      'en': '',
      'es': '',
    },
    's464kiah': {
      'pt': 'Dark Mode',
      'en': '',
      'es': '',
    },
    'mn5dvlpf': {
      'pt': 'Andrew D.',
      'en': '',
      'es': '',
    },
    'z3k97q1w': {
      'pt': 'admin@gmail.com',
      'en': '',
      'es': '',
    },
    'zilz57kb': {
      'pt': 'Team Activity',
      'en': '',
      'es': '',
    },
    '9j5bwqoj': {
      'pt': 'Below is a summary of tasks.',
      'en': '',
      'es': '',
    },
    'cg6if6us': {
      'pt': 'All',
      'en': '',
      'es': '',
    },
    'n4orgf92': {
      'pt': 'Pending',
      'en': '',
      'es': '',
    },
    '67iagg3f': {
      'pt': 'In Progress',
      'en': '',
      'es': '',
    },
    '92ymr2wk': {
      'pt': 'Completed',
      'en': '',
      'es': '',
    },
    'dvh0q1xl': {
      'pt': 'All',
      'en': '',
      'es': '',
    },
    'yjadnr8f': {
      'pt': 'All',
      'en': '',
      'es': '',
    },
    'fnk7lavk': {
      'pt': 'Search all tasks...',
      'en': '',
      'es': '',
    },
    'hgwc49az': {
      'pt': 'Rudy Fernandez',
      'en': '',
      'es': '',
    },
    'oeiwotmn': {
      'pt': '4m ago',
      'en': '',
      'es': '',
    },
    'rp86bgvz': {
      'pt': 'Completed ',
      'en': '',
      'es': '',
    },
    'n4o15ab0': {
      'pt': 'Marketing Plan',
      'en': '',
      'es': '',
    },
    'qqrfa9ys': {
      'pt':
          'Conduct comprehensive testing of a new product before its official release. Set up a structured testing plan...',
      'en': '',
      'es': '',
    },
    'x19jsnkj': {
      'pt': 'Rudy Fernandez',
      'en': '',
      'es': '',
    },
    '127v67c5': {
      'pt': '4m ago',
      'en': '',
      'es': '',
    },
    '3lo4k3no': {
      'pt': 'Started ',
      'en': '',
      'es': '',
    },
    'pf0y3vjf': {
      'pt': 'Marketing Plan',
      'en': '',
      'es': '',
    },
    '8t9dojoc': {
      'pt':
          'Conduct comprehensive testing of a new product before its official release. Set up a structured testing plan...',
      'en': '',
      'es': '',
    },
    'ogjr79cx': {
      'pt': 'Abigail Rojas',
      'en': '',
      'es': '',
    },
    'a8kplu2a': {
      'pt': '4m ago',
      'en': '',
      'es': '',
    },
    '8lmsjkqa': {
      'pt': 'Assigned  ',
      'en': '',
      'es': '',
    },
    'fuwzxj3d': {
      'pt': 'Rudy Fernandez ',
      'en': '',
      'es': '',
    },
    'woa74bdo': {
      'pt': 'to ',
      'en': '',
      'es': '',
    },
    'uny3484e': {
      'pt': 'Marketing Plan',
      'en': '',
      'es': '',
    },
    'pne9i526': {
      'pt':
          'Conduct comprehensive testing of a new product before its official release. Set up a structured testing plan...',
      'en': '',
      'es': '',
    },
    'xt27f4az': {
      'pt': 'Abigail Rojas',
      'en': '',
      'es': '',
    },
    'qbczf01i': {
      'pt': '4m ago',
      'en': '',
      'es': '',
    },
    'p38c7fvt': {
      'pt': 'Created a project: ',
      'en': '',
      'es': '',
    },
    't6s51x2e': {
      'pt': 'Marketing Plan',
      'en': '',
      'es': '',
    },
    'ppyipstx': {
      'pt':
          'Conduct comprehensive testing of a new product before its official release. Set up a structured testing plan...',
      'en': '',
      'es': '',
    },
    'm6ksrgic': {
      'pt': 'Liz Ambridge',
      'en': '',
      'es': '',
    },
    'la3dk9z5': {
      'pt': '4m ago',
      'en': '',
      'es': '',
    },
    'debistly': {
      'pt': 'Sent a plan update for ',
      'en': '',
      'es': '',
    },
    'fpf5xb90': {
      'pt': 'Marketing Plan',
      'en': '',
      'es': '',
    },
    'w8g01j8h': {
      'pt': 'Project Started',
      'en': '',
      'es': '',
    },
    'vtyp30sj': {
      'pt': '12d ago',
      'en': '',
      'es': '',
    },
    't8wul33u': {
      'pt': 'Suas atividades',
      'en': 'Your activities',
      'es': '',
    },
    'b92sr6a0': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Notifications_Interactive
  {
    '8040a356': {
      'pt': 'check.io',
      'en': '',
      'es': '',
    },
    '3bqq4a7d': {
      'pt': 'Platform Navigation',
      'en': '',
      'es': '',
    },
    'j3sg2kvl': {
      'pt': 'Dashboard',
      'en': '',
      'es': '',
    },
    '5mn35fwb': {
      'pt': 'Chats',
      'en': '',
      'es': '',
    },
    '0zypj8ap': {
      'pt': 'Projects',
      'en': '',
      'es': '',
    },
    'dmushsm6': {
      'pt': 'Settings',
      'en': '',
      'es': '',
    },
    '8f89dny2': {
      'pt': 'Notifications',
      'en': '',
      'es': '',
    },
    '1b98jk6i': {
      'pt': '12',
      'en': '',
      'es': '',
    },
    '0hconc2f': {
      'pt': 'Billing',
      'en': '',
      'es': '',
    },
    'z7lgwbqs': {
      'pt': 'Explore',
      'en': '',
      'es': '',
    },
    'o37zzvml': {
      'pt': 'Light Mode',
      'en': '',
      'es': '',
    },
    'mqajfa6s': {
      'pt': 'Dark Mode',
      'en': '',
      'es': '',
    },
    'xr8ch6p6': {
      'pt': 'Andrew D.',
      'en': '',
      'es': '',
    },
    '9csi9igr': {
      'pt': 'admin@gmail.com',
      'en': '',
      'es': '',
    },
    'ohtcu01h': {
      'pt': 'Notifications',
      'en': '',
      'es': '',
    },
    '7d8xyvl0': {
      'pt': 'Below is a list of recent activity',
      'en': '',
      'es': '',
    },
    'haqag8vt': {
      'pt': 'FlutterFlow CRM App:',
      'en': '',
      'es': '',
    },
    'wt1fnm4r': {
      'pt': ' Begin Work',
      'en': '',
      'es': '',
    },
    'yvvm4sl2': {
      'pt': 'SOW Change Order',
      'en': '',
      'es': '',
    },
    'yl7lq5lr': {
      'pt': 'FlutterFlow CRM App',
      'en': '',
      'es': '',
    },
    'xyz1si04': {
      'pt': 'Jul 8, at 4:31pm',
      'en': '',
      'es': '',
    },
    'uoqefq67': {
      'pt': 'Jeremiah Goldsten ',
      'en': '',
      'es': '',
    },
    '2or7jj4g': {
      'pt': 'accepted a request',
      'en': '',
      'es': '',
    },
    'mq9ag1rv': {
      'pt': 'SOW Change Order',
      'en': '',
      'es': '',
    },
    'uja04szj': {
      'pt': 'FlutterFlow CRM App',
      'en': '',
      'es': '',
    },
    '16we4ycf': {
      'pt':
          '\"Notifications and reminders informing users about upcoming classes and training schedules will be sent to them via email, SMS or notifications within the application.\"',
      'en': '',
      'es': '',
    },
    'j54un239': {
      'pt': 'Jul 8, at 4:30pm',
      'en': '',
      'es': '',
    },
    'cgb9pu9c': {
      'pt': 'Randy Rudolph ',
      'en': '',
      'es': '',
    },
    'zqgag92i': {
      'pt': 'sent a SOW Change Order for ',
      'en': '',
      'es': '',
    },
    '9tj9s4oy': {
      'pt': 'FlutterFlow CRM APP',
      'en': '',
      'es': '',
    },
    'kw8zj5g2': {
      'pt': 'SOW Change Order',
      'en': '',
      'es': '',
    },
    'ybjrr6y9': {
      'pt': 'FlutterFlow CRM App',
      'en': '',
      'es': '',
    },
    'aoyjg0s7': {
      'pt':
          '\"Please review the updates to this document and get back with me.\"',
      'en': '',
      'es': '',
    },
    'jmiyrj59': {
      'pt': 'Jul 8, at 2:20pm',
      'en': '',
      'es': '',
    },
    '0su93ejf': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Create_task
  {
    '7mrq3i27': {
      'pt': 'Insira informações sobre a tarefa que será realizada',
      'en': '',
      'es': '',
    },
    '51pdunvc': {
      'pt': 'Título',
      'en': 'Title',
      'es': '',
    },
    'pqvhlgsx': {
      'pt': 'Descrição da tarefa',
      'en': 'Task description',
      'es': '',
    },
    '3iuypf8f': {
      'pt': 'Adicione uma tag',
      'en': 'Add a tag',
      'es': '',
    },
    'e4m9g822': {
      'pt': 'Profissional',
      'en': 'Professional',
      'es': '',
    },
    'ins4tinj': {
      'pt': 'Autônomo',
      'en': 'Self-employed',
      'es': '',
    },
    'bsj18vt9': {
      'pt': 'Empresa',
      'en': 'Enterprise',
      'es': '',
    },
    '6nks7bwx': {
      'pt': 'Qualificado',
      'en': 'Qualified',
      'es': '',
    },
    'vmayge2d': {
      'pt': 'Indicado',
      'en': 'Indicated',
      'es': '',
    },
    'h4na5zcx': {
      'pt': 'Melhor avaliado',
      'en': 'Top rated',
      'es': '',
    },
    'lg9xfu62': {
      'pt': 'Disponível',
      'en': 'Available',
      'es': '',
    },
    '7iadup6j': {
      'pt': 'Ativo',
      'en': 'Active',
      'es': '',
    },
    '5g9s1lcx': {
      'pt': 'Premium',
      'en': 'Premium',
      'es': '',
    },
    'igt94824': {
      'pt': 'Product Design',
      'en': '',
      'es': '',
    },
    '9nw5ivs5': {
      'pt': 'Selecione os dias que tenha disponibilidade',
      'en': 'Select the days you have availability',
      'es': '',
    },
    '5tsg8ovx': {
      'pt': 'Calendário',
      'en': 'Calendar',
      'es': '',
    },
    '664ph2ye': {
      'pt': 'Próximo',
      'en': 'Next',
      'es': '',
    },
    'l6arskky': {
      'pt': 'Criar um pedido',
      'en': '',
      'es': '',
    },
    'bc86b5qz': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Chat_BUG
  {
    '9p7155qj': {
      'pt': 'Escreva sobre o problema.',
      'en': 'Write about the problem.',
      'es': '',
    },
    '4mf2voa8': {
      'pt':
          'Digite sobre os problemas e dificuldades que está enfrentando na utilização do aplicativo',
      'en':
          'Type in the problems and difficulties you are facing in using the application',
      'es': '',
    },
    '6roe0mto': {
      'pt': 'Adicione um título',
      'en': 'Add a title',
      'es': '',
    },
    'nehq02nx': {
      'pt': 'Digite uma breve descrição do(s) problema(s)',
      'en': 'Enter a brief description of the problem(s)',
      'es': '',
    },
    'mapx63nj': {
      'pt': 'Escolher imagem',
      'en': 'Choose image',
      'es': '',
    },
    'pezsaazf': {
      'pt': 'Enviar ',
      'en': 'Send',
      'es': '',
    },
    'gcf64hox': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Timer
  {
    'u4p802fe': {
      'pt': 'Tempo restante',
      'en': 'Timer Left',
      'es': '',
    },
    'croyjyjj': {
      'pt': 'Tarefa a ser executada:',
      'en': 'Task to be performed:',
      'es': '',
    },
    'nhpaq1ob': {
      'pt': 'Push Ups',
      'en': '',
      'es': '',
    },
    'nzvszosf': {
      'pt': 'Current Set',
      'en': '',
      'es': '',
    },
    'alknkwde': {
      'pt': '40 in 1 minute',
      'en': '',
      'es': '',
    },
    'tlktw2z3': {
      'pt':
          'Pushups are an exercise in which a person, keeping a prone position, with the hands palms down under the shoulders, the balls of the feet on the ground, and the back straight, pushes the body up and lets it down by an alternate straightening and bending of the arms.',
      'en': '',
      'es': '',
    },
    'gvvyb7er': {
      'pt': 'Complete Workout',
      'en': '',
      'es': '',
    },
    '0z8glk17': {
      'pt': 'Tarefa pendente',
      'en': '',
      'es': '',
    },
    '4t0t5kkb': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Orcamento
  {
    '4ddyblyo': {
      'pt': 'check.io',
      'en': '',
      'es': '',
    },
    's3r3wjha': {
      'pt': 'Platform Navigation',
      'en': '',
      'es': '',
    },
    'n94iy7hp': {
      'pt': 'Dashboard',
      'en': '',
      'es': '',
    },
    '1av72qzs': {
      'pt': 'Chats',
      'en': '',
      'es': '',
    },
    '56zknee6': {
      'pt': 'Projects',
      'en': '',
      'es': '',
    },
    'pqh6y4qx': {
      'pt': 'Recent Orders',
      'en': '',
      'es': '',
    },
    'ftb8x0iz': {
      'pt': '12',
      'en': '',
      'es': '',
    },
    'uohoutg9': {
      'pt': 'Settings',
      'en': '',
      'es': '',
    },
    'c58woz8a': {
      'pt': 'Billing',
      'en': '',
      'es': '',
    },
    'edcqqbzb': {
      'pt': 'Explore',
      'en': '',
      'es': '',
    },
    'ofl4njul': {
      'pt': 'Light Mode',
      'en': '',
      'es': '',
    },
    'ht249zsy': {
      'pt': 'Dark Mode',
      'en': '',
      'es': '',
    },
    'hb6hka6r': {
      'pt': 'Andrew D.',
      'en': '',
      'es': '',
    },
    '95gy15bp': {
      'pt': 'admin@gmail.com',
      'en': '',
      'es': '',
    },
    'rhqr767h': {
      'pt': 'Order Details',
      'en': '',
      'es': '',
    },
    'ezjd47e3': {
      'pt': 'Orçamento feito por Pedro',
      'en': 'Budget made by Pedrão CRUD',
      'es': '',
    },
    'g4vf76mg': {
      'pt': 'Abaixo está a descrição da sua tarefa',
      'en': 'Below is the description of your task',
      'es': '',
    },
    'kkqhl73x': {
      'pt': 'Tarefa',
      'en': 'Task',
      'es': '',
    },
    'iq1prfou': {
      'pt': 'Descrição',
      'en': 'Description',
      'es': '',
    },
    '8i81ncys': {
      'pt': 'TXN123456789',
      'en': '',
      'es': '',
    },
    'gb0ohfvf': {
      'pt': 'Data',
      'en': 'Date',
      'es': '',
    },
    'hlnwmcg4': {
      'pt': 'Sexta, 08/11 - As 14:00',
      'en': '',
      'es': '',
    },
    'z92k2fwz': {
      'pt': 'Valor do orçamento',
      'en': 'Budget value',
      'es': '',
    },
    'jd6ybth4': {
      'pt': 'R\$500.00',
      'en': '',
      'es': '',
    },
    'lyjives6': {
      'pt': 'Status',
      'en': 'Status',
      'es': '',
    },
    'jul5sso8': {
      'pt': 'Em andamento',
      'en': '',
      'es': '',
    },
    'ly4wcrux': {
      'pt': 'Prazo',
      'en': 'Term',
      'es': '',
    },
    'birt80ae': {
      'pt': '5 - 7 dias',
      'en': '5 - 7 days',
      'es': '',
    },
    '6uat6v8r': {
      'pt': 'Custos totais',
      'en': 'Total costs',
      'es': '',
    },
    'm1w2b3fe': {
      'pt': 'Orçamento',
      'en': 'Budget',
      'es': '',
    },
    'zx7yeyka': {
      'pt': 'R\$480.00',
      'en': '',
      'es': '',
    },
    'c518fqnw': {
      'pt': 'Transporte',
      'en': 'Transport',
      'es': '',
    },
    't9pcgk2a': {
      'pt': 'R\$20.00',
      'en': '',
      'es': '',
    },
    'fdmh833f': {
      'pt': 'Total',
      'en': '',
      'es': '',
    },
    'p8d2sd9d': {
      'pt': 'R\$500.00',
      'en': '',
      'es': '',
    },
    's548z8vo': {
      'pt': 'Observações:',
      'en': 'Observations:',
      'es': '',
    },
    'hgps4ks6': {
      'pt': 'Preciso de uma Tela bem grande',
      'en': 'I need a really big screen',
      'es': '',
    },
    'r9njjwac': {
      'pt': 'Detalhes do profissional',
      'en': 'Professional details',
      'es': '',
    },
    'a03vf45w': {
      'pt': 'Adilson Miau',
      'en': 'Pedrão CRUD Kanban Srum ',
      'es': '',
    },
    '53479pgf': {
      'pt': 'adilsonmiauwhiskas@gmail.com',
      'en': 'pedraoscrummastercrudgamer@gmail.com',
      'es': '',
    },
    '8puxbqgh': {
      'pt': 'Endereço',
      'en': 'Address',
      'es': '',
    },
    'xfsfgw5a': {
      'pt': 'Rua do Pedreirão, Vila do CJ, Mogi das Cruzes - SP',
      'en': '123 West Hollywood Blvd. San Mateo, CA. 90294',
      'es': '',
    },
    'cq7w5jwk': {
      'pt': 'Reportar ',
      'en': 'Report ',
      'es': '',
    },
    'vgv4dvl0': {
      'pt': 'Mensagem',
      'en': 'Message',
      'es': '',
    },
    'vp1oqf01': {
      'pt': 'Customer Details',
      'en': '',
      'es': '',
    },
    'pny5wqp4': {
      'pt': 'Haily Brown',
      'en': '',
      'es': '',
    },
    'ux3q6p3p': {
      'pt': '@brownisthenewblack',
      'en': '',
      'es': '',
    },
    'eaqt15zf': {
      'pt': 'Address',
      'en': '',
      'es': '',
    },
    'wugs4726': {
      'pt': '123 West Hollywood Blvd. San Mateo, CA. 90294',
      'en': '',
      'es': '',
    },
    'ly6h5cig': {
      'pt': 'Message Customer',
      'en': '',
      'es': '',
    },
    '8j016krv': {
      'pt': 'Report Now',
      'en': '',
      'es': '',
    },
    'qlaa2nho': {
      'pt': 'Order Details',
      'en': '',
      'es': '',
    },
  },
  // Perfil_curriculo
  {
    '303d1hvo': {
      'pt': 'Adilson Miau',
      'en': 'Adilson Miau',
      'es': 'Adilson Miau',
    },
    'dh5qd57u': {
      'pt': 'whiskasadilson@gmail.com',
      'en': '',
      'es': '',
    },
    'fr6v8kzt': {
      'pt': 'Currículo',
      'en': 'Resume',
      'es': '',
    },
    '7hazmwg2': {
      'pt': 'Notificações',
      'en': 'Notifications',
      'es': '',
    },
    '12ruryeo': {
      'pt': 'Suporte',
      'en': 'Support',
      'es': '',
    },
    'dse2hlyf': {
      'pt': 'Configurações básicas',
      'en': 'Basic settings',
      'es': '',
    },
    'mvsjfzdc': {
      'pt': 'Biografia',
      'en': 'Biography',
      'es': '',
    },
    'awyb268y': {
      'pt': 'Adicionar biografia',
      'en': 'Add biography',
      'es': '',
    },
    'qn7obkx1': {
      'pt': 'Idioma',
      'en': 'Language',
      'es': '',
    },
    'zqg4n9b9': {
      'pt': 'Adicionar idioma',
      'en': 'Add language',
      'es': '',
    },
    'zxqnoiru': {
      'pt': 'Telefone',
      'en': 'Telephone',
      'es': '',
    },
    'mzhjttqf': {
      'pt': 'Adicionar telefone',
      'en': 'Add phone',
      'es': '',
    },
    'bz2uq4z1': {
      'pt': 'Configurações de perfil',
      'en': 'Profile Settings',
      'es': '',
    },
    'krwe0t7i': {
      'pt': 'Editar Perfil',
      'en': 'Edit Profile',
      'es': '',
    },
    'r0e7hn1j': {
      'pt': 'Configuração de Notificações',
      'en': 'Notifications Configuration',
      'es': '',
    },
    'h52qdkys': {
      'pt': 'Sair da conta',
      'en': 'Log out of account',
      'es': '',
    },
    'y0540i4t': {
      'pt': 'Sair',
      'en': 'Exit',
      'es': '',
    },
    'hrdor4te': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // PoliticaPrivacidade
  {
    '1he2xktx': {
      'pt': 'Política de Privacidade',
      'en': 'Terms and conditions',
      'es': '',
    },
    '637r0hyu': {
      'pt':
          'A HELP protege e cuida pela privacidade e a proteção de dados pessoais de todos aquele com quem se relaciona.\nA política de privacidade explica como coletamos, usamos e protegemos as informações pessoais de nossos usuários. Ela abrange informações sobre a coleta de dados, como cookies e informações da conta, como as informações são usadas, com quem são compartilhadas, e as medidas de segurança para proteger as informações dos usuários. Ao usar essa plataforma online, você concorda com os termos da nossa política de privacidade.\nÉ crucial que você leia e compreenda atentamente nossa Política de Privacidade. Por favor, verifique-a regularmente para estar ciente de quaisquer mudanças nas práticas de tratamento de seus dados pessoais.\nEm caso de duvidas, por favor entre em contato indicado no final deste documento.',
      'en':
          'HELP protects and cares for the privacy and protection of personal data of all those with whom it interacts.\nThe privacy policy explains how we collect, use and protect the personal information of our users. It covers information about data collection, such as cookies and account information, how the information is used, with whom it is shared, and the security measures to protect user information. By using this online platform, you agree to the terms of our privacy policy.\nIt is crucial that you read and understand our Privacy Policy carefully. Please check it regularly to be aware of any changes in the practices of processing your personal data.\nIf you have any questions, please contact the contact indicated at the end of this document.',
      'es': '',
    },
    'ojwsfgkn': {
      'pt':
          '1. Quem somos nós?\n\nO projeto HELP é uma proposta inovadora de plataforma de software destinado a trabalhadores autônomos, com o objetivo de simplificar a solicitação de serviços por parte dos clientes. O principal diferencial da HELP é a sua plataforma, que conecta de maneira eficiente autônomos e clientes, facilitando essa interação por meio de um sistema de comunicação via chat. Essa abordagem torna o contato mais acessível e direto, promovendo uma experiência mais fluida.\n\n2. O que você precisa saber antes de ler esta política?\n\nAntes de ler esta política, é importante frisar que esta política descreve como coletamos, armazenamos e usamos suas informações pessoais enquanto você acessam nossos produtos. Esta política também inclui informações sobre como compartilhamos suas informações e as medidas de segurança que usamos para protegê-las. Continue lendo para entender como suas informações pessoais serão tratadas:\nDados pessoais sensíveis são as informações que revelam ou cujo tratamento venha revelar origem racial ou étnica, convicção religiosa, opinião política, filiação à sindicato ou à organização de caráter religioso, filosófico ou político, dados de saúde ou sobre a vida sexual, dado genético ou biométrico.\nEncarregado é o seu canal de contato sobre assuntos relacionados à privacidade e à proteção de dados pessoais. Se você tiver qualquer dúvida sobre como os seus dados pessoais ou de seus dependentes/beneficiários são tratados por nós, é ele quem vai ajudar.\nTitular é a pessoa física a quem se referem os dados pessoais objeto do tratamento.\nTratamento significa qualquer operação realizada com dados pessoais, tais como coleta, produção, classificação, utilização, acesso, processamento, armazenamento, eliminação, modificação, compartilhamento, transferência, entre outros.\nSempre que houver menção aos \"Termos de Uso da HELP\", \"Nós\" ou \"Nossos\", estaremos nos referindo à instituição descrita no tópico \"Quem somos nós\". Da mesma forma, toda vez que mencionarmos \"você\", \"seu\" ou \"sua\", estamos nos referindo a você, titular de dados pessoais, que possui relação com a HELP na qualidade de pessoa interessada, candidato a aluno, aluno e/ou ex-aluno, terceiros relacionados a candidatos ou alunos usuário de nossa rede wi-fi.\n\n3 Quais dados pessoais são tratados e por quê?\n\nA HELP realiza, a depender de sua relação conosco, o tratamento dos dados pessoais a seguir identificados para atendimento às finalidades ora descritas, conforme aplicável:\n\nAutônomo\n\nAtividade\n \nDados pessoais\n \nFinalidade\n \n4. Com quem compartilhamos os seus dados pessoais?\n\nPoderemos compartilhar os seus dados pessoais com entidades que compõem a nossa estrutura organizacional (Administração Nacional e as demais Administrações Regionais), com empresas com as quais mantemos algum tipo de relação comercial, com seu responsável legal e/ou financeiro ou, ainda, com órgãos públicos, tais como parceiros comerciais, instituições bancárias, escritórios de advocacia, empresas de suporte aos nossos sistemas, bureaus de crédito, consultorias contábeis, órgãos públicos e o Poder Judiciário. Os seus dados pessoais podem ser compartilhados para finalidades legítimas da seguinte maneira:\n- Para condução das atividades de tratamento de dados pessoais descritas nesta Política e/ou decorrentes de seu relacionamento e contrato de prestação de serviços conosco;\n- Para permitir que terceiros forneçam serviços para a HELP e/ou acompanhem a prestação de serviços contratada, conforme aplicável;\n- Para obedecer as nossas obrigações legais, regulatórias ou contratuais, ou responder a um processo judicial ou administrativo, auditoria ou solicitações legais por autoridades competentes, quando entendermos que estamos legalmente obrigados a fazê-lo ou, ainda, para fins de atendimento a ofícios relacionados a processos seletivos e/ou concursos públicos dos quais você participa. As categorias de destinatários incluem, por exemplo, contrapartes em contratos, órgãos judiciais e governamentais;\n- Para exercício legítimo de direito em processo judicial, administrativo ou arbitral, inclusive prevenindo lesão ou ameaça a direito;\n- Quando for necessário para proteger você, A HELP e seus interesses legítimos e/ou terceiros;\n- Como parte de due diligence corporativa e/ou due diligence relativa à fusão, aquisição, alteração societária, ou em casos de recuperação judicial ou falência, nós podemos divulgar os seus dados pessoais ao potencial vendedor ou comprador, novo prestador de serviços e respectivos assessores, na medida do quanto necessário e adequado para o atingimento da aludida finalidade;\n- Com o seu consentimento legalmente obtido, isto é dado de forma voluntária e sem que você sofra qualquer consequência adversa de sua decisão que negar ou revogar o seu consentimento.\nInformações agregadas e anonimizadas poderão ser livremente compartilhadas.\nPara resguardar a sua privacidade, utilizamos instrumentos contratuais e auditorias para assegurar que os terceiros que recebam os seus dados pessoais confiram a ele a mesma proteção que nós proporcionamos.\nAtualmente, apenas compartilhamos os seus dados pessoais em território nacional. Caso haja transferência dos seus dados pessoais para fora do Brasil, nos certificaremos de que essa transferência ocorra em observância à legislação brasileira e que você seja informado de tal compartilhamento, sempre que exigido pela legislação aplicável.\nVocê pode ter mais informações sobre os terceiros com quem compartilhamos os seus dados pessoais por meio de requisição específica, conforme indicado no tópico que trata sobre os seus direitos.\n\n5. Por quanto tempo tratamos os seus dados pessoais?\n\nOs seus dados pessoais serão tratados pelo tempo que for necessário para cumprir a finalidade para a qual eles foram coletados, a menos que um período de retenção mais longo seja necessário para cumprir obrigações legais, resolver disputas, proteger nossos ativos ou cumprir acordos judiciais/extrajudiciais.\nPara determinar o período de retenção de seus dados pessoais, além do critério acima indicado, baseamo-nos nos seguintes critérios:\n- Existência de uma obrigação legal ou contratual de reter os dados pessoais;\n- Necessidade dos dados pessoais para investigação, auditoria ou exercício regular de nossos direitos em processos judiciais, administrativos ou arbitrais;\n- Utilidade dos dados pessoais para fins de manutenção de registros precisos, especialmente financeiros e educacionais.\nPodemos manter os seus dados pessoais, de forma anonimizada, ou seja, que não mais se refere a você pessoalmente, para fins estatísticos, sem limite de tempo, na medida em que tenhamos interesse legítimo e respaldo legal.\n\n6. Como mantemos seus dados pessoais seguros?\n\n-Adotamos medidas administrativas e técnicas, continuamente monitoradas e revisadas, de acordo com os avanços tecnológicos, aptas a manter os seus dados pessoais sob nossa responsabilidade protegidos de acessos não autorizados e de situações acidentais ou ilícitas de destruição, perda, alteração, comunicação ou qualquer outra forma de tratamento inadequado ou ilícito.\nNossos sistemas eletrônicos e arquivos físicos atendem aos padrões de segurança da informação adequados, tais como:\n- Controle restrito de acesso interno;\n- Proteção contra acessos não autorizados com a utilização de instrumentos de dupla autenticação, senha e chaves;\n- Manutenção de inventário dos acessos, com o momento, a duração, a identificação do responsável pelo acesso e dados acessados.\nQuaisquer comunicações legalmente exigidas sobre eventuais incidentes de segurança que possam acarretar perdas de disponibilidade, confidencialidade ou integridade dos dados pessoais sob nossa responsabilidade serão notificadas adequadamente às autoridades competentes e aos titulares afetados.\n\n7. Quais são os seus direitos?\n\nVocê, enquanto titular de dados pessoais, possui os seguintes direitos relativos aos seus dados pessoais:\n\n8. Políticas de terceiros e atualizações desta política\n\nNão somos responsáveis pelas práticas de privacidade de terceiros. Portanto, sempre quando você for direcionado a outro domínio que não a HELP e/ou tenha acesso, em decorrência de sua relação conosco, a serviços de terceiros por nós não controlados, recomendamos que você analise as suas respectivas declarações de privacidade, entrando diretamente em contato com o terceiro responsável em caso de dúvidas.\nPoderemos, ocasionalmente, atualizar a presente Política. Sempre quando ocorrer alguma alteração material significativa, como sobre a finalidade para a qual tratamos os seus dados pessoais, bem como a forma e duração do tratamento, utilizaremos esforços razoáveis para que você tenha ciência das modificações.\n\n9. Dúvidas?\n\nSe você tiver quaisquer dúvidas sobre esta Política ou como tratamos os seus dados pessoais, entre em contato pelo e-mail:\n\npedrãokambanscrum@gmail.com\nEncarregado de Dados da HELP\nContato: pedrãokambanscrum@gmail.com',
      'en':
          '1. Who are we?\n\nThe HELP project is an innovative software platform designed for self-employed workers, with the aim of simplifying the request for services by customers. HELP\'s main differentiator is its platform, which efficiently connects self-employed workers and customers, facilitating this interaction through a chat communication system. This approach makes contact more accessible and direct, promoting a more fluid experience.\n\n2. What do you need to know before reading this policy?\n\nBefore reading this policy, it is important to emphasize that this policy describes how we collect, store and use your personal information while you access our products. This policy also includes information about how we share your information and the security measures we use to protect it. Continue reading to understand how your personal information will be treated:\nSensitive personal data is information that reveals or whose processing may reveal racial or ethnic origin, religious belief, political opinion, membership of a trade union or organization of a religious, philosophical or political nature, health data or data about sexual life, genetic or biometric data.\nThe Data Controller is your contact channel for matters related to privacy and personal data protection. If you have any questions about how your personal data or that of your dependents/beneficiaries is processed by us, he or she will be the one to help you.\nThe Data Controller is the natural person to whom the personal data subject to processing refers.\nProcessing means any operation performed with personal data, such as collection, production, classification, use, access, processing, storage, deletion, modification, sharing, transfer, among others.\nWhenever there is a mention of the \"HELP Terms of Use\", \"We\" or \"Our\", we are referring to the institution described in the \"Who are we\" topic. Likewise, whenever we mention \"you\", \"your\" or \"yours\", we are referring to you, the data controller, who has a relationship with HELP as an interested party, student candidate, student and/or former student, third parties related to candidates or students who use our Wi-Fi network.\n\n3 What personal data is processed and why?\n\nDepending on your relationship with us, HELP processes the personal data identified below to fulfill the purposes described herein, as applicable:\n\nSelf-employed\n\nActivity\n\nPersonal data\n\nPurpose\n\n4. With whom do we share your personal data?\n\nWe may share your personal data with entities that make up our organizational structure (National Administration and other Regional Administrations), with companies with which we maintain some type of commercial relationship, with your legal and/or financial representative or, even, with public bodies, such as business partners, banking institutions, law firms, companies that support our systems, credit bureaus, accounting consultancies, public bodies and the Judiciary. Your personal data may be shared for legitimate purposes as follows:\n- To conduct the personal data processing activities described in this Policy and/or arising from your relationship and service provision contract with us;\n- To allow third parties to provide services to HELP and/or monitor the provision of contracted services, as applicable;\n- To comply with our legal, regulatory or contractual obligations, or to respond to a judicial or administrative process, audit or legal requests by competent authorities, when we understand that we are legally obliged to do so, or for the purpose of responding to official requests related to selection processes and/or public tenders in which you participate. The categories of recipients include, for example, counterparties in contracts, judicial and government bodies;\n- For the legitimate exercise of rights in judicial, administrative or arbitration proceedings, including preventing harm or threat to rights;\n- When necessary to protect you, HELP and its legitimate interests and/or third parties;\n- As part of corporate due diligence and/or due diligence relating to mergers, acquisitions, corporate changes, or in cases of judicial recovery or bankruptcy, we may disclose your personal data to the potential seller or buyer, new service provider and their respective advisors, to the extent necessary and appropriate to achieve the aforementioned purpose;\n- With your legally obtained consent, this is given voluntarily and without you suffering any adverse consequences of your decision to deny or revoke your consent.\nAggregated and anonymized information may be freely shared.\nTo protect your privacy, we use contractual instruments and audits to ensure that third parties who receive your personal data provide it with the same protection that we provide.\nCurrently, we only share your personal data within national territory. If there is a transfer of your personal data outside of Brazil, we will ensure that this transfer occurs in compliance with Brazilian legislation and that you are informed of such sharing, whenever required by applicable legislation.\nYou can obtain more information about the third parties with whom we share your personal data by means of a specific request, as indicated in the topic dealing with your rights.\n\n5. For how long do we process your personal data?\n\nYour personal data will be processed for as long as necessary to fulfill the purpose for which it was collected, unless a longer retention period is necessary to comply with legal obligations, resolve disputes, protect our assets or comply with judicial/extrajudicial agreements.\nTo determine the retention period of your personal data, in addition to the criteria indicated above, we rely on the following criteria:\n- Existence of a legal or contractual obligation to retain personal data;\n- Need for personal data for investigation, audit or regular exercise of our rights in judicial, administrative or arbitration proceedings;\n- Usefulness of personal data for the purpose of maintaining accurate records, especially financial and educational.\nWe may keep your personal data, in an anonymized form, that is, in a form that no longer refers to you personally, for statistical purposes, without time limit, to the extent that we have a legitimate interest and legal support.\n\n6. How do we keep your personal data secure?\n\n -We adopt administrative and technical measures, which are continually monitored and reviewed, in accordance with technological advances, capable of keeping your personal data under our responsibility protected from unauthorized access and accidental or unlawful situations of destruction, loss, alteration, communication or any other form of inadequate or unlawful processing.\nOur electronic systems and physical files meet appropriate information security standards, such as:\n- Restricted control of internal access;\n- Protection against unauthorized access using double authentication instruments, passwords and keys;\n- Maintenance of an inventory of accesses, with the time, duration, identification of the person responsible for the access and data accessed.\nAny legally required communications regarding possible security incidents that may result in loss of availability, confidentiality or integrity of the personal data under our responsibility will be duly notified to the competent authorities and the affected data subjects.\n\n7. What are your rights? You, as the holder of personal data, have the following rights regarding your personal data:\n\n8. Third-party policies and updates to this policy\n\nWe are not responsible for the privacy practices of third parties. Therefore, whenever you are directed to a domain other than HELP and/or have access, as a result of your relationship with us, to third-party services not controlled by us, we recommend that you review their respective privacy statements and contact the responsible third party directly if you have any questions.\nWe may occasionally update this Policy. Whenever there is a significant material change, such as regarding the purpose for which we process your personal data, as well as the form and duration of the processing, we will use reasonable efforts to inform you of the modifications.\n\n9. Questions?\n\nIf you have any questions about this Policy or how we process your personal data, please contact us by email:\n\npedrãokambanscrum@gmail.com\nHELP Data Controller\nContact: pedrãokambanscrum@gmail.com',
      'es': '',
    },
    'mgzvrily': {
      'pt': 'Home',
      'en': 'Home',
      'es': '',
    },
  },
  // Ajuda
  {
    '67wuni0b': {
      'pt': 'Ajuda',
      'en': 'Terms and conditions',
      'es': '',
    },
    '24uv4jy5': {
      'pt': 'Aqui você encontra o que precisa!',
      'en':
          'By agreeing to these terms and conditions, you allow HELP to use your data for commercial purposes in a conscious manner, respecting anonymity and following Brazilian laws.',
      'es': '',
    },
    'uqtdu7kn': {
      'pt': 'Home',
      'en': 'Home',
      'es': '',
    },
  },
  // Faleconosco
  {
    'nyu9nn6g': {
      'pt': 'Fale conosco',
      'en': 'Contact us',
      'es': 'Contáctenos',
    },
    '4abhstg7': {
      'pt': 'Verifique nossos canais de atendimento',
      'en': 'Check our service channels',
      'es': 'Consulta nuestros canales de atención',
    },
    'rsby7abo': {
      'pt': 'Email',
      'en': 'E-mail',
      'es': 'Correo electrónico',
    },
    'v88zlwbh': {
      'pt': 'Whatsapp',
      'en': 'Whatsapp',
      'es': 'Whatsapp',
    },
    'n5b5c7eg': {
      'pt': 'Telefone',
      'en': 'Telephone',
      'es': 'Teléfono',
    },
    'ghc6sra5': {
      'pt': 'Twitter',
      'en': 'Twitter',
      'es': 'Gorjeo',
    },
    'waviwmox': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // Conversas
  {
    'zxbtep2d': {
      'pt': 'Olá boa tarde',
      'en': '',
      'es': '',
    },
    'gx0gnb5i': {
      'pt': 'Gostaria de saber sobre trabalhos',
      'en': '',
      'es': '',
    },
    'mxbj7taj': {
      'pt': 'Boa tarde!',
      'en': '',
      'es': '',
    },
    '0bn4qnpg': {
      'pt': 'Certo, o que gostaria de saber?',
      'en': '',
      'es': '',
    },
    'tmzrq3xt': {
      'pt': 'Pedro Henrique',
      'en': '',
      'es': '',
    },
    '9sdv4lke': {
      'pt': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Paymente_card
  {
    'yg4v40kq': {
      'pt': 'Finalizar compra',
      'en': '',
      'es': '',
    },
    'm45c51ix': {
      'pt': 'Fill in the information below to place your order.',
      'en': '',
      'es': '',
    },
    'b6ih962j': {
      'pt': 'Price Breakdown',
      'en': '',
      'es': '',
    },
    '142ry0te': {
      'pt': 'Base Price',
      'en': '',
      'es': '',
    },
    'de55j5la': {
      'pt': '\$156.00',
      'en': '',
      'es': '',
    },
    '3uh384ry': {
      'pt': 'Taxes',
      'en': '',
      'es': '',
    },
    'k2s16ef1': {
      'pt': '\$24.20',
      'en': '',
      'es': '',
    },
    'xvdsmalb': {
      'pt': 'Cleaning Fee',
      'en': '',
      'es': '',
    },
    'vhd03jgx': {
      'pt': '\$40.00',
      'en': '',
      'es': '',
    },
    '4w09t3g5': {
      'pt': 'Total',
      'en': '',
      'es': '',
    },
    'r9irzk0y': {
      'pt': '\$230.20',
      'en': '',
      'es': '',
    },
    '5r6hcadb': {
      'pt': 'Pay w/ Credit Card',
      'en': '',
      'es': '',
    },
    '4tk0x4r5': {
      'pt': 'Or use an option below',
      'en': '',
      'es': '',
    },
    'visvkiq1': {
      'pt': 'Apple Pay',
      'en': '',
      'es': '',
    },
    'e1g7oqug': {
      'pt': 'Pay w/Paypal',
      'en': '',
      'es': '',
    },
  },
  // Miscellaneous
  {
    'yb5n6avh': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'bft9oz5c': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'jxz355no': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '34nzo9ra': {
      'pt': 'Precisamos da sua localização para melhorar nossos serviços',
      'en': '',
      'es': '',
    },
    '5xk6qv7t': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'w7og0gym': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '9ys94lp2': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'l1rucnk8': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '37u4nn2g': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'nglrxnjj': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'g8r8153q': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'wa1lx7rs': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '4ia1ixvs': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'fezs87y7': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'yarvz4ng': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'muuvdrjw': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'abeshkno': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'lmkzqpuq': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'k5h1gyq0': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'glcyzx2u': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '5srx2x2q': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'mmpkxiab': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'fexsa6uq': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'gtx9foai': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'ekh4yfh3': {
      'pt': '',
      'en': '',
      'es': '',
    },
    '0uuecpzt': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'b3m6t09u': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'oifxh1r3': {
      'pt': '',
      'en': '',
      'es': '',
    },
    'ph5ad7vq': {
      'pt': '',
      'en': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
