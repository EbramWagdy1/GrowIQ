import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class AnimatedSensorCard extends StatefulWidget {
  final String sensorName;
  final double sensorValue;
  final String unit;
  final IconData icon;
  final double? minLimit;
  final double? maxLimit;

  const AnimatedSensorCard({
    super.key,
    required this.sensorName,
    required this.sensorValue,
    required this.unit,
    required this.icon,
    this.minLimit,
    this.maxLimit,
  });

  @override
  State<AnimatedSensorCard> createState() => _AnimatedSensorCardState();
}

class _AnimatedSensorCardState extends State<AnimatedSensorCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _waveController;
  late Animation<double> _animation;
  double oldValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: widget.sensorValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    oldValue = widget.sensorValue;
  }

  @override
  void didUpdateWidget(covariant AnimatedSensorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sensorValue != widget.sensorValue) {
      _animation = Tween<double>(
        begin: oldValue,
        end: widget.sensorValue,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.reset();
      _controller.forward();
      oldValue = widget.sensorValue;
    }
  }

  Color getColor(double currentValue) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (widget.minLimit != null && widget.maxLimit != null) {
      final min = widget.minLimit!;
      final max = widget.maxLimit!;

      if (currentValue >= min && currentValue <= max) {
        return isDark ? Colors.greenAccent : Colors.green;
      } else if (currentValue < min) {
        return isDark ? Colors.blueAccent : Colors.blue;
      } else {
        return isDark ? Colors.redAccent : Colors.red;
      }
    }

    return isDark ? Colors.tealAccent : Colors.teal;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWaterLevel =
        widget.sensorName.toLowerCase().contains('water level') ||
        widget.sensorName.toLowerCase().contains('liquid level');

    String getLocalizedSensorName(BuildContext context, String sensorName) {
      final lowerName = sensorName.toLowerCase();
      if (lowerName == 'air temperature' || lowerName == 'temperature') return AppLocalizations.of(context)!.airTemperature;
      if (lowerName == 'humidity') return AppLocalizations.of(context)!.humidity;
      if (lowerName == 'soil moisture') return AppLocalizations.of(context)!.soilMoisture;
      if (lowerName == 'soil temperature') return AppLocalizations.of(context)!.soilTemperature;
      if (lowerName == 'light level') return AppLocalizations.of(context)!.lightLevel;
      if (lowerName == 'air quality') return AppLocalizations.of(context)!.airQuality;
      if (lowerName == 'water level') return AppLocalizations.of(context)!.waterLevel;
      return sensorName;
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_animation, _waveController]),
      builder: (context, child) {
        final currentValue = _animation.value;
        final color = isWaterLevel ? Colors.blueAccent : getColor(currentValue);

        double percent;
        final isLight = widget.sensorName.toLowerCase().contains('light') ||
            widget.sensorName.toLowerCase().contains('ldr');

        if (isLight) {
          percent = (currentValue / 100).clamp(0.0, 1.0);
        } else if (widget.minLimit != null && widget.maxLimit != null) {
          final range = widget.maxLimit! - widget.minLimit!;
          if (range == 0) {
            percent = 0.5;
          } else {
            percent = (currentValue / (widget.maxLimit! * 1.5)).clamp(0.0, 1.0);
          }
        } else {
          percent = (currentValue / 100).clamp(0.0, 1.0);
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: isDark ? 0.15 : 0.3),
                isDark
                    ? Theme.of(context).colorScheme.surfaceContainerHighest
                    : Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : color.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: isDark
                ? Border.all(color: color.withValues(alpha: 0.1), width: 1)
                : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: isWaterLevel
                        ? CustomPaint(
                            painter: LiquidWavePainter(
                              percent: percent,
                              color: color,
                              waveValue: _waveController.value,
                              isDark: isDark,
                            ),
                          )
                        : CircularProgressIndicator(
                            value: percent,
                            strokeWidth: 8,
                            backgroundColor: isDark
                                ? Colors.white12
                                : Colors.grey[200],
                            color: color,
                          ),
                  ),
                  Icon(
                    widget.icon,
                    size: 36,
                    color: isWaterLevel ? Colors.white : color,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                getLocalizedSensorName(context, widget.sensorName),
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    Text(
                      '${currentValue.toStringAsFixed(1)} ${widget.unit}',
                      style: GoogleFonts.robotoMono(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _waveController.dispose();
    super.dispose();
  }
}

class LiquidWavePainter extends CustomPainter {
  final double percent;
  final Color color;
  final double waveValue;
  final bool isDark;

  LiquidWavePainter({
    required this.percent,
    required this.color,
    required this.waveValue,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Colors.white10 : Colors.grey[200]!
      ..style = PaintingStyle.fill;

    // Draw background circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    // Clip to circle
    final path = Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.clipPath(path);

    // Draw "water"
    final waterPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.8), color],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final double waterHeight = size.height * (1 - percent);
    final wavePath = Path();
    wavePath.moveTo(0, waterHeight);

    for (double i = 0; i <= size.width; i++) {
      wavePath.lineTo(
        i,
        waterHeight +
            4 *
                (percent > 0 && percent < 1 ? (1) : 0) *
                (percent > 0.05 && percent < 0.95
                    ? (size.height * 0.05 * (1 - (percent - 0.5).abs() * 2))
                    : 2) *
                (0.5 * (1 + (percent > 0.1 && percent < 0.9 ? 1 : 0))) *
                (1.0) *
                (0.5 + 0.5 * (1.0)) *
                (percent > 0 && percent < 1 ? (1) : 0) *
                (percent > 0.1 && percent < 0.9 ? 1 : 0) *
                (4 * (percent > 0.1 && percent < 0.9 ? 1 : 0)) *
                (1.0) *
                (1.0) *
                (math.sin(
                  (i / size.width * 2 * math.pi) + (waveValue * 2 * math.pi),
                )),
      );
    }

    // Simpler wave logic
    final wavePath2 = Path();
    wavePath2.moveTo(0, waterHeight);
    for (double i = 0; i <= size.width; i++) {
      wavePath2.lineTo(
        i,
        waterHeight +
            (5 *
                (percent > 0.01 && percent < 0.99 ? 1 : 0) *
                math.sin(
                  (i / size.width * 2 * math.pi) + (waveValue * 2 * math.pi),
                )),
      );
    }

    wavePath2.lineTo(size.width, size.height);
    wavePath2.lineTo(0, size.height);
    wavePath2.close();

    canvas.drawPath(wavePath2, waterPaint);
  }

  @override
  bool shouldRepaint(covariant LiquidWavePainter oldDelegate) => true;
}
