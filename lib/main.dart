// ignore_for_file: avoid_print

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

TextEditingController name = TextEditingController();
List<String>? history = [];
String? v;

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    insp();
    super.initState();
  }

  Future insp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    history = sp.getStringList('v') ?? [];
    print(history);
  }

  Future add(String v) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      if (history!.length < 3) {
        history!.add(v);
        sp.setStringList('v', history!);
        history = sp.getStringList('v');
        print("$history");
      } else {
        history!.removeAt(0);
        history!.add(v);
        sp.setStringList('v', history!);
        history = sp.getStringList('v');
        print("$history");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search App Bar"),
        titleSpacing: 150,
      ),
      body: Column(
        children: [
              Container(
                margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                child: TextField(
                  controller: name,
                  onChanged: (value) {
                    v = value;
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            add(name.text.toString());
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(itemCount: history == null?1:history!.length,itemBuilder: (context, index) {
                  if(history == null){
                    return Text("ຄົນຫາ");
                  }else{
                    return Text(history![index].toString());
                  }
                },),
              )
            ],
      ),
    );
  }
}
