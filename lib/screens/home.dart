// screen_a.dart
import 'package:flutter/material.dart';
import 'package:random_verse/provider/quotelist.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     () => context.read<QuoteList>().getRandom();
  //   });
  // }
  @override
  void initState() {
    // context.read<QuoteList>().genRandom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: CurrentQuote(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<QuoteList>().genRandom(),
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class CurrentQuote extends StatelessWidget {
  const CurrentQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(context.watch<QuoteList>().random,
          key: const Key('quoteState'), style: const TextStyle(fontSize: 30)),
    );
  }
}
