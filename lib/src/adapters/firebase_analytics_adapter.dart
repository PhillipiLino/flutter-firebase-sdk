part of solfacil_tools_sdk;

class FirebaseAnalyticsAdapter {
  final FirebaseAnalytics analytics;

  FirebaseAnalyticsAdapter(this.analytics);

  Future logEvent({
    required String eventName,
    required Map<String, dynamic> eventInfos,
  }) async {
    return await analytics.logEvent(name: eventName, parameters: eventInfos);
  }

  Future setDefaultParameters(Map<String, Object> params) async {
    return await analytics.setDefaultEventParameters(params);
  }

  Future setUserProperty({required String name, required String? value}) async {
    return await analytics.setUserProperty(name: name, value: value);
  }

  Future setUserId(String? userId) async {
    return await analytics.setUserId(id: userId);
  }

  Future logLogin() async {
    return await analytics.logLogin();
  }

  Future setCurrentPage(String pageName) async {
    return await analytics.setCurrentScreen(
      screenName: pageName,
      screenClassOverride: pageName,
    );
  }
}
