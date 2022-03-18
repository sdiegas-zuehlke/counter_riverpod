import 'package:counter_riverpod/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class Listener extends Mock {
  void call(int? previous, int value);
}

void main() {
  group('numberProvider Tests', () {
    test('defaults to 0 and notify listeners when value changes', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final listener = Listener();

      // Observe a provider and spy the changes.
      container.listen<int>(
        numberProvider,
        listener,
        fireImmediately: true,
      );

      // the listener is called immediately with 0, the default value
      verify(listener(null, 0)).called(1);
      verifyNoMoreInteractions(listener);

      // We increment the value
      container.read(numberProvider.notifier).state++;

      // The listener was called again, but with 1 this time
      verify(listener(0, 1)).called(1);
      verifyNoMoreInteractions(listener);
    });
  });
}
