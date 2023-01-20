import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solfacil_firebase_sdk/src/firebase/firebase.dart';

import '../../doubles/mocks/firebase_crashlytics_mock.dart';

main() {
  final FirebaseCrashlytics crashlytics = FirebaseCrashlyticsMock();
  final FirebaseCrashlyticsAdapter adapter =
      FirebaseCrashlyticsAdapter(crashlytics);

  final tException = Exception();
  final tStackTrace = StackTrace.fromString('stackTraceString');
  const tReason = 'reason';

  test('Record error without error code', () async {
    // Arrange
    when(() => crashlytics.recordError(any(), any(),
            reason: any(named: 'reason'),
            printDetails: any(named: 'printDetails')))
        .thenAnswer((invocation) async => true);
    when(() => crashlytics.setCustomKey(any(), any()))
        .thenAnswer((invocation) async => true);

    // Act
    await adapter.recordError(
      exception: tException,
      stack: tStackTrace,
      reason: tReason,
    );

    // Assert
    verify(() => crashlytics.recordError(tException, tStackTrace,
        reason: tReason, printDetails: true)).called(1);
    verify(() => crashlytics.setCustomKey('error_message', tReason)).called(1);
    verifyNever(() => crashlytics.setCustomKey('error_code', any()));
  });

  test('Record error with error code', () async {
    // Arrange
    when(() => crashlytics.recordError(any(), any(),
            reason: any(named: 'reason'),
            printDetails: any(named: 'printDetails')))
        .thenAnswer((invocation) async => true);
    when(() => crashlytics.setCustomKey(any(), any()))
        .thenAnswer((invocation) async => true);

    // Act
    await adapter.recordError(
        exception: tException,
        stack: tStackTrace,
        reason: tReason,
        errorCode: 10,
        printDebugLog: false);

    // Assert
    verify(() => crashlytics.recordError(tException, tStackTrace,
        reason: tReason, printDetails: false)).called(1);
    verify(() => crashlytics.setCustomKey('error_message', tReason)).called(1);
    verify(() => crashlytics.setCustomKey('error_code', 10)).called(1);
  });
}
