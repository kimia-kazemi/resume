import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:html' as html;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'providers/language_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageProvider _languageProvider = LanguageProvider();

  @override
  void dispose() {
    _languageProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _languageProvider,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kimia Kazemi — Portfolio',
          locale: _languageProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('fa'),
            Locale('ku'),
            Locale('tr'),
            Locale('es'),
          ],
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF0D0F1A),
            textTheme: GoogleFonts.spaceGroteskTextTheme(
              Theme.of(context).textTheme,
            ).apply(bodyColor: Colors.white, displayColor: Colors.white),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6EF3A5),
              secondary: Color(0xFF5AC8FA),
              background: Color(0xFF0D0F1A),
            ),
            useMaterial3: true,
          ),
          home: ResumePage(languageProvider: _languageProvider),
        );
      },
    );
  }
}

class ResumePage extends StatefulWidget {
  final LanguageProvider languageProvider;

  const ResumePage({super.key, required this.languageProvider});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'work': GlobalKey(),
    'about': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.1, // Scroll to show section near the top
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Scaffold(
      body: Stack(
        children: [
          const _NeonGradientBackground(),
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 48,
                    vertical: isMobile ? 32 : 48,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _NavBar(
                        isMobile: isMobile,
                        onLinkTap: _scrollToSection,
                        languageProvider: widget.languageProvider,
                      ),
                      const SizedBox(height: 40),
                      _RevealOnScroll(
                        id: 'hero',
                        child: _HeroSection(
                          isMobile: isMobile,
                          onLinkTap: _scrollToSection,
                        ),
                      ),
                      const SizedBox(height: 80),
                      _RevealOnScroll(
                        id: 'stats',
                        child: _StatsRow(isMobile: isMobile),
                      ),
                      const SizedBox(height: 64),
                      _RevealOnScroll(
                        id: 'about',
                        key: _sectionKeys['about'],
                        child: _AboutSection(isMobile: isMobile),
                      ),
                      const SizedBox(height: 64),
                      _RevealOnScroll(
                        id: 'experience',
                        child: _ExperienceSection(isMobile: isMobile),
                      ),
                      const SizedBox(height: 64),
                      _RevealOnScroll(
                        id: 'projects',
                        key: _sectionKeys['work'],
                        child: _ProjectsSection(isMobile: isMobile),
                      ),
                      const SizedBox(height: 64),
                      _RevealOnScroll(
                        id: 'contact',
                        key: _sectionKeys['contact'],
                        child: _ContactSection(isMobile: isMobile),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NeonGradientBackground extends StatelessWidget {
  const _NeonGradientBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D0F1A), Color(0xFF080A14)],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: _blurCircle(const Color(0xFF5AC8FA), 200),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _blurCircle(const Color(0xFF6EF3A5), 260),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: _blurCircle(const Color(0xFF9B8CFF), 220),
        ),
      ],
    );
  }

  Widget _blurCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(.25),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.35),
            blurRadius: size / 2,
            spreadRadius: size / 6,
          ),
        ],
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final bool isMobile;
  final Function(String) onLinkTap;
  final LanguageProvider languageProvider;

  const _NavBar({
    required this.isMobile,
    required this.onLinkTap,
    required this.languageProvider,
  });

  void openResume() {
    html.window.open('assets/final_resume.pdf', '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final links = [
      {'label': l10n.work, 'id': 'work'},
      {'label': l10n.about, 'id': 'about'},
      {'label': l10n.contact, 'id': 'contact'},
    ];

    final languages = [
      {'code': 'en', 'name': 'English', 'flag': 'united-kingdom'},
      {'code': 'fa', 'name': 'فارسی', 'flag': 'iran'},
      // {'code': 'ku', 'name': 'کوردی', 'flag': 'kurdistan'},
      {'code': 'tr', 'name': 'Türkçe', 'flag': 'turkey'},
      {'code': 'es', 'name': 'Español', 'flag': 'spain'},
    ];

    final currentLang = languages.firstWhere(
      (lang) => lang['code'] == languageProvider.locale.languageCode,
      orElse: () => languages[0],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(.08)),
              ),
              child: const Center(
                child: Text(
                  'KK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Kimia Kazemi',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(.8),
                fontWeight: FontWeight.w600,
                letterSpacing: .5,
              ),
            ),
          ],
        ),
        if (!isMobile)
          Row(
            children: [
              for (final link in links)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () => onLinkTap(link['id']!),
                    child: Text(
                      link['label']!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate().fadeIn(delay: (links.indexOf(link) * 150).ms),
                ),
              const SizedBox(width: 8),
              // Language Switcher
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(.1)),
                ),
                child: PopupMenuButton<String>(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/${currentLang['flag']}.png',
                        width: 14,
                        height: 14,
                      ),

                      const SizedBox(width: 6),
                      Text(
                        currentLang['name']!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white.withOpacity(.7),
                        size: 20,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: const Color(0xFF1A1D2E),
                  onSelected: (String code) {
                    languageProvider.setLanguageCode(code);
                  },
                  itemBuilder: (BuildContext context) {
                    return languages.map((lang) {
                      final isSelected =
                          lang['code'] == languageProvider.locale.languageCode;
                      return PopupMenuItem<String>(
                        value: lang['code']!,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/${lang['flag']}.png',
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              lang['name']!,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF6EF3A5)
                                    : Colors.white.withOpacity(.8),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            if (isSelected) ...[
                              const Spacer(),
                              const Icon(
                                Icons.check,
                                color: Color(0xFF6EF3A5),
                                size: 18,
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              const SizedBox(width: 8),
              PrimaryButton(
                label: l10n.downloadResume,
                icon: Icons.download_rounded,
                onTap: openResume,
              ),
            ],
          )
        else
          Row(
            children: [
              // Language Switcher for mobile
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(.1)),
                ),
                child: PopupMenuButton<String>(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/${currentLang['flag']}.png',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white.withOpacity(.7),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: const Color(0xFF1A1D2E),
                  onSelected: (String code) {
                    languageProvider.setLanguageCode(code);
                  },
                  itemBuilder: (BuildContext context) {
                    return languages.map((lang) {
                      final isSelected =
                          lang['code'] == languageProvider.locale.languageCode;
                      return PopupMenuItem<String>(
                        value: lang['code']!,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/${lang['flag']}.png',
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              lang['name']!,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF6EF3A5)
                                    : Colors.white.withOpacity(.8),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            if (isSelected) ...[
                              const Spacer(),
                              const Icon(
                                Icons.check,
                                color: Color(0xFF6EF3A5),
                                size: 18,
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu, color: Colors.white),
              ),
            ],
          ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final Function(String) onLinkTap;

  const _HeroSection({required this.isMobile, required this.onLinkTap});

  void openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: isMobile ? 0 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                backgroundColor: Colors.white.withOpacity(.08),
                side: BorderSide(color: Colors.white.withOpacity(.08)),
                label: Text(
                  l10n.availableForFreelance,
                  style: const TextStyle(color: Colors.white),
                ),
              ).animate().fadeIn(duration: 450.ms),
              const SizedBox(height: 18),
              RichText(
                text: TextSpan(
                  text: l10n.hiIAm,
                  style: const TextStyle(
                    fontSize: 52,
                    height: 1.1,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Kimia Kazemi',
                      style: TextStyle(
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [Color(0xFF6EF3A5), Color(0xFF5AC8FA)],
                          ).createShader(const Rect.fromLTWH(0, 0, 220, 60)),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 50.ms),
              const SizedBox(height: 14),
              _FancyHeadline()
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 120.ms)
                  .slideY(begin: .15, end: 0, curve: Curves.easeOut),
              const SizedBox(height: 18),
              Text(
                l10n.heroDescription,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  height: 1.5,
                  color: Colors.white.withOpacity(.72),
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 150.ms),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  PrimaryButton(
                    label: l10n.viewWork,
                    icon: Icons.arrow_outward_rounded,
                    onTap: () => onLinkTap('work'),
                  ),
                  _GhostButton(
                    label: l10n.letsTalk,
                    icon: Icons.mail_outline_rounded,
                    onTap: () => onLinkTap('contact'),
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms, delay: 180.ms),
              const SizedBox(height: 28),
              Row(
                children: [
                  _SocialIcon(FontAwesomeIcons.linkedinIn, () {
                    openLink(
                      'https://www.linkedin.com/in/kimia-kazemi-2308b0198/',
                    );
                  }),
                  SizedBox(width: 12),
                  _SocialIcon(FontAwesomeIcons.github, () {
                    openLink('https://github.com/kimia-kazemi');
                  }),
                  SizedBox(width: 12),
                  _SocialIcon(FontAwesomeIcons.telegram, () {
                    openLink('https://t.me/Kimia_kzm');
                  }),
                ],
              ).animate().fadeIn(duration: 500.ms, delay: 220.ms),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 40 : 0, width: isMobile ? 0 : 40),
        Expanded(
          flex: isMobile ? 0 : 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: _PortraitCard(isMobile: isMobile),
          ),
        ),
      ],
    );
  }
}

class _FancyHeadline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final words = l10n.flutterEngineer.split(' ');
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Text(
          l10n.a,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
        ),
        ...words.map((word) => _GlowingPill(word: word)),
        Text(
          l10n.craftingBeautiful,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _GlowingPill extends StatelessWidget {
  final String word;

  const _GlowingPill({required this.word});

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF6EF3A5),
      const Color(0xFF5AC8FA),
      const Color(0xFF9B8CFF),
    ]..shuffle(Random());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(.4),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        word,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _PortraitCard extends StatelessWidget {
  final bool isMobile;

  const _PortraitCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: isMobile ? double.infinity : 400,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.04),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(.06)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.4),
                blurRadius: 24,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: isMobile ? 260 : 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF111528), Color(0xFF0E1B2E)],
                  ),
                  border: Border.all(color: Colors.white.withOpacity(.06)),
                ),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/avatar_me.png',
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.08),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.verified_rounded,
                              color: Color(0xFF6EF3A5),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '5 ${AppLocalizations.of(context)!.projectsShipped}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _Tag(label: 'Flutter'),
                  _Tag(label: 'Dart'),
                  _Tag(label: 'Git Source Control'),
                  _Tag(label: 'Git Flow'),
                  _Tag(label: 'UI/UX'),
                  _Tag(label: 'Figma'),
                  _Tag(label: 'Web'),
                  _Tag(label: 'Mobile'),
                  _Tag(label: 'Socket'),
                  _Tag(label: 'Rest Api'),
                  _Tag(label: 'Deep Link'),
                  _Tag(label: 'FireBase'),
                  _Tag(label: 'BloC'),
                  _Tag(label: 'GetX'),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 500.ms, delay: 180.ms)
        .scale(begin: const Offset(.98, .98));
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final bool isMobile;

  const _StatsRow({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stats = [
      ('3+', l10n.yearsExperience),
      ('4', l10n.launchedProjects),
      // ('50+', 'Products shipped'),
      // ('3', 'Continents served'),
    ];

    return GridView.builder(
      itemCount: stats.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        childAspectRatio: isMobile ? 1.4 : 1.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final stat = stats[index];
        return _FrostedCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stat.$1,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                stat.$2,
                style: TextStyle(color: Colors.white.withOpacity(.7)),
              ),
            ],
          ),
        ).animate().fadeIn(delay: (120 * index).ms).slideY(begin: .12, end: 0);
      },
    );
  }
}

