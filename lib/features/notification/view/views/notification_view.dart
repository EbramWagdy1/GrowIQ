import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import 'package:growiq/features/notification/view_model/notification_cubit.dart';
import 'package:growiq/features/notification/model/notification_model.dart';
import 'package:intl/intl.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/features/control/view_model/device_state.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final sliverAppBar = SliverAppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            floating: true,
            pinned: true,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.notifications,
              style: TextStyle(
                color: isDark ? AppColors.darkTextColorPrimary : const Color(0xFF111827),
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
            iconTheme: IconThemeData(
              color: isDark ? AppColors.darkTextColorPrimary : const Color(0xFF111827),
            ),
            actions: [
              IconButton(
                onPressed: () {
                   context.read<NotificationCubit>().clearAll();
                },
                icon: Icon(
                  Icons.mark_email_read_outlined, 
                  color: isDark ? AppColors.primaryColor : const Color(0xFF2E7D32),
                ),
                tooltip: 'Clear All',
              ),
              const SizedBox(width: 8),
            ],
          );

          if (state is NotificationLoading) {
            return CustomScrollView(
              slivers: [
                sliverAppBar,
                SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primaryColor),
                  ),
                ),
              ],
            );
          } else if (state is NotificationError) {
            return CustomScrollView(
              slivers: [
                sliverAppBar,
                SliverFillRemaining(
                  child: Center(child: Text(state.message)),
                ),
              ],
            );
          } else if (state is NotificationLoaded) {
            final notifications = state.notifications;
            
            return CustomScrollView(
              slivers: [
                sliverAppBar,
                if (notifications.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications_off_rounded,
                              size: 64,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            l10n.noNewNotifications,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.darkTextColorPrimary : const Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.noNewNotificationsDesc,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark ? AppColors.darkTextColorSecondary : const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return NotificationTile(notification: notifications[index]);
                        },
                        childCount: notifications.length,
                      ),
                    ),
                  ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    
    final Color iconColor = _getCategoryColor(notification);
    final IconData categoryIcon = _getCategoryIcon(notification);
    
    // Fallback translation mappings
    String typeLocalized = '';
    switch (notification.type) {
      case 'Critical': typeLocalized = l10n.notificationCritical; break;
      case 'Environmental': typeLocalized = l10n.notificationEnvironmental; break;
      case 'Automation': typeLocalized = l10n.notificationAutomation; break;
      case 'AI': typeLocalized = l10n.notificationAI; break;
      default: typeLocalized = l10n.notificationInformational; break;
    }

    // Determine the brilliant smart title & subtitle natively
    final String awesomeTitle = _getLocalizedTitle(notification.id, notification.body, l10n);
    
    // Subtitle displays the farm name and the category of the alert (if not just "Notification")
    String subText = typeLocalized == l10n.notificationInformational ? '' : typeLocalized;
    String awesomeSubtitle = '';
    if (notification.deviceName != null && notification.deviceName!.isNotEmpty) {
      awesomeSubtitle = notification.deviceName!;
      if (subText.isNotEmpty) awesomeSubtitle += ' • $subText';
    } else {
      awesomeSubtitle = subText;
    }

    final bool isUnread = !notification.isRead;
    
    final String formattedTime = DateFormat('MMM d, h:mm a').format(notification.timestamp);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDark 
              ? (isUnread ? Color.alphaBlend(iconColor.withValues(alpha: 0.08), AppColors.darkCardColor) : AppColors.darkCardColor)
              : (isUnread ? iconColor.withValues(alpha: 0.03) : Colors.white),
          borderRadius: BorderRadius.circular(24),
          border: isUnread 
              ? Border.all(color: iconColor.withValues(alpha: 0.3), width: 1.5)
              : Border.all(color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.04), width: 1),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: isUnread ? iconColor.withValues(alpha: 0.1) : const Color(0xFF000000).withValues(alpha: 0.03),
                blurRadius: isUnread ? 20 : 15,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (isUnread) {
                  context.read<NotificationCubit>().markAsRead(notification.id);
                }
                if (notification.deviceId != null && notification.deviceId!.isNotEmpty) {
                  final deviceState = context.read<DeviceCubit>().state;
                  
                  if (deviceState is DeviceUpdated) {
                    try {
                      final liveDevice = deviceState.devices.firstWhere(
                        (d) => d.id == notification.deviceId,
                      );
                      
                      context.push(
                        '/device-detail',
                        extra: {
                          'deviceId': liveDevice.id,
                          'deviceName': notification.deviceName ?? liveDevice.name,
                          'isOnline': liveDevice.isOnline,
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.noDevicesFound),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.loading)),
                    );
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Premium Glowing Icon Widget
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: isDark ? iconColor.withValues(alpha: 0.2) : iconColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: iconColor.withValues(alpha: isDark ? 0.3 : 0.25),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color: iconColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(categoryIcon, color: iconColor, size: 28),
                      ),
                    ),
                    const SizedBox(width: 18),
                    
                    // Text Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  awesomeTitle,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: isDark ? AppColors.darkTextColorPrimary : const Color(0xFF111827),
                                    fontWeight: isUnread ? FontWeight.w800 : FontWeight.w600,
                                    fontSize: 17,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                              if (isUnread)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                    color: iconColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (awesomeSubtitle.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              awesomeSubtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDark ? AppColors.darkTextColorSecondary : const Color(0xFF6B7280),
                                fontSize: 14,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: isDark ? Colors.white38 : Colors.black38,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                formattedTime,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: isDark ? Colors.white54 : const Color(0xFF9CA3AF),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  letterSpacing: 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: isDark ? Colors.white24 : Colors.black26,
                      size: 24,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getLocalizedTitle(String id, String body, AppLocalizations l10n) {
    final i = id.toLowerCase();
    final b = body.toLowerCase();
    
    if (i.contains('moisture') || b.contains('moisture')) return l10n.lowSoilMoisture;
    if (i.contains('temp') && b.contains('high')) return l10n.highTemperature;
    if (i.contains('temp') && b.contains('low')) return l10n.lowTemperature;
    if (i.contains('temp')) return l10n.highTemperature; // Generational fallback for temp
    if (i.contains('humid') || b.contains('humid')) return l10n.highHumidity;
    if (i.contains('water') || b.contains('tank')) return l10n.waterTankEmpty;
    if (i.contains('power')) return l10n.powerFailure;
    if (i.contains('sensor')) return l10n.sensorFailure;
    if (i.contains('irrigation') && b.contains('start')) return l10n.autoIrrigationStarted;
    if (i.contains('irrigation') && b.contains('stop')) return l10n.autoIrrigationStopped;
    if (i.contains('fan')) return l10n.fanActivated;
    if (i.contains('light')) return l10n.growLightActivated;
    if (i.contains('disease')) return l10n.diseaseDetected;
    if (i.contains('action')) return l10n.aiActionTaken;
    if (i.contains('trend')) return l10n.aiPredictionAlert;
    if (i.contains('weather')) return l10n.weatherAlert;
    if (i.contains('tip')) return l10n.plantCareTip;
    if (i.contains('offline') || b.contains('offline')) return l10n.deviceOffline;
    
    // Check if the current cached body or title is just "Notification" or generic
    if (body.isEmpty || b == 'notification' || b == 'إشعار') {
      return l10n.notificationInformational;
    }
    
    return _formatBody(body);
  }

  String _formatBody(String body) {
    if (body.isEmpty) return 'No details provided.';
    if (body.contains('_')) {
      return body.split('_').map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    }
    return body;
  }

  IconData _getCategoryIcon(NotificationModel notification) {
    final String type = notification.type.toLowerCase();
    final String body = notification.body.toLowerCase();
    final String id = notification.id.toLowerCase();

    if (body.contains('offline') || id.contains('offline')) {
      return Icons.wifi_off_rounded;
    }
    if (body.contains('temperature') || body.contains('temp') || id.contains('temp')) {
      return Icons.thermostat_rounded;
    }
    if (body.contains('moisture') || body.contains('water') || id.contains('moisture')) {
      return Icons.water_drop_rounded;
    }
    if (body.contains('humidity') || id.contains('humid')) {
      return Icons.cloud_outlined;
    }
    if (body.contains('light') || id.contains('light')) {
      return Icons.wb_sunny_rounded;
    }
    if (type == 'automation' || body.contains('fan') || body.contains('pump') || body.contains('auto')) {
      return Icons.settings_remote_rounded;
    }
    if (type == 'critical') {
      return Icons.warning_rounded;
    }
    if (type == 'ai' || body.contains('ai') || body.contains('disease')) {
      return Icons.auto_awesome_rounded;
    }

    return Icons.info_outline_rounded;
  }

  Color _getCategoryColor(NotificationModel notification) {
    final String type = notification.type.toLowerCase();
    final String body = notification.body.toLowerCase();
    final String id = notification.id.toLowerCase();

    if (type == 'critical' || body.contains('offline') || id.contains('offline')) {
      return const Color(0xFFEF4444); // Red
    }
    if (body.contains('temperature') || body.contains('temp') || id.contains('temp')) {
      return const Color(0xFFF97316); // Orange
    }
    if (body.contains('moisture') || body.contains('water') || id.contains('moisture')) {
      return const Color(0xFF3B82F6); // Blue
    }
    if (body.contains('humidity') || id.contains('humid')) {
      return const Color(0xFF0EA5E9); // Light Blue / Sky
    }
    if (body.contains('light') || id.contains('light')) {
      return const Color(0xFFEAB308); // Yellow
    }
    if (type == 'automation' || body.contains('fan') || body.contains('pump') || body.contains('auto')) {
      return const Color(0xFF8B5CF6); // Purple
    }
    if (type == 'environmental') {
      return const Color(0xFF10B981); // Emerald
    }
    if (type == 'ai' || body.contains('ai') || body.contains('disease')) {
      return const Color(0xFFEC4899); // Pink
    }

    return AppColors.primaryColor; // Default Green
  }
}