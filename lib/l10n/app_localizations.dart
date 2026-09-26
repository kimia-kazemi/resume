import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // NavBar
      'work': 'Work',
      'about': 'About',
      'contact': 'Contact',
      'downloadResume': 'Download Resume',

      // Hero Section
      'availableForFreelance': 'Available for freelance projects',
      'hiIAm': 'Hi, I am ',
      'a': 'A ',
      'flutterEngineer': 'Flutter Engineer',
      'craftingBeautiful':
          'crafting beautiful, high-performance products people love',
      'heroDescription':
          'I build high-performance, scalable Flutter applications for web and mobile. My work focuses on clean architecture, responsive UI, and delivering reliable, production-ready products from concept to launch.',
      'viewWork': 'View Work',
      'letsTalk': 'Let\'s talk',
      'projectsShipped': 'projects shipped',

      // Stats
      'yearsExperience': 'Years experience',
      'launchedProjects': 'Launched projects',

      // About Section
      'aboutTitle': 'About',
      'aboutDescription':
          'I am a Flutter Developer with 3+ years of professional experience building high-quality, scalable mobile and web applications. I specialize in developing clean, maintainable, and performance-driven Flutter apps from scratch to production.\n\nI have strong hands-on experience with Dart, state management (GetX, BLoC), RESTful APIs, responsive UI, and cross-platform development (Android, Web, PWA). I\'m comfortable working closely with designers using Figma, implementing complex UI/UX, and following best practices such as Git Flow and clean architecture.\n\nI have led and fully implemented large-scale Flutter projects, including social platforms and admin panels, taking full ownership from design to deployment. I\'m highly motivated, detail-oriented, and always eager to learn new technologies and improve code quality.\n\nI\'m currently looking for opportunities where I can create real impact, grow as a developer, and contribute to innovative products.',
      'figmaUIUX': 'Figma, UI/UX',
      'flutter': 'Flutter',
      'goToMarket': 'Go-to-market experiments',
      'mentorshipLeadership': 'Mentorship & leadership',

      // Experience Section
      'experienceTitle': 'Experience',
      'experienceDescription':
          'Selected roles and highlights from the last decade.',

      // Projects Section
      'recentWork': 'Recent Work',
      'projectsDescription':
          'A snapshot of projects that blend usability, craft, and animation.',
      'viewAppOnMarket': 'View App On Market',
      'viewWebsite': 'View Website',

      // Contact Section
      'letsBuildSomething': 'Let\'s build something extraordinary.',
      'currentlyAccepting':
          'I\'m currently accepting new freelance projects and consulting engagements.',
      'bookACall': 'Book a call',
      'emailMe': 'Email me',
    },
    'fa': {
      // NavBar
      'work': 'کارها',
      'about': 'درباره',
      'contact': 'تماس',
      'downloadResume': 'دانلود رزومه',

      // Hero Section
      'availableForFreelance': 'در دسترس برای پروژه‌های فریلنس',
      'hiIAm': 'سلام، من ',
      'a': 'یک ',
      'flutterEngineer': 'برنامه نویس فلاتر',
      'craftingBeautiful':
          'که محصولات زیبا و با عملکرد بالا می‌سازم که مردم دوست دارند',
      'heroDescription':
          'من برنامه‌های فلاتر با عملکرد بالا و مقیاس‌پذیر برای وب و موبایل می‌سازم. کار من بر معماری تمیز، رابط کاربری واکنش‌گرا و ارائه محصولات قابل اعتماد و آماده تولید از مفهوم تا راه‌اندازی متمرکز است.',
      'viewWork': 'مشاهده کارها',
      'letsTalk': 'بیایید صحبت کنیم',
      'projectsShipped': 'پروژه تحویل داده شده',

      // Stats
      'yearsExperience': 'سال تجربه',
      'launchedProjects': 'پروژه راه‌اندازی شده',

      // About Section
      'aboutTitle': 'درباره',
      'aboutDescription':
          'من یک توسعه‌دهنده فلاتر با بیش از 3 سال تجربه حرفه‌ای در ساخت برنامه‌های موبایل و وب با کیفیت بالا و مقیاس‌پذیر هستم. من در توسعه برنامه‌های فلاتر تمیز، قابل نگهداری و با عملکرد بالا از ابتدا تا تولید تخصص دارم.\n\nمن تجربه عملی قوی با دارت، مدیریت وضعیت (GetX، BLoC)، APIهای RESTful، رابط کاربری واکنش‌گرا و توسعه چند پلتفرمی (اندروید، وب، PWA) دارم. من در کار نزدیک با طراحان با استفاده از Figma، پیاده‌سازی UI/UX پیچیده و پیروی از بهترین روش‌ها مانند Git Flow و معماری تمیز راحت هستم.\n\nمن پروژه‌های بزرگ فلاتر، از جمله پلتفرم‌های اجتماعی و پنل‌های مدیریتی را رهبری و به طور کامل پیاده‌سازی کرده‌ام و مالکیت کامل از طراحی تا استقرار را بر عهده گرفته‌ام. من بسیار با انگیزه، جزئی‌نگر هستم و همیشه مشتاق یادگیری فناوری‌های جدید و بهبود کیفیت کد هستم.\n\nمن در حال حاضر به دنبال فرصت‌هایی هستم که بتوانم تأثیر واقعی ایجاد کنم، به عنوان یک توسعه‌دهنده رشد کنم و به محصولات نوآورانه کمک کنم.',
      'figmaUIUX': 'Figma، UI/UX',
      'flutter': 'Flutter',
      'goToMarket': 'آزمایش‌های ورود به بازار',
      'mentorshipLeadership': 'راهنمایی و رهبری',

      // Experience Section
      'experienceTitle': 'تجربه',
      'experienceDescription': 'نقش‌های انتخاب شده و نکات برجسته از دهه گذشته.',

      // Projects Section
      'recentWork': 'کارهای اخیر',
      'projectsDescription':
          'نمایی از پروژه‌هایی که قابلیت استفاده، هنر و انیمیشن را ترکیب می‌کنند.',
      'viewAppOnMarket': 'مشاهده برنامه در بازار',
      'viewWebsite': 'مشاهده وب‌سایت',

      // Contact Section
      'letsBuildSomething': 'بیایید چیزی فوق‌العاده بسازیم.',
      'currentlyAccepting':
          'من در حال حاضر پروژه‌های فریلنس جدید و مشارکت‌های مشاوره‌ای را می‌پذیرم.',
      'bookACall': 'رزرو تماس',
      'emailMe': 'ایمیل بزنید',
    },
    'ku': {
      // NavBar
      'work': 'کار',
      'about': 'دەربارە',
      'contact': 'پەیوەندی',
      'downloadResume': 'داگرتنی ریزومه',

      // Hero Section
      'availableForFreelance': 'بەردەستە بۆ پرۆژەکانی فریلانس',
      'hiIAm': 'سڵاو، من ',
      'a': 'یەک ',
      'flutterEngineer': 'ئەندازیاری فلاتەر',
      'craftingBeautiful':
          'کە بەرهەمە جوان و بەکارهێنانی بەرز دروست دەکەم کە خەڵک خۆشیان دەوێت',
      'heroDescription':
          'من ئەپلیکەیشنی فلاتەری بەکارهێنانی بەرز و گەورە دروست دەکەم بۆ وێب و مۆبایل. کارەکەم لەسەر تەلارسازی پاک، UI وەڵامدەرەوە، و دەستپێکردنی بەرهەمی دڵنیا و ئامادە بۆ بەرهەمهێنان لە چەمکەوە تا دەستپێکردن.',
      'viewWork': 'بینینی کار',
      'letsTalk': 'با قسە بکەین',
      'projectsShipped': 'پرۆژەی دەستپێکراو',

      // Stats
      'yearsExperience': 'ساڵ ئەزموون',
      'launchedProjects': 'پرۆژەی دەستپێکراو',

      // About Section
      'aboutTitle': 'دەربارە',
      'aboutDescription':
          'من گەشەپێدەری فلاتەرم بە زیاتر لە 3 ساڵ ئەزموونی پیشەیی لە دروستکردنی ئەپلیکەیشنی مۆبایل و وێبی بە کوالیتی بەرز و گەورە. من تایبەتمەندی لە گەشەپێدانی ئەپلیکەیشنی فلاتەری پاک، پارێزراو و بەکارهێنانی بەرز لە سەرەتاوە تا بەرهەمهێنان.\n\nمن ئەزموونی بەهێزی دەست لەگەڵ دارت، بەڕێوەبردنی دۆخ (GetX، BLoC)، RESTful APIs، UI وەڵامدەرەوە، و گەشەپێدانی فرە پلاتفۆرم (ئەندرۆید، وێب، PWA) هەیە. من لە کارکردنی نزیک لەگەڵ دیزاینەرەکان بە بەکارهێنانی Figma، جێبەجێکردنی UI/UX ئاڵۆز، و شوێنکەوتنی باشترین پێکەوەبوونەکان وەک Git Flow و تەلارسازی پاک ئارامم.\n\nمن پرۆژە گەورەکانی فلاتەر، لەوانەیە پلاتفۆرمی کۆمەڵایەتی و پانێڵی بەڕێوەبردن، رهبری کردووە و بە تەواوی جێبەجێ کردووە و خاوەنداریەتی تەواو لە دیزاینەوە تا دامەزراندن وەرگرتووە. من زۆر هاندەر، وردبینم و هەمیشە حەز لە فێربوونی تەکنەلۆژیای نوێ و باشترکردنی کوالیتی کۆد هەیە.\n\nمن لە ئێستادا بەدوای دەرفەتێکدام کە بتوانم کاریگەری ڕاستەقینە دروست بکەم، وەک گەشەپێدەر گەشە بکەم و بەرهەمی داهێنەرانە ببەخشێم.',
      'figmaUIUX': 'Figma، UI/UX',
      'flutter': 'Flutter',
      'goToMarket': 'تاقیکردنەوەی دەستپێکردنی بازاڕ',
      'mentorshipLeadership': 'ڕێنمایی و سەرکردایەتی',

      // Experience Section
      'experienceTitle': 'ئەزموون',
      'experienceDescription':
          'ڕۆڵە هەڵبژێردراوەکان و خاڵە گرنگەکان لە دەیەی ڕابردوو.',

      // Projects Section
      'recentWork': 'کاری دواتر',
      'projectsDescription':
          'وێنەیەک لە پرۆژەکان کە بەکارهێنان، پیشەسازی و ئەنیمەیشن تێکەڵ دەکەن.',
      'viewAppOnMarket': 'بینینی ئەپ لە بازاڕ',
      'viewWebsite': 'بینینی وێبسایت',

      // Contact Section
      'letsBuildSomething': 'با شتێکی نایاب دروست بکەین.',
      'currentlyAccepting':
          'من لە ئێستادا پرۆژەکانی فریلانس نوێ و بەشداریکردنی ڕاوێژکاری قبوڵ دەکەم.',
      'bookACall': 'رێکخستنی پەیوەندی',
      'emailMe': 'ئیمەیڵم بۆ بنێرە',
    },
    'tr': {
      // NavBar
      'work': 'İşler',
      'about': 'Hakkında',
      'contact': 'İletişim',
      'downloadResume': 'Özgeçmiş İndir',

      // Hero Section
      'availableForFreelance': 'Serbest projeler için müsait',
      'hiIAm': 'Merhaba, ben ',
      'a': 'Bir ',
      'flutterEngineer': 'Flutter Mühendisi',
      'craftingBeautiful':
          'insanların sevdiği güzel, yüksek performanslı ürünler üreten',
      'heroDescription':
          'Web ve mobil için yüksek performanslı, ölçeklenebilir Flutter uygulamaları geliştiriyorum. Çalışmalarım temiz mimari, duyarlı UI ve konseptten lansmana kadar güvenilir, üretime hazır ürünler sunmaya odaklanıyor.',
      'viewWork': 'İşleri Görüntüle',
      'letsTalk': 'Konuşalım',
      'projectsShipped': 'teslim edilen proje',

      // Stats
      'yearsExperience': 'Yıl deneyim',
      'launchedProjects': 'Başlatılan proje',

      // About Section
      'aboutTitle': 'Hakkında',
      'aboutDescription':
          '3+ yıl profesyonel deneyime sahip, yüksek kaliteli, ölçeklenebilir mobil ve web uygulamaları geliştiren bir Flutter Geliştiricisiyim. Sıfırdan üretime kadar temiz, bakımı kolay ve performans odaklı Flutter uygulamaları geliştirmede uzmanım.\n\nDart, durum yönetimi (GetX, BLoC), RESTful API\'ler, duyarlı UI ve çapraz platform geliştirme (Android, Web, PWA) konularında güçlü pratik deneyime sahibim. Figma kullanarak tasarımcılarla yakın çalışmaktan, karmaşık UI/UX uygulamaktan ve Git Flow ve temiz mimari gibi en iyi uygulamaları takip etmekten rahatım.\n\nSosyal platformlar ve yönetim panelleri dahil olmak üzere büyük ölçekli Flutter projelerini yönettim ve tamamen uyguladım, tasarımdan dağıtıma kadar tam sahiplik aldım. Oldukça motive, detay odaklıyım ve her zaman yeni teknolojiler öğrenmeye ve kod kalitesini iyileştirmeye hevesliyim.\n\nŞu anda gerçek bir etki yaratabileceğim, bir geliştirici olarak büyüyebileceğim ve yenilikçi ürünlere katkıda bulunabileceğim fırsatlar arıyorum.',
      'figmaUIUX': 'Figma, UI/UX',
      'flutter': 'Flutter',
      'goToMarket': 'Pazara giriş deneyleri',
      'mentorshipLeadership': 'Mentörlük ve liderlik',

      // Experience Section
      'experienceTitle': 'Deneyim',
      'experienceDescription': 'Son on yıldan seçilmiş roller ve öne çıkanlar.',

      // Projects Section
      'recentWork': 'Son İşler',
      'projectsDescription':
          'Kullanılabilirlik, zanaat ve animasyonu harmanlayan projelerin bir özeti.',
      'viewAppOnMarket': 'Uygulamayı Pazarda Görüntüle',
      'viewWebsite': 'Web Sitesini Görüntüle',

      // Contact Section
      'letsBuildSomething': 'Olağanüstü bir şey inşa edelim.',
      'currentlyAccepting':
          'Şu anda yeni serbest projeler ve danışmanlık işbirlikleri kabul ediyorum.',
      'bookACall': 'Görüşme ayarla',
      'emailMe': 'Bana e-posta gönder',
    },
    'es': {
      // NavBar
      'work': 'Trabajo',
      'about': 'Acerca de',
      'contact': 'Contacto',
      'downloadResume': 'Descargar Currículum',

      // Hero Section
      'availableForFreelance': 'Disponible para proyectos freelance',
      'hiIAm': 'Hola, soy ',
      'a': 'Un ',
      'flutterEngineer': 'Ingeniero Flutter',
      'craftingBeautiful':
          'creando productos hermosos y de alto rendimiento que la gente ama',
      'heroDescription':
          'Construyo aplicaciones Flutter de alto rendimiento y escalables para web y móvil. Mi trabajo se centra en arquitectura limpia, UI responsiva y entregar productos confiables y listos para producción desde el concepto hasta el lanzamiento.',
      'viewWork': 'Ver Trabajo',
      'letsTalk': 'Hablemos',
      'projectsShipped': 'proyectos entregados',

      // Stats
      'yearsExperience': 'Años de experiencia',
      'launchedProjects': 'Proyectos lanzados',

      // About Section
      'aboutTitle': 'Acerca de',
      'aboutDescription':
          'Soy un Desarrollador Flutter con más de 3 años de experiencia profesional construyendo aplicaciones móviles y web de alta calidad y escalables. Me especializo en desarrollar aplicaciones Flutter limpias, mantenibles y orientadas al rendimiento desde cero hasta producción.\n\nTengo una sólida experiencia práctica con Dart, gestión de estado (GetX, BLoC), APIs RESTful, UI responsiva y desarrollo multiplataforma (Android, Web, PWA). Me siento cómodo trabajando estrechamente con diseñadores usando Figma, implementando UI/UX complejas y siguiendo mejores prácticas como Git Flow y arquitectura limpia.\n\nHe liderado e implementado completamente proyectos Flutter a gran escala, incluyendo plataformas sociales y paneles de administración, tomando propiedad completa desde el diseño hasta el despliegue. Estoy altamente motivado, orientado a los detalles y siempre ansioso por aprender nuevas tecnologías y mejorar la calidad del código.\n\nActualmente busco oportunidades donde pueda crear un impacto real, crecer como desarrollador y contribuir a productos innovadores.',
      'figmaUIUX': 'Figma, UI/UX',
      'flutter': 'Flutter',
      'goToMarket': 'Experimentos de salida al mercado',
      'mentorshipLeadership': 'Mentoría y liderazgo',

      // Experience Section
      'experienceTitle': 'Experiencia',
      'experienceDescription':
          'Roles seleccionados y destacados de la última década.',

      // Projects Section
      'recentWork': 'Trabajo Reciente',
      'projectsDescription':
          'Una instantánea de proyectos que combinan usabilidad, artesanía y animación.',
      'viewAppOnMarket': 'Ver App en el Mercado',
      'viewWebsite': 'Ver Sitio Web',

      // Contact Section
      'letsBuildSomething': 'Construyamos algo extraordinario.',
      'currentlyAccepting':
          'Actualmente acepto nuevos proyectos freelance y compromisos de consultoría.',
      'bookACall': 'Reservar una llamada',
      'emailMe': 'Enviar correo',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  // Convenience getters
  String get work => translate('work');
  String get about => translate('about');
  String get contact => translate('contact');
  String get downloadResume => translate('downloadResume');
  String get availableForFreelance => translate('availableForFreelance');
  String get hiIAm => translate('hiIAm');
  String get a => translate('a');
  String get flutterEngineer => translate('flutterEngineer');
  String get craftingBeautiful => translate('craftingBeautiful');
  String get heroDescription => translate('heroDescription');
  String get viewWork => translate('viewWork');
  String get letsTalk => translate('letsTalk');
  String get projectsShipped => translate('projectsShipped');
  String get yearsExperience => translate('yearsExperience');
  String get launchedProjects => translate('launchedProjects');
  String get aboutTitle => translate('aboutTitle');
  String get aboutDescription => translate('aboutDescription');
  String get figmaUIUX => translate('figmaUIUX');
  String get flutter => translate('flutter');
  String get goToMarket => translate('goToMarket');
  String get mentorshipLeadership => translate('mentorshipLeadership');
  String get experienceTitle => translate('experienceTitle');
  String get experienceDescription => translate('experienceDescription');
  String get recentWork => translate('recentWork');
  String get projectsDescription => translate('projectsDescription');
  String get viewAppOnMarket => translate('viewAppOnMarket');
  String get viewWebsite => translate('viewWebsite');
  String get letsBuildSomething => translate('letsBuildSomething');
  String get currentlyAccepting => translate('currentlyAccepting');
  String get bookACall => translate('bookACall');
  String get emailMe => translate('emailMe');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fa', 'ku', 'tr', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

