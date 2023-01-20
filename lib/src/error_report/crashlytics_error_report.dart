part of solfacil_tools_sdk;

class CrashlyticsErrorReport extends IErrorReport {
  late final FirebaseCrashlyticsAdapter crashlyticsAdapter;

  CrashlyticsErrorReport() {
    try {
      final crashlytics = FirebaseCrashlytics.instance;
      crashlyticsAdapter = FirebaseCrashlyticsAdapter(crashlytics);
    } catch (e) {
      LogManager.shared.logError('CRASHLYTICS_SDK: $e');
    }
  }

  @override
  Future recordException({
    required Exception exception,
    required StackTrace stack,
    required String reason,
    int? errorCode,
    bool printDebugLog = true,
  }) async {
    try {
      return crashlyticsAdapter.recordError(
        exception: exception,
        stack: stack,
        reason: reason,
        errorCode: errorCode,
        printDebugLog: printDebugLog,
      );
    } catch (e) {
      LogManager.shared.logError('CRASHLYTICS_SDK: $e');
      return null;
    }
  }
}
