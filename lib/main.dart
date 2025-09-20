import 'package:flutter/material.dart';
import 'dart:html' hide VoidCallback;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const PortfolioApp());
}

// =====================
// TEMAS LIGHT E DARK
// =====================
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blueGrey[900],
  scaffoldBackgroundColor: Colors.blue[50],
  canvasColor: Colors.blue[100],
  cardColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.cyan[300]),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 48),
    headlineMedium: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
    headlineSmall: TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
    bodyLarge: TextStyle(color: Colors.black87, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 16),
    bodySmall: TextStyle(color: Colors.black54, fontSize: 14),
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
    elevation: 8,
    margin: EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(Colors.cyan[300]),
    trackColor: WidgetStateProperty.all(Colors.cyan[100]),
    trackOutlineColor: WidgetStateProperty.all(Colors.cyan[100]),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey[900],
  scaffoldBackgroundColor: Colors.grey[900],
  canvasColor: Colors.grey[850],
  cardColor: Colors.grey[800],
  iconTheme: IconThemeData(color: Colors.purple[400]),
  textTheme: TextTheme(
    displayLarge: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 48),
    headlineMedium: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
    headlineSmall: TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
    bodyLarge: TextStyle(color: Colors.grey[300], fontSize: 18),
    bodyMedium: TextStyle(color: Colors.grey[400], fontSize: 16),
    bodySmall: TextStyle(color: Colors.grey[400], fontSize: 14),
  ),
  cardTheme: CardTheme(
    color: Colors.grey[800],
    elevation: 8,
    margin: const EdgeInsets.all(12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(Colors.purple[300]),
    trackColor: WidgetStateProperty.all(Colors.purple[100]),
    trackOutlineColor: WidgetStateProperty.all(Colors.purple[100]),
  ),
);

// =====================
// PORTFOLIO APP
// =====================
class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool temaEscuro = false;

  @override
  void initState() {
    super.initState();
    temaEscuro = window.localStorage['tema'] == 'escuro';
  }

  void alternarTema() {
    setState(() {
      temaEscuro = !temaEscuro;
      window.localStorage['tema'] = temaEscuro ? 'escuro' : 'claro';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio Dev',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: temaEscuro ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(
        temaEscuro: temaEscuro,
        alternarTema: alternarTema,
      ),
    );
  }
}

// =====================
// HOME PAGE
// =====================
class HomePage extends StatefulWidget {
  final bool temaEscuro;
  final VoidCallback alternarTema;