class _AboutSection extends StatelessWidget {
  final bool isMobile;

  const _AboutSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _SectionShell(
      title: l10n.aboutTitle,
      description: l10n.aboutDescription,
      child: Wrap(
        spacing: 18,
        runSpacing: 18,
        children: [
          _PillInfo(icon: Icons.palette_rounded, label: l10n.figmaUIUX),
          _PillInfo(icon: Icons.code_rounded, label: l10n.flutter),
          _PillInfo(icon: Icons.rocket_launch_rounded, label: l10n.goToMarket),
          _PillInfo(
            icon: Icons.people_alt_rounded,
            label: l10n.mentorshipLeadership,
          ),
        ],
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  final bool isMobile;

  const _ExperienceSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final items = [
      ExperienceItem(
        company: 'Hecate - Dambin',
        role: 'Flutter Developer',
        period: '2022 — Now',
        summary:
            """At Hecate, I also developed a pet services app, focusing on smooth animations, modern UI, and a seamless user experience.
This project stood out for me personally, as it allowed me to combine my love for pets with designing an app that users truly enjoy.""",
      ),
      ExperienceItem(
        company: 'Hecate - Kalitam',
        role: 'Flutter Developer',
        period: 'May 2025 — Nov 2025',
        summary:
            """The first product I built at Hecate was called Kalitam, a scalable design app for managing apartment culture.
Working at Hecate, I gained many valuable skills, including extensive experience with BLoC architecture.""",
      ),
      ExperienceItem(
        company: 'Befarman',
        role: 'Flutter Developer',
        period: 'Jul 2023 — Feb 2024',
        summary:
            """I spent 7 months as a Flutter Developer at Befarman, gaining valuable experience and contributing to projects across PWA and Android app platforms.""",
      ),
      ExperienceItem(
        company: 'Robord',
        role: 'Flutter Developer/ Mentor',
        period: 'Feb 2023 — Oct 2024',
        summary:
            """I have a year and a half of professional experience as a Senior Flutter Developer at Robord, including a couple of months as an intern where I received mentorship.
During this time, I designed and built the Flutter application from scratch, delivering a complete, end-to-end product.""",
      ),
      ExperienceItem(
        company: 'Rdesk',
        role: 'Flutter Developer/ Mentor',
        period: 'Nov 2023 — Des 2023',
        summary:
            """I contributed to Rdesk, a collaborative project, where I improved the UI, updated the color palette, enhanced UX, and made the app more responsive.
This project lasted 1 month and involved working closely with a small team of developers.""",
      ),
    ];

    final l10n = AppLocalizations.of(context)!;
    return _SectionShell(
      title: l10n.experienceTitle,
      description: l10n.experienceDescription,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            _TimelineCard(
              item: items[i],
              isMobile: isMobile,
            ).animate().fadeIn(delay: (120 * i).ms).slideX(begin: -.08, end: 0),
            if (i != items.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class ExperienceItem {
  final String company;
  final String role;
  final String period;
  final String summary;

  ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.summary,
  });
}

class _TimelineCard extends StatelessWidget {
  final ExperienceItem item;
  final bool isMobile;

  const _TimelineCard({required this.item, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return _FrostedCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF6EF3A5), Color(0xFF5AC8FA)],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.company,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.role,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.summary,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.74),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile)
            Text(
              item.period,
              style: TextStyle(color: Colors.white.withOpacity(.65)),
            ),
        ],
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  final bool isMobile;

