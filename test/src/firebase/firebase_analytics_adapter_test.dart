import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solfacil_firebase_sdk/src/adapters/adapters.dart';

import '../../doubles/mocks/firebase_analytics_mock.dart';

main() {
  final FirebaseAnalytics analytics = FirebaseAnalyticsMock();
  final FirebaseAnalyticsAdapter adapter = FirebaseAnalyticsAdapter(analytics);

  test('Log Events', () async {
    // Arrange
    when(() => analytics.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        )).thenAnswer((_) async => true);

    const eventName = 'event';
    const eventInfos = {'name': 'teste'};

    // Act
    await adapter.logEvents(eventName: eventName, eventInfos: eventInfos);

    // Assert
    verify(() => analytics.logEvent(name: eventName, parameters: eventInfos))
        .called(1);
  });

  test('Set default parameters', () async {
    // Arrange
    when(() => analytics.setDefaultEventParameters(any()))
        .thenAnswer((_) async => true);
    const defaultInfos = {'name': 'teste'};

    // Act
    await adapter.setDefaultParameters(defaultInfos);

    // Assert
    verify(() => analytics.setDefaultEventParameters(defaultInfos)).called(1);
  });

  test('Set User property', () async {
    // Arrange
    when(() => analytics.setUserProperty(
          name: any(named: 'name'),
          value: any(named: 'value'),
        )).thenAnswer((_) async => true);
    const propertyName = 'name';
    const propertyValue = '10';

    // Act
    await adapter.setUserProperty(name: propertyName, value: propertyValue);

    // Assert
    verify(() => analytics.setUserProperty(
          name: propertyName,
          value: propertyValue,
        )).called(1);
  });

  test('Set User Id', () async {
    // Arrange
    when(() => analytics.setUserId(id: any(named: 'id')))
        .thenAnswer((_) async => true);
    const userId = '10';

    // Act
    await adapter.setUserId(userId);

    // Assert
    verify(() => analytics.setUserId(id: userId)).called(1);
  });

  test('Log login', () async {
    // Arrange
    when(() => analytics.logLogin()).thenAnswer((_) async => true);

    // Act
    await adapter.logLogin();

    // Assert
    verify(() => analytics.logLogin()).called(1);
  });

  test('Set current page', () async {
    // Arrange
    when(() => analytics.setCurrentScreen(
            screenName: any(named: 'screenName'),
            screenClassOverride: any(named: 'screenClassOverride')))
        .thenAnswer((_) async => true);
    const pageName = 'pageName';

    // Act
    await adapter.setCurrentPage(pageName);

    // Assert
    verify(() => analytics.setCurrentScreen(
        screenName: pageName, screenClassOverride: pageName)).called(1);
  });
}
