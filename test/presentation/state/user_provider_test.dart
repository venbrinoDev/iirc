import 'package:flutter_test/flutter_test.dart';
import 'package:iirc/core.dart';
import 'package:iirc/data.dart';
import 'package:iirc/domain.dart';
import 'package:iirc/presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils.dart';

Future<void> main() async {
  group('UserProvider', () {
    final UserEntity dummyUser = UsersMockImpl.user;

    tearDown(mockUseCases.reset);

    Future<UserEntity> createProviderFuture() {
      final AccountEntity dummyAccount = AuthMockImpl.generateAccount();
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          accountProvider.overrideWith((_) async => dummyAccount),
        ],
      );
      addTearDown(container.dispose);
      return container.read(userProvider.future);
    }

    test('should get current user', () async {
      when(() => mockUseCases.fetchUserUseCase.call(any())).thenAnswer((_) async => dummyUser);

      expect(createProviderFuture(), completion(dummyUser));
    });

    test('should throw on empty current user', () async {
      when(() => mockUseCases.fetchUserUseCase.call(any())).thenAnswer((_) async => null);

      expect(createProviderFuture, throwsA(isA<AppException>()));
    });
  });
}