  const _ProjectsSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final projects = [
      Project(
        title: 'Kalitam',
        subtitle: 'Smart Building Management System',
        tags: [
          'Mobile',
          'Web App',
          'Socket',
          'MVVM',
          'BloC',
          'Firebase',
          'Rest Api',
        ],
        weblink: 'https://app.kalitam.ir/',
        marketLink: 'https://myket.ir/app/ir.hecateco.kalitam',
        avatar:
            'https://myket.ir/app-icon/d84709c6-fdef-41ef-bb55-95c165fa5324.png',
      ),
      Project(
        title: 'Dambin',
        subtitle: 'Smart Pet Care & Services App',
        tags: ['BloC', 'MVVM', 'Firebase', 'Mobile', 'Rest Api'],
      ),
      Project(
        title: 'Robord',
        subtitle: 'Academic Social Network for Students',
        tags: [
          'Mobile',
          'GetX',
          'Clean',
          'Firebase',
          'Web App',
          'Deep Link',
          'Rest Api',
        ],
        marketLink: 'https://myket.ir/app/robord.application',
        weblink: 'https://robord.ir/',
        avatar:
            'https://myket.ir/app-icon/d84709c6-fdef-41ef-bb55-95c165fa5324.png',
      ),
      Project(
        title: 'Befarman',
        subtitle: 'Peer-to-Peer Car Rental Platform',
        tags: ['Mobile', 'GetX', 'Firebase', 'Web App', 'Rest Api'],
        marketLink: 'https://myket.ir/app/com.befarman.carrental',
        weblink: 'https://befarman.com/',
        avatar:
            'https://myket.ir/app-icon/com.befarman.carrental_c17e3bca-1a38-4c1c-8057-fb81044ff69f.png',
      ),
      Project(
        title: 'RDesk',
        subtitle: 'High-Performance Remote Desktop Control Software',
        tags: ['Design', 'GetX'],
        weblink: 'https://rdesk.ir/',
      ),
    ];

