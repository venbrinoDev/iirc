import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {
  MockFirebaseCrashlytics() {
    when(
      () => recordError(
        any<dynamic>(),
        any(),
        information: any(named: 'information'),
        reason: any<dynamic>(named: 'reason'),
        printDetails: any(named: 'printDetails'),
        fatal: any(named: 'fatal'),
      ),
    ).thenAnswer((_) async => true);
  }
}

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {
  MockFirebaseAnalytics() {
    when(() => logEvent(name: any(named: 'name'), parameters: any(named: 'parameters'))).thenAnswer((_) async => true);
    when(() => setCurrentScreen(screenName: any(named: 'screenName'))).thenAnswer((_) async => true);
    when(() => setUserId(id: any(named: 'id'))).thenAnswer((_) async => true);
    when(() => setUserId(id: any(named: 'id'))).thenAnswer((_) async => true);
    when(() => setAnalyticsCollectionEnabled(any())).thenAnswer((_) async {});
  }
}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
