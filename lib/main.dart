import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;
   var _id;
   var _userid;
   var _title;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _id = snapshot.data!.id.toString();
          _userid = snapshot.data!.userId.toString();
          _title = snapshot.data!.title.toString();
          return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                  color: Colors.amber,
                  width: double.infinity,
                  height: 200,
                  child: Text(_id.toString(), style: TextStyle(fontSize: 25),)),
              Container(
                  color: Color.fromARGB(255, 19, 180, 67),
                  width: double.infinity,
                  height: 200,
                  child: Text(_userid.toString(), style: TextStyle(fontSize: 25),)),
              Container(
                  color: Color.fromARGB(255, 63, 44, 129),
                  width: double.infinity,
                  height: 200,
                  child: Text(_title.toString() , style: TextStyle(fontSize: 25),)),
            ],
          ),
          /* child: */
        ),
      ),
    );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
    
  }
}
