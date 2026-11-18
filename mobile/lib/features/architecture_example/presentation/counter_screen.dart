import 'package:material_ui/material_ui.dart';

import 'counter_controller.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late final CounterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CounterController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Little Ask')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListenableBuilder(
              listenable: _controller,
              builder: (context, child) => Text(
                'Counter: ${_controller.count}',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _controller.increment,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
