import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

final numberProvider = StateProvider.autoDispose<int>((ref) => 0);

final motivationalTextProvider = Provider.autoDispose<String>((ref) {
  final numberValue = ref.watch(numberProvider);
  if (numberValue < 11) {
    return "Not enough stay tuned!";
  } else if (numberValue < 21) {
    return "Not bad, come there is possible even more!";
  } else {
    return "Ok you can stop now!";
  }
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberState = ref.watch(numberProvider);
    final motivationalText = ref.watch(motivationalTextProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              motivationalText,
            ),
            Text(
              '$numberState',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(ref),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter(WidgetRef ref) {
    ref.watch(numberProvider.state).state++;
  }
}
