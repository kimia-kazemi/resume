import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppPalette {
  static const bg = Color(0xFF05070C);
  static const accent = Color(0xFF7DFFB3);
  static const accent2 = Color(0xFF6AB7FF);
  static const accent3 = Color(0xFFB8A6FF);
  static const text = Color(0xFFF5F7FB);
  static const muted = Color(0xFF9AA4B7);
}

class Hoverable extends StatefulWidget {
  final Widget Function(BuildContext context, bool hover) builder;

  const Hoverable({super.key, required this.builder});

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: widget.builder(context, _hover),
    );
  }
}

class AuroraBackground extends StatefulWidget {
  final ValueNotifier<Offset> pointer;

  const AuroraBackground({super.key, required this.pointer});

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Offset> _grain;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
    final random = Random(7);
    _grain = List.generate(
      220,
      (_) => Offset(random.nextDouble(), random.nextDouble()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, widget.pointer]),
      builder: (context, _) {
        return CustomPaint(
          painter: _AuroraPainter(
            t: _controller.value,
            pointer: widget.pointer.value,
            grain: _grain,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _AuroraPainter extends CustomPainter {
  final double t;
  final Offset pointer;
  final List<Offset> grain;

  _AuroraPainter({required this.t, required this.pointer, required this.grain});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = AppPalette.bg);

    final grid = Paint()
      ..color = Colors.white.withOpacity(.028)
      ..strokeWidth = 1;
    const step = 80.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    void orb(Offset center, double radius, Color color, double opacity) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [color.withOpacity(opacity), color.withOpacity(0)],
          ).createShader(rect),
      );
    }

    final wave = t * 2 * pi;
    orb(
      Offset(
        size.width * (.76 + .08 * sin(wave)),
        size.height * (.14 + .07 * cos(wave * .9)),
      ),
      340,
      AppPalette.accent2,
      .38,
    );
    orb(
      Offset(
        size.width * (.14 + .07 * cos(wave * .75)),
        size.height * (.46 + .08 * sin(wave * .85)),
      ),
      380,
      AppPalette.accent,
      .28,
    );
    orb(
      Offset(
        size.width * (.82 + .09 * sin(wave * .6)),
        size.height * (.78 + .06 * cos(wave * 1.1)),
      ),
      320,
      AppPalette.accent3,
      .32,
    );

    if (pointer != Offset.zero) {
      canvas.drawCircle(
        pointer,
        280,
        Paint()
          ..shader = RadialGradient(
            colors: [Colors.white.withOpacity(.08), Colors.transparent],
          ).createShader(Rect.fromCircle(center: pointer, radius: 280)),
      );
    }

    final speck = Paint()..color = Colors.white.withOpacity(.045);
    for (final p in grain) {
      canvas.drawCircle(
        Offset(p.dx * size.width, p.dy * size.height),
        1,
        speck,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter oldDelegate) {
    return oldDelegate.t != t || oldDelegate.pointer != pointer;
  }
}

class ShimmerText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ShimmerText({super.key, required this.text, required this.style});

  @override
  State<ShimmerText> createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.4 + 2.8 * _controller.value, 0),
              end: Alignment(-0.2 + 2.8 * _controller.value, 0),
              colors: const [
                AppPalette.accent,
                AppPalette.accent2,
                Color(0xFFF7FBFF),
                AppPalette.accent,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Text(widget.text, style: widget.style),
    );
  }
}

class PulseDot extends StatelessWidget {
  const PulseDot({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPalette.accent.withOpacity(.35),
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                begin: const Offset(.7, .7),
                end: const Offset(1.8, 1.8),
                duration: 1400.ms,
              )
              .fade(begin: .6, end: 0, duration: 1400.ms),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class TechMarquee extends StatefulWidget {
  const TechMarquee({super.key});

  @override
  State<TechMarquee> createState() => _TechMarqueeState();
}

class _TechMarqueeState extends State<TechMarquee>
    with SingleTickerProviderStateMixin {
  static const _items = [
    'FLUTTER',
    'DART',
    'BLOC',
    'GETX',
    'FIREBASE',
    'FIGMA',
    'REST API',
    'SOCKET',
    'CLEAN ARCH',
    'PWA',
    'iOS',
    'ANDROID',
  ];

  final ScrollController _scroll = ScrollController();
  late final Ticker _ticker;
  static const double _pixelsPerSecond = 40;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (!_scroll.hasClients || !_scroll.position.hasContentDimensions) return;
      final loopWidth =
          _scroll.position.maxScrollExtent / 2; // content is doubled
      if (loopWidth <= 0) return;
      final offset =
          (elapsed.inMicroseconds / 1e6 * _pixelsPerSecond) % loopWidth;
      _scroll.jumpTo(offset);
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Widget _row() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (final item in _items) ...[
        Text(
          item,
          style: TextStyle(
            color: Colors.white.withOpacity(.5),
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Icon(Icons.auto_awesome, size: 14, color: AppPalette.accent),
        ),
      ],
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        controller: _scroll,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(children: [_row(), _row()]), // doubled for seamless loop
      ),
    );
  }
}

class ScrollProgressBar extends StatelessWidget {
  final ScrollController controller;
  const ScrollProgressBar({super.key, required this.controller});

  double _progress() {
    if (!controller.hasClients) return 0;
    final pos = controller.position;
    if (!pos.hasContentDimensions) return 0; // not laid out yet
    final max = pos.maxScrollExtent;
    if (max <= 0) return 0;
    return (pos.pixels / max).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _progress(),
            child: Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppPalette.accent, AppPalette.accent2],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
