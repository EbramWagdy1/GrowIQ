import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double oldValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentValue = _animation.value;
        final color = getColor(currentValue);

        double percent;
        if (widget.minLimit != null && widget.maxLimit != null) {
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
            border: isDark ? Border.all(color: color.withValues(alpha: 0.1), width: 1) : null,
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
                    child: CircularProgressIndicator(
                      value: percent,
                      strokeWidth: 8,
                      backgroundColor: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white12 
                          : Colors.grey[200],
                      color: color,
                    ),
                  ),
                  Icon(widget.icon, size: 36, color: color),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.sensorName,
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
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
