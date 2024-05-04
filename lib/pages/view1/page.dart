import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';


class CatFactsPage extends StatefulWidget {
  const CatFactsPage({Key? key}) : super(key: key);

  @override
  CatFactsPageState createState() => CatFactsPageState();
}


class CatFactsPageState extends State<CatFactsPage> {
  String catFact = "Loading cat fact...";

  @override
  void initState() {
    super.initState();
    fetchCatFact();
  }

  Future<void> fetchCatFact() async {
    const String url = 'https://cat-fact.herokuapp.com/facts';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> facts = jsonDecode(response.body) as List<dynamic>;
        if (facts.isNotEmpty) {
          setState(() {
            int randomIndex = Random().nextInt(facts.length);
            catFact = facts[randomIndex]['text'];
          });
        }
        print(facts[Random().nextInt(facts.length)]);
      } else {
        throw Exception('Failed to load cat facts');
      }
    } catch (e) {
      setState(() {
        catFact = "Failed to load fact.";
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat facts'),
        centerTitle: true,
      ),
      body: Center(
        child: CatFactCard(
          imageUrl: 'https://cataas.com/cat?type=square',
          fact: catFact,
        ),
      ),
      backgroundColor: const Color(0xFFEEEEF5),
    );
  }
}


class CatFactCard extends StatelessWidget {
  final String imageUrl;
  final String fact;

  const CatFactCard({
    Key? key,
    required this.imageUrl,
    required this.fact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var maxImageSize = 0.7 * [size.width, size.height].reduce(min);

    return  ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(),
            Image.network(
              imageUrl,
              fit: BoxFit.contain,
              height: maxImageSize,
              width: maxImageSize,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                fact,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,  
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
          ],
        ),
      )
    );
  }
}
