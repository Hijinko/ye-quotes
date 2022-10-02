import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const YeQuotes();
  }
}

class YeQuotes extends StatefulWidget {
  const YeQuotes({Key? key}) : super(key: key);

  @override
  State<YeQuotes> createState() => _YeQuotes();
}

class _YeQuotes extends State<YeQuotes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Ye Quotes',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ye Quotes'),
        ),
        body: const Center(
          child: Text(
            'Ye Quotes',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
