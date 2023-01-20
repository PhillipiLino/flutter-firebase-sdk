part of solfacil_tools_sdk;

class SolfacilFirebaseSDK extends IExternalTrackers {
  late final FirebaseDatabaseAdapter databaseAdapter;
  late final FirebaseAnalyticsAdapter analyticsAdapter;

  static initialize({String? name, FirebaseOptions? options}) async {
    await Firebase.initializeApp(name: name, options: options);
  }

  static recordCrashlyticsError(Object error, StackTrace stackTrace, isFatal) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  }

  static recordCrashlyticsFlutterFatalError(
    FlutterErrorDetails flutterErrorDetails,
  ) async {
    await FirebaseCrashlytics.instance.recordFlutterFatalError(
      flutterErrorDetails,
    );
  }

  SolfacilFirebaseSDK() {
    _initializeApp();
  }

  Future _initializeApp() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final analytics = FirebaseAnalytics.instance;

      databaseAdapter = FirebaseDatabaseAdapter(firestore);
      analyticsAdapter = FirebaseAnalyticsAdapter(analytics);
      return true;
    } catch (e) {
      LogManager.shared.logError('FIREBASE_SDK: $e');
      return null;
    }
  }

  @override
  Future logSuccessLogin(
    String userId,
    String email, {
    Map<String, dynamic>? aditionalInfos,
  }) async {
    await analyticsAdapter.logLogin();
    await databaseAdapter.saveUserLogin(
      userId,
      email,
      aditionalInfos: aditionalInfos,
    );
    return;
  }

  @override
  Future setLogedUser({
    required String userId,
    required String email,
    required String name,
    Map<String, dynamic>? aditionalInfos,
  }) async {
    final infos = aditionalInfos ?? {};
    await analyticsAdapter.setUserId(userId);
    await analyticsAdapter.setUserProperty(name: 'email', value: email);
    await analyticsAdapter.setUserProperty(name: 'name', value: name);
    for (MapEntry<String, dynamic> info in infos.entries) {
      await analyticsAdapter.setUserProperty(name: info.key, value: info.value);
    }

    return;
  }

  @override
  Future removeUserData() async {
    await analyticsAdapter.setUserId(null);
    await analyticsAdapter.setUserProperty(name: 'email', value: null);
    await analyticsAdapter.setUserProperty(name: 'type', value: null);
    await analyticsAdapter.setUserProperty(name: 'category', value: null);
    return;
  }

  @override
  Future trackButtonClick(
    String btnName, {
    required Map<String, dynamic> infos,
  }) async {
    final eventName = '${btnName}_clicked';
    await analyticsAdapter.logEvents(
      eventName: eventName,
      eventInfos: infos,
    );

    return;
  }

  @override
  Future trackCustomEvent(
    String eventName, {
    required Map<String, dynamic> infos,
  }) async {
    await analyticsAdapter.logEvents(eventName: eventName, eventInfos: infos);
    return;
  }

  @override
  Future trackPageOpen(String pageName) async {
    await analyticsAdapter.setCurrentPage(pageName);

    return;
  }

  @override
  Future stopTrackPage(
    String pageName, {
    required Map<String, dynamic>? infos,
  }) async {
    if (infos != null) {
      await analyticsAdapter.logEvents(
        eventName: 'close_page_infos',
        eventInfos: infos,
      );
    }

    return;
  }

  Future sendData({
    required String collectionName,
    required Map<String, Object> info,
    String? path,
  }) async {
    final collection = await databaseAdapter.getCollection(collectionName);
    await databaseAdapter.addFieldToCollection(collection, info, path);
    return;
  }
}
