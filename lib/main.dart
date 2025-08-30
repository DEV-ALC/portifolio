import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfólio Dev',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900],
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(
          displayLarge: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 48),
          headlineMedium: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
          bodyLarge: TextStyle(color: Colors.grey[300], fontSize: 18),
          bodyMedium: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      duration: const Duration(seconds: 1),
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
          // AppBar customizada fixa no topo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.grey[900]!.withOpacity(0.9),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildNavButton(context, 'Sobre', _sobreKey),
                _buildNavButton(context, 'Projetos', _projetosKey),
                _buildNavButton(context, 'Contato', _contatoKey),
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
                  // SobreSection(key: _sobreKey),
                  // ProjetosSection(key: _projetosKey),
                  // ContatoSection(key: _contatoKey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () => _scrollToSection(key),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final GlobalKey projetosKey;

  const HeroSection(
      {super.key, required this.fadeAnimation, required this.projetosKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey[900]!, Colors.purple[900]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 100, color: Colors.blueGrey),
              ),
              const SizedBox(height: 24),
              Text(
                'Alcemir Henrique',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Desenvolvedor Junior, especializado em Flutter e Integrações Comerciais',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToSection(BuildContext context, GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
}

class SobreSection extends StatelessWidget {
  const SobreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.grey[850],
      child: Column(
        children: [
          Text(
            'Sobre',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 32,
            runSpacing: 32,
            children: [
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    Text(
                      'Sou desenvolvedor júnior, focado em soluções de automação comercial com Flutter. Tenho experiência em integração de hardware (balanças, impressoras térmicas e terminais de pagamento) e atualmente estudo Go (Golang)e C#, para backend escalávelna AWS.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  'Flutter',
                  'Dart',
                  'Golang',
                  'C#',
                  'Php',
                  'MySql',
                  'Postgres',
                ]
                    .map((skill) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueGrey[700]!,
                                Colors.purple[700]!
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            skill,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjetosSection extends StatelessWidget {
  const ProjetosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projetos = [
      {
        'nome': 'Carteira Despesas',
        'descricao':
            'Aplicação Mobile, com foco em dashboard e despesas, offline/online',
        'link': 'https://github.com/DEV-ALC/mywallet',
      },
      {
        'nome': 'Backend Sincronização offline',
        'descricao': 'API para sincronização com banco/Autentificação JWT',
        'link': 'https://github.com/DEV-ALC/api_mywallet',
      },
      {
        'nome': 'Automação Comercial',
        'descricao':
            'Cadastros Vendas (Comanda/Mesa, Checkout,PDV), Pagamento Pix',
        'link': '',
      },
         {
        'nome': 'Automação Comercial Balança',
        'descricao':
            'Automatização de pesagem, interação impressoras, Auto Atendimento, Desktop/Mobile',
        'link': '',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.grey[900],
      child: Column(
        children: [
          Text(
            'Projetos',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: projetos
                .map((projeto) => ProjectCard(
                      nome: projeto['nome']!,
                      descricao: projeto['descricao']!,
                      link: projeto['link']!,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String nome;
  final String descricao;
  final String link;

  const ProjectCard({
    super.key,
    required this.nome,
    required this.descricao,
    required this.link,
  });

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
                ? [Colors.purple[700]!, Colors.blueGrey[700]!]
                : [Colors.grey[700]!, Colors.grey[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
          onTap:widget.link!=''? () async {
            final url = Uri.parse(widget.link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          }:(){},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.nome,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.descricao,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              if(widget.link!='')
              TextButton(
                onPressed: () async {
                  final url = Uri.parse(widget.link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: Text(
                  'Ver Projeto',
                  style: TextStyle(
                    color: Colors.purple[300],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContatoSection extends StatelessWidget {
  const ContatoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.grey[850],
      child: Column(
        children: [
          Text(
            'Informações de contato',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
              _buildSocialButton(
                icon: Icons.email,
                text: 'henriquesantos1703m@gmail.com',
                url: 'mailto:henriquesantos1703m@gmail.com',
              ),
              _buildSocialButton(
                icon: Icons.link,
                text: 'linkedin',
                url: 'https://linkedin.com/in/henrique-3967a418a',
              ),
              _buildSocialButton(
                icon: Icons.code,
                text: 'github.com/DEV-ALC',
                url: 'https://github.com/DEV-ALC',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
      {required IconData icon, required String text, required String url}) {
    return TextButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      icon: Icon(icon, color: Colors.purple[300]),
      label: Text(
        text,
        style:
            TextStyle(color: Colors.purple[300], fontWeight: FontWeight.w600),
      ),
    );
  }
}
