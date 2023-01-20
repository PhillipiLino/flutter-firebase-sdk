part of solfacil_tools_sdk;

class FirebaseCrashlyticsAdapter {
  final FirebaseCrashlytics crashlytics;

  FirebaseCrashlyticsAdapter(this.crashlytics);

  Future recordError({
    required Exception exception,
    required StackTrace stack,
    required String reason,
    int? errorCode,
    bool printDebugLog = true,
  }) {
    crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      printDetails: printDebugLog,
    );

    if (errorCode != null) {
      crashlytics.setCustomKey('error_code', errorCode);
    }

    return crashlytics.setCustomKey('error_message', reason);
  }
}
