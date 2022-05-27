// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

TextEditingController textController = TextEditingController();
List<String>? history = [];
String? getValue;

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    addHistory();
    super.initState();
  }

  Future addHistory() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    history = spf.getStringList('getValue') ?? [];
    print(history);
  }

  Future addRemove(String getValue) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    setState(() {
      if (history!.length < 3) {
        history!.add(getValue);
        spf.setStringList('getValue', history!);
        history = spf.getStringList('getValue');
      } else {
        history!.removeAt(0);
        history!.add(getValue);
        spf.setStringList('getValue', history!);
        history = spf.getStringList('getValue');

      }
    });
  }

  Future delete(int index) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    setState(() {
      history!.removeAt(index);
      spf.setStringList("getValue", history!);
      history = spf.getStringList('getValue');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search App Bar"),
        titleSpacing: 200,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:  history!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${history![index].toString()}",
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            delete(index);
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  addRemove(textController.text.toString());
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ],
      ),
    );
  }
}
