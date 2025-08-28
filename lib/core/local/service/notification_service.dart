import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // TODO do additional setup in Swift when adding IOS support
    // https://pub.dev/packages/flutter_local_notifications#-ios-setup
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _isInitialized = true;
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification(String title, String body) async {
    return await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      _notificationDetails(),
    );
  }
}
