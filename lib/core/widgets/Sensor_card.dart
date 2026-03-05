import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedSensorCard extends StatefulWidget {
  final String sensorName;
  final double sensorValue;
  final String unit;
  final IconData icon;

  const AnimatedSensorCard({
    super.key,
    required this.sensorName,
    required this.sensorValue,
    required this.unit,
    required this.icon,
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
    _animation =
        Tween<double>(begin: 0, end: widget.sensorValue).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        )..addListener(() {
          setState(() {});
        });
    _controller.forward();
    oldValue = widget.sensorValue;
  }

  @override
  void didUpdateWidget(covariant AnimatedSensorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animation = Tween<double>(
      begin: oldValue,
      end: widget.sensorValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.reset();
    _controller.forward();
    oldValue = widget.sensorValue;
  }

  Color getColor() {
    final name = widget.sensorName.toLowerCase();

    // 🌡️ Temperature sensors (air or soil)
    if (name.contains('temperature')) {
      if (_animation.value > 35) return Colors.red;
      if (_animation.value >= 20) return Colors.orange;
      return Colors.green;
    }

    // 💧 Humidity sensors (air or soil moisture)
    if (name.contains('humidity') || name.contains('soil moisture')) {
      if (_animation.value < 30) return Colors.orange;
      if (_animation.value <= 70) return Colors.green;
      return Colors.blue;
    }

    // 🌫️ Air Quality / MQ-135
    if (name.contains('quality') ||
        name.contains('mq-135') ||
        name.contains('co2')) {
      if (_animation.value > 300) return Colors.red;
      if (_animation.value > 150) return Colors.orange;
      return Colors.green;
    }

    // 💡 Light level / LDR
    if (name.contains('light') || name.contains('ldr')) {
      return Colors.amber;
    }

    return Colors.teal;
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();
    final percent = (_animation.value / 100).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // ignore: deprecated_member_use
          colors: [color.withOpacity(0.3), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
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
                  backgroundColor: Colors.grey[200],
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
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_animation.value.toStringAsFixed(1)} ${widget.unit}',
            style: GoogleFonts.robotoMono(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