    final l10n = AppLocalizations.of(context)!;
    return _SectionShell(
      title: l10n.recentWork,
      description: l10n.projectsDescription,
      child: GridView.builder(
        itemCount: projects.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 1 : 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isMobile ? 1.6 : 0.92,
        ),
        itemBuilder: (context, index) {
          final p = projects[index];
          return _ProjectCard(project: p)
              .animate()
              .fadeIn(delay: (80 * index).ms)
              .scale(begin: const Offset(.97, .97));
        },
      ),
    );
  }
}

class Project {
  final String title;
  final String subtitle;
  final String? marketLink;
  final String? weblink;
  final String? avatar;
  final List<String> tags;

  Project({
    required this.title,
    required this.subtitle,
    required this.tags,
    this.marketLink,
    this.weblink,
    this.avatar,
  });
}

class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard({required this.project});

  void openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _FrostedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF121930), Color(0xFF0E1B2E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white.withOpacity(.05)),
              ),
              child: project.avatar == null
                  ? const Center(
                      child: Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white54,
                        size: 48,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child:
                          project.avatar != null && project.avatar!.isNotEmpty
                          ? Image.network(
                              project.avatar!,
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    color: Colors.white54,
                                    size: 48,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Icon(
                                Icons.auto_awesome_rounded,
                                color: Colors.white54,
                                size: 48,
                              ),
                            ),
                    ),
            ),
          ),

          const SizedBox(height: 14),
          Text(
            project.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            project.subtitle,
            style: TextStyle(color: Colors.white.withOpacity(.72)),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.tags.map((t) => _Tag(label: t)).toList(),
          ),
          const SizedBox(height: 12),
          if (project.marketLink != null)
            InkWell(
              onTap: () {
                openLink(project.marketLink!);
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.viewAppOnMarket,
                    style: TextStyle(
                      color: const Color(0xFF6EF3A5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.north_east_rounded,
                    size: 18,
                    color: Color(0xFF6EF3A5),
                  ),
                ],
              ),
            ),
          if (project.weblink != null)
            InkWell(
              onTap: () {
                openLink(project.weblink!);
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.viewWebsite,
                    style: TextStyle(
                      color: const Color(0xFF6EF3A5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.north_east_rounded,
                    size: 18,
                    color: Color(0xFF6EF3A5),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  final bool isMobile;

  const _ContactSection({required this.isMobile});

  void _bookCall() async {
    // Replace with your actual calendar booking link (e.g., Calendly, Google Calendar)
    const calendarUrl =
        'https://calendly.com/kimiakazemi'; // Update this with your link
    final uri = Uri.parse(calendarUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _sendEmail() async {
    // Replace with your actual email address
    const email = 'kimiakazemi7911@gmail.com'; // Update this with your email
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=Let\'s work together&body=Hi Kimia,', // Optional: pre-fill subject and body
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _FrostedCard(
      padding: EdgeInsets.all(isMobile ? 24 : 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.letsBuildSomething,
            style: TextStyle(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.currentlyAccepting,
            style: TextStyle(
              color: Colors.white.withOpacity(.72),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              PrimaryButton(
                label: l10n.bookACall,
                icon: Icons.calendar_today_rounded,
                onTap: _bookCall,
              ),
              _GhostButton(
                label: l10n.emailMe,
                icon: Icons.mail_outline_rounded,
                onTap: _sendEmail,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RevealOnScroll extends StatefulWidget {
  final String id;
  final Widget child;
  final double offsetY;

  const _RevealOnScroll({
    super.key,
    required this.id,
    required this.child,
    this.offsetY = 24,
  });

  @override
  State<_RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<_RevealOnScroll> {
  bool _visible = false;

  void _handleVisibility(VisibilityInfo info) {
    if (!_visible && info.visibleFraction > 0.01) {
      setState(() => _visible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: _visible ? 1 : 0),
      duration: 600.ms,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, widget.offsetY * (1 - value)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );

    // Wrap with a widget that has the key for scrolling purposes
    final keyedContent = widget.key != null
        ? Container(key: widget.key, child: content)
        : content;

    return VisibilityDetector(
      key: ValueKey('reveal-${widget.id}'),
      onVisibilityChanged: _handleVisibility,
      child: keyedContent,
    );
  }
}

class _SectionShell extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _SectionShell({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(color: Colors.white.withOpacity(.72), height: 1.45),
        ),
        const SizedBox(height: 22),
        child,
      ],
    );
  }
}

class _PillInfo extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PillInfo({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white.withOpacity(.8), size: 18),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _FrostedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _FrostedCard({
    required this.child,
    this.padding = const EdgeInsets.all(22),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6EF3A5),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
        elevation: 0,
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _GhostButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GhostButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withOpacity(.18)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Function() ontap;

  const _SocialIcon(this.icon, this.ontap);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(.06),
        border: Border.all(color: Colors.white.withOpacity(.1)),
      ),
      child: IconButton(
        onPressed: ontap,
        icon: Icon(icon, color: Colors.white),
        iconSize: 18,
      ),
    );
  }
}
