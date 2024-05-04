import 'package:flutter/material.dart';
import 'pages/view1/page.dart'; // Make sure to import the new View1Page page

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Flutter Playground'),
        ),
        backgroundColor: const Color(0xFFEEEEF5),
        body: Center(
          child: Builder( // This Builder provides a context below MaterialApp
            builder: (context) => ListView(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              children: [
                MenuButton(title: '1. Cat Facts (Responsive Centered Card)', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CatFactsPage()),
                  );
                }),
                MenuButton(title: 'View 2', onTap: () => print('View 2 selected')),
                MenuButton(title: 'View 3', onTap: () => print('View 3 selected')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MenuButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(title),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), // makes the button wide
        ),
      ),
    );
  }
}
