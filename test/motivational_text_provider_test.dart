import 'package:counter_riverpod/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class NumberListener extends Mock {
  void call(int? previous, int value);
}

class MotivationalTextListener extends Mock {
  void call(String? previous, String value);
}

void main() {
  group('motivationalTextProvider Tests', () {
    test('Init state with all steps', () async {
      final container = ProviderContainer();
      final numberListener = NumberListener();
      final motivationalTextListener = MotivationalTextListener();

      container.listen<int>(
        numberProvider,
        numberListener,
        fireImmediately: true,
      );

      container.listen<String>(
        motivationalTextProvider,
        motivationalTextListener,
        fireImmediately: true,
      );

      verify(numberListener(null, 0)).called(1);
      verify(motivationalTextListener(null, "Not enough stay tuned!"))
          .called(1);
      verifyNoMoreInteractions(numberListener);
      verifyNoMoreInteractions(motivationalTextListener);

      // We set the value to 12
      container.read(numberProvider.notifier).state = 12;

      // We add a delay here, it takes a little time until the motivationalTextProvider gets notified that numberProvider changed state
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // The listener was called again, but with 1 this time
      verify(numberListener(0, 12)).called(1);
      verify(motivationalTextListener("Not enough stay tuned!",
              "Not bad, come there is possible even more!"))
          .called(1);
      verifyNoMoreInteractions(numberListener);
      verifyNoMoreInteractions(motivationalTextListener);

      // We set the value to 25
      container.read(numberProvider.notifier).state = 25;

      // We add a delay here, it takes a little time until the motivationalTextProvider gets notified that numberProvider changed state
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // The listener was called again, but with 1 this time
      verify(numberListener(12, 25)).called(1);
      verify(motivationalTextListener(
              "Not bad, come there is possible even more!",
              "Ok you can stop now!"))
          .called(1);
      verifyNoMoreInteractions(numberListener);
      verifyNoMoreInteractions(motivationalTextListener);
    });
  });
}
