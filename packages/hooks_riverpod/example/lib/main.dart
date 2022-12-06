import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('demo'),
      ),
      body: const _Body(),
    );
  }
}

final provider = StateProvider.autoDispose<int>((ref) {
  ref.onDispose(() {
    print('${DateTime.now()}: disposed!');
  });

  print('${DateTime.now()}: created!');
  return 0;
});

class _Body extends HookConsumerWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showButton = useState(false);

    return ProviderScope(
      child: ProviderScope(
        child: ProviderScope(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showButton.value = !showButton.value;
                  },
                  child: const Text('Toggle Button'),
                ),
                if (showButton.value) const SampleWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SampleWidget extends ConsumerWidget {
  const SampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(provider);

    return ElevatedButton(
      child: Text('$value'),
      onPressed: () {
        ref.read(provider.notifier).state = 1;
      },
    );
  }
}
