part of solfacil_tools_sdk;

class FirebaseMessagingAdapter {
  final FirebaseMessaging messaging;

  FirebaseMessagingAdapter(this.messaging);

  subscribeToTopic(String topic) async {
    return await messaging.subscribeToTopic(topic);
  }

  subscribeToTopics(List<String> topics) async {
    for (var topic in topics) {
      await subscribeToTopic(topic);
    }
  }

  unsubscribeFromTopic(String topic) async {
    return await messaging.unsubscribeFromTopic(topic);
  }

  unsubscribeFromTopics(List<String> topics) async {
    for (var topic in topics) {
      await unsubscribeFromTopic(topic);
    }
  }

  Future<bool> requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  Future<String> getMessagingToken() async {
    final fcmToken = await messaging.getToken();
    return fcmToken.toString();
  }
}