  const HomePage(
      {super.key, required this.temaEscuro, required this.alternarTema});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final _homeKey = GlobalKey();
  final _sobreKey = GlobalKey();
  final _projetosKey = GlobalKey();
  final _contatoKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AppBar customizada
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Theme.of(context).canvasColor.withOpacity(0.9),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildNavButton('Sobre', _sobreKey),
                _buildNavButton('Projetos', _projetosKey),
                _buildNavButton('Contato', _contatoKey),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Theme.of(context).brightness == Brightness.dark
                        ? const Icon(Icons.brightness_5, color: Colors.white)
                        : const Icon(Icons.brightness_2, color: Colors.black),
                    Switch(
                      value: widget.temaEscuro,
                      onChanged: (_) => widget.alternarTema(),
                      activeColor: Colors.purpleAccent,
                      inactiveThumbColor: Colors.blueGrey,
                      inactiveTrackColor: Colors.grey[400],
                    ),
                  ],
                )
              ],
            ),
          ),
          // Scroll principal
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeroSection(
                    fadeAnimation: _fadeAnimation,
                    projetosKey: _projetosKey,
                    key: _homeKey,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const SobreSection(
                      key: Key('sobre'),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: const ProjetosSection(
                      key: Key('projetos'),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const ContatoSection(
                      key: Key('contato'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: () => _scrollToSection(key),
        child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}

// =====================
// HERO SECTION
// =====================
class HeroSection extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final GlobalKey projetosKey;

  const HeroSection(
      {super.key, required this.fadeAnimation, required this.projetosKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: Theme.of(context).brightness == Brightness.dark
              ? [Colors.blueGrey[900]!, Colors.purple[900]!]
              : [Colors.cyan[400]!, Colors.blue[200]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://media.licdn.com/dms/image/v2/D4D03AQHcj3-pYe8jfQ/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1704906484079?e=1759968000&v=beta&t=KeIWZcP9x1YGs5DciA3OnCunpkasGppQCjgJ1yEwr50',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 40, color: Colors.red),
                ),
              ),
              const SizedBox(height: 24),
              Text('Alcemir Henrique',
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text(
                  'Desenvolvedor, especializado em Flutter e Integrações Comerciais',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================
// SOBRE SECTION
// =====================
class SobreSection extends StatelessWidget {
  const SobreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          Text(
            'Sobre',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 16,
            children: [
              SizedBox(
                child: Text(
                  'Sou desenvolvedor, focado em soluções de automação comercial com Flutter. Tenho experiência em integração de hardware (balanças, impressoras térmicas e terminais de pagamento) e atualmente estudo Go (Golang) e C#, para backend escalável na AWS.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  'Flutter',
                  'TypeScript',
                  'Golang',
                  'C#',
                  'SQL',
                ]
                    .map((skill) => ConstrainedBox(
                          constraints:
                              const BoxConstraints(minWidth: 60, maxWidth: 120),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? [
                                        Colors.blueGrey[900]!,
                                        Colors.purple[800]!
                                      ]
                                    : [Colors.blue[200]!, Colors.cyan[400]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              skill,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// =====================
// PROJETOS SECTION
// =====================
class ProjetosSection extends StatelessWidget {
  const ProjetosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projetos = [
      {
        'nome': 'Carteira Despesas',
        'descricao':
            'Aplicação Mobile, com foco em dashboard de despesas, offline/online',
        'link': 'https://github.com/DEV-ALC/mywallet',
      },
      {
        'nome': 'Backend Sincronização offline',
        'descricao':
            'API backend para sincronização com banco/Autentificação JWT',
        'link': 'https://github.com/DEV-ALC/api_mywallet',
      },
      {
        'nome': 'Cardapio comercial',
        'descricao':
            'Sistema de gestão para restaurantes, incluindo cadastro de produtos, cardápio e pedidos. Voltado também para soft-houses e revendas.',
        'link': 'https://github.com/DEV-ALC/cardapio',
      },
      {
        'nome': 'Backend Cardapio',
        'descricao':
            'Servidor TypeScript, Projetado para servir por meio do wrangles(Cloudflare), autenticação JWT',
        'link': 'https://github.com/DEV-ALC/api-cardapio',
      },
      {
        'nome': 'Automação Comercial',
        'descricao':
            'Sistema de automação comercial com cadastros de vendas, gerenciamento de comanda/mesa, checkout e pagamentos,disponível para desktop e mobile.',
        'link': '',
      },
      {
        'nome': 'Automação Comercial Balança',
        'descricao':
            'Sistema de automação comercial integrado à balança, com suporte a impressoras e autoatendimento, disponível para desktop e mobile.',
        'link': '',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text('Projetos', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: projetos
                .map((p) => ProjectCard(
                    nome: p['nome']!,
                    descricao: p['descricao']!,
                    link: p['link']!))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// =====================
// PROJECT CARD
// =====================
class ProjectCard extends StatefulWidget {
  final String nome;
  final String descricao;
  final String link;

  const ProjectCard(
      {super.key,
      required this.nome,
      required this.descricao,
      required this.link});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 350,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovered
                ? Theme.of(context).brightness == Brightness.dark
                    ? [Colors.blueGrey[900]!, Colors.purple[900]!]
                    : [Colors.blue[200]!, Colors.cyan[400]!]
                : [theme.cardColor, theme.cardColor],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.4 : 0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: GestureDetector(
          onTap: widget.link != ''
              ? () async {
                  final url = Uri.parse(widget.link);
                  if (await canLaunchUrl(url)) await launchUrl(url);
                }
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.nome,
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: theme.textTheme.bodyMedium?.color)),
              const SizedBox(height: 12),
              Text(widget.descricao, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
              if (widget.link != '')
                TextButton(
                  onPressed: () async {
                    final url = Uri.parse(widget.link);
                    if (await canLaunchUrl(url)) await launchUrl(url);
                  },
                  child: Text('Ver Projeto',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.textTheme.bodyMedium?.color)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================
// CONTATO SECTION
// =====================
class ContatoSection extends StatelessWidget {
  const ContatoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          Text('Informações de contato',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 32),
          Text(
            'Gostaria de trabalhar comigo ou saber mais sobre meus projetos? Envie uma mensagem!',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialButton(context,
                  icon: Icons.email,
                  text: 'henriquesantos1703m@gmail.com',
                  url: 'mailto:henriquesantos1703m@gmail.com'),
              _buildSocialButton(context,
                  icon: Icons.link,
                  text: 'linkedin',
                  url: 'https://linkedin.com/in/henrique-3967a418a'),
              _buildSocialButton(context,
                  icon: Icons.code,
                  text: 'github.com/DEV-ALC',
                  url: 'https://github.com/DEV-ALC'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(context,
      {required IconData icon, required String text, required String url}) {
    return TextButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      icon: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.purple[400]
            : Colors.cyan[400],
      ),
      label: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
