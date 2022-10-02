import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

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
  Future<String> fetchQuote() async {
    final Uri uri = Uri.parse('https://api.kanye.rest/');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final quote = jsonDecode(res.body);
      return quote['quote'];
    } else {
      return "Sorry error getting the quote. Make sure you are connected to the internet";
    }
  }

  late Future<String> _quote;

  @override
  void initState() {
    super.initState();
    _quote = fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Ye Quotes',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ye Quotes'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<String>(
                      future: _quote,
                      builder: (context, quote) {
                        if (quote.hasData) {
                          return Text(
                            '"${quote.data!}"',
                            style: GoogleFonts.yesevaOne(fontSize: 40),
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '- Kanye West',
                          style: GoogleFonts.satisfy(fontSize: 25),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 80),
                        backgroundColor: Colors.grey.shade900,
                      ),
                      onPressed: () => setState(() {
                        _quote = fetchQuote();
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.update),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Get Another Quote',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
