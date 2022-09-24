// settings.dart
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:random_verse/provider/quotelist.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Text(
          'WIP',
          style: TextStyle(fontSize: 30),
        ),
        TextButton(
          onPressed: () => context.read<QuoteList>().restoreDefaults(),
          child: const Text('Reset Shared Prefs'),
        )
      ],
    ));
  }
}
