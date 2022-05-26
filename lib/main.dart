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
List<String>?history=[];
String? v;

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState(){
   insp();
super.initState();
  }
Future insp()async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  history = sp.getStringList('v');
  print(history);
}
 Future add(String v)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState((){
    if(history!.length <3){
      history!.add(v);
      sp.setStringList('v', history!);
      history = sp.getStringList('v');
      print("$history"+"add");
    }else{
      history!.removeLast();
      sp.setStringList('v', history!);
      history = sp.getStringList('v');
      print("$history"+"remove");
    }



    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(children: [
      TextField(
        controller: name ,
        onChanged: (value){
          v = value;
        },
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                add(name.text.toString());
              }, icon: Icon(Icons.add)),
            ],
          ),
        ],
      ),
    ],
    ),
    );
  }
}

