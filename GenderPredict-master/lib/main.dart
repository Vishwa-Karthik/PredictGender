import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gender Predictor',
      home: HomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  var result;

  predictGender(String name) async {
    var url = Uri.parse("https://api.genderize.io/?name=$name");
    var res = await http.get(url);
    var body = json.decode(res.body);

    result =
        "Gender: ${body['gender']}, Probability: ${body['probability']}, Count: ${body['count']}";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Vishwa Karthik'),
              accountEmail: Text('vishwa.prarthana@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.ac_unit),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Predict Gender'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Enter Name To Predict :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => predictGender(nameController.text),
              child: Text('PREDICT'),
            ),
            if (result != null) Text(result),
          ],
        ),
      ),
    );
  }
}
